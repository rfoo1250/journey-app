import 'package:drift/drift.dart' show Value;
import 'package:geolocator/geolocator.dart' show Position;
import 'package:journey/core/db/database.dart';
import 'package:journey/features/trips/domain/trip.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trip_repository.g.dart';

/// Façade over the drift `TripsDao`. Maps rows to the domain [Trip] so
/// other features never import drift.
class TripRepository {
  new(this._db);

  final AppDatabase _db;

  Stream<List<Trip>> watchAll() =>
      _db.tripsDao.watchAll().map((rows) => rows.map(_toDomain).toList());

  Stream<Trip?> watchById(String id) =>
      _db.tripsDao.watchById(id).map((r) => r == null ? null : _toDomain(r));

  Future<int> delete(String id) => _db.tripsDao.deleteById(id);

  /// Creates an `in_progress` row when recording starts (PLAN.md §4.1).
  Future<void> createInProgress({
    required String id,
    required DateTime startedAt,
  }) => _db.tripsDao.upsert(
    TripsCompanion.insert(
      id: id,
      startedAt: startedAt.millisecondsSinceEpoch,
      status: TripStatus.inProgress,
      createdAt: DateTime.now().toUtc().millisecondsSinceEpoch,
    ),
  );

  /// Appends raw fixes; called every ~10 s / 20 points while recording.
  Future<void> appendPoints(String tripId, List<Position> fixes) =>
      _db.tripsDao.addPoints([
        for (final f in fixes)
          TripPointsCompanion.insert(
            tripId: tripId,
            ts: f.timestamp.millisecondsSinceEpoch,
            lat: f.latitude,
            lon: f.longitude,
            accuracyM: Value(f.accuracy),
            speedMps: Value(f.speed),
            headingDeg: Value(f.heading),
            altitudeM: Value(f.altitude),
          ),
      ]);

  /// Marks the trip complete with the raw-trace stats known at Stop.
  /// Duration is last fix − first fix (PLAN.md §4.2), not Stop − Start: iOS
  /// can deliver a cached first fix stamped before Start was pressed.
  /// Map matching (M3) later fills the matched fields.
  Future<void> finish({
    required String id,
    required DateTime endedAt,
    required double distanceM,
    required String rawPolyline6,
    DateTime? firstFixAt,
    DateTime? lastFixAt,
    ({double lat, double lon})? start,
    ({double lat, double lon})? end,
  }) async {
    final row = await _db.tripsDao.getById(id);
    if (row == null) return;
    final durationS = firstFixAt != null && lastFixAt != null
        ? lastFixAt.difference(firstFixAt).inSeconds
        : 0;
    await _db.tripsDao.upsert(
      row
          .toCompanion(false)
          .copyWith(
            endedAt: Value(endedAt.millisecondsSinceEpoch),
            status: const Value(TripStatus.complete),
            matchStatus: const Value(MatchStatus.unmatched),
            distanceM: Value(distanceM),
            durationS: Value(durationS),
            rawPolyline6: Value(rawPolyline6),
            startLat: Value(start?.lat),
            startLon: Value(start?.lon),
            endLat: Value(end?.lat),
            endLon: Value(end?.lon),
          ),
    );
  }

  Future<List<TripPointRow>> points(String tripId) =>
      _db.tripsDao.pointsFor(tripId);

  static Trip _toDomain(TripRow r) => Trip(
    id: r.id,
    startedAt: _utc(r.startedAt),
    endedAt: r.endedAt == null ? null : _utc(r.endedAt!),
    status: r.status,
    matchStatus: r.matchStatus,
    distanceM: r.distanceM,
    durationS: r.durationS,
    movingS: r.movingS,
    avgSpeedMps: r.avgSpeedMps,
    maxSpeedMps: r.maxSpeedMps,
    startLat: r.startLat,
    startLon: r.startLon,
    endLat: r.endLat,
    endLon: r.endLon,
    startPlace: r.startPlace,
    endPlace: r.endPlace,
    rawPolyline6: r.rawPolyline6,
    matchedPolyline6: r.matchedPolyline6,
    createdAt: _utc(r.createdAt),
  );

  static DateTime _utc(int epochMs) =>
      DateTime.fromMillisecondsSinceEpoch(epochMs, isUtc: true);
}

@riverpod
TripRepository tripRepository(Ref ref) =>
    TripRepository(ref.watch(appDatabaseProvider));

@riverpod
Stream<List<Trip>> tripList(Ref ref) =>
    ref.watch(tripRepositoryProvider).watchAll();
