import 'package:journey/core/db/tables.dart' show MatchStatus;
import 'package:journey/core/geo/distance.dart';
import 'package:journey/core/geo/fix.dart';
import 'package:journey/core/geo/gps_filter.dart';
import 'package:journey/core/geo/kalman.dart';
import 'package:journey/core/geo/polyline6.dart';
import 'package:journey/core/geo/simplify.dart';
import 'package:journey/core/result.dart';
import 'package:journey/core/services/valhalla_client.dart';
import 'package:journey/features/trips/data/trip_repository.dart';
import 'package:journey/features/trips/domain/trip.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trip_processor.g.dart';

/// Runs the geo pipeline (docs/PLAN.md §4.2) for one trip and persists the
/// outcome:
///
/// raw points → GpsFilter → Kalman → Simplify → Valhalla trace_route
///   → matched: distance along matched line, `matched`
///   → unreachable: distance along simplified raw trace, `unmatched` (retry)
///   → unusable input / bad response: `failed`
///
/// Speed stats always come from the filtered raw fixes.
class TripProcessor {
  new({required this._trips, required this._valhalla, Logger? log})
    : _log = log ?? Logger();

  final TripRepository _trips;
  final ValhallaClient _valhalla;
  final Logger _log;

  /// Speed above which the vehicle counts as moving (m/s).
  static const movingThresholdMps = 1.0;

  Future<Result<Trip>> process(String tripId) async {
    final trip = await _trips.getById(tripId);
    if (trip == null) {
      return Result.err(InvalidInputError('Trip $tripId not found'));
    }

    final rows = await _trips.points(tripId);
    final raw = [
      for (final r in rows)
        Fix(
          ts: DateTime.fromMillisecondsSinceEpoch(r.ts, isUtc: true),
          lat: r.lat,
          lon: r.lon,
          accuracyM: r.accuracyM,
          speedMps: r.speedMps,
          headingDeg: r.headingDeg,
          altitudeM: r.altitudeM,
        ),
    ];

    final filtered = GpsFilter.apply(raw, sessionStart: trip.startedAt);
    final simplified = Simplify.rdp(Kalman.smooth(filtered));
    final rawTrace = [for (final f in simplified) f.point];
    final stats = _Stats.from(filtered);

    if (simplified.length < ValhallaClient.minPoints) {
      _log.w('trip $tripId: ${filtered.length} usable fixes, cannot match');
      await _persist(
        tripId,
        status: MatchStatus.failed,
        distanceM: Distance.along(rawTrace),
        rawTrace: rawTrace,
        matched: null,
        stats: stats,
      );
      return await _reload(tripId);
    }

    final match = await _valhalla.traceRoute(
      simplified,
      gpsAccuracyM: _median([for (final f in filtered) f.accuracyM ?? 10]),
    );

    switch (match) {
      case Ok(:final value):
        _log.i(
          'trip $tripId matched: ${simplified.length} → '
          '${value.points.length} pts, ${value.lengthM.round()} m',
        );
        await _persist(
          tripId,
          status: MatchStatus.matched,
          distanceM: Distance.along(value.points),
          rawTrace: rawTrace,
          matched: value,
          stats: stats,
        );
      case Err(:final error):
        final status = switch (error) {
          NetworkError() => MatchStatus.unmatched, // retry later
          _ => MatchStatus.failed,
        };
        _log.w('trip $tripId not matched ($status): ${error.message}');
        await _persist(
          tripId,
          status: status,
          distanceM: Distance.along(rawTrace),
          rawTrace: rawTrace,
          matched: null,
          stats: stats,
        );
    }
    return await _reload(tripId);
  }

  /// Re-runs [process] for every trip still marked `unmatched`.
  Future<int> retryUnmatched() async {
    final pending = await _trips.unmatched();
    var matched = 0;
    for (final t in pending) {
      final r = await process(t.id);
      if (r.valueOrNull?.matchStatus == MatchStatus.matched) matched++;
    }
    return matched;
  }

  Future<void> _persist(
    String id, {
    required MatchStatus status,
    required double distanceM,
    required List<({double lat, double lon})> rawTrace,
    required MatchedRoute? matched,
    required _Stats stats,
  }) => _trips.applyProcessing(
    id: id,
    matchStatus: status,
    distanceM: distanceM,
    durationS: stats.durationS,
    movingS: stats.movingS,
    avgSpeedMps: stats.movingS > 0 ? distanceM / stats.movingS : null,
    maxSpeedMps: stats.maxSpeedMps,
    rawPolyline6: Polyline6.encode(rawTrace),
    matchedPolyline6: matched?.polyline6,
    start: rawTrace.firstOrNull,
    end: rawTrace.lastOrNull,
  );

  Future<Result<Trip>> _reload(String id) async {
    final t = await _trips.getById(id);
    return t == null
        ? Result.err(StorageError('Trip $id vanished during processing'))
        : Result.ok(t);
  }

  static double _median(List<double> xs) {
    if (xs.isEmpty) return 10;
    final s = List.of(xs)..sort();
    final m = s.length ~/ 2;
    return s.length.isOdd ? s[m] : (s[m - 1] + s[m]) / 2;
  }
}

/// Duration, moving time and max speed from the filtered raw fixes.
class _Stats {
  const new({
    required this.durationS,
    required this.movingS,
    required this.maxSpeedMps,
  });

  factory from(List<Fix> fixes) {
    if (fixes.length < 2) {
      return const _Stats(durationS: 0, movingS: 0, maxSpeedMps: null);
    }
    var moving = Duration.zero;
    double? maxSpeed;
    for (var i = 1; i < fixes.length; i++) {
      final speed = fixes[i].speedMps;
      if (speed != null) {
        if (speed > TripProcessor.movingThresholdMps) {
          moving += fixes[i].ts.difference(fixes[i - 1].ts);
        }
        if (maxSpeed == null || speed > maxSpeed) maxSpeed = speed;
      }
    }
    return _Stats(
      durationS: fixes.last.ts.difference(fixes.first.ts).inSeconds,
      movingS: moving.inSeconds,
      maxSpeedMps: maxSpeed,
    );
  }

  final int durationS;
  final int movingS;
  final double? maxSpeedMps;
}

@Riverpod(keepAlive: true)
TripProcessor tripProcessor(Ref ref) => TripProcessor(
  trips: ref.watch(tripRepositoryProvider),
  valhalla: ref.watch(valhallaClientProvider),
);
