import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:journey/core/geo/distance.dart';
import 'package:journey/core/geo/polyline6.dart';
import 'package:journey/features/recording/data/location_repository.dart';
import 'package:journey/features/recording/domain/recording_config.dart';
import 'package:journey/features/recording/domain/recording_state.dart';
import 'package:journey/features/trips/data/trip_repository.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'recording_controller.g.dart';

/// THE recording state machine (docs/PLAN.md §4.1). Owns the position
/// subscription, creates the `in_progress` trip, buffers fixes and flushes
/// them to `trip_points` every [RecordingConfig.flushInterval] or
/// [RecordingConfig.flushEvery] points, and finalizes the trip on Stop.
@Riverpod(keepAlive: true)
class RecordingController extends _$RecordingController {
  StreamSubscription<Position>? _sub;
  Timer? _flushTimer;
  final List<Position> _pending = [];
  Future<void> _flushing = Future.value();
  final _log = Logger();

  @override
  RecordingState build() {
    ref.onDispose(_teardown);
    return const RecordingState.idle();
  }

  /// idle | error → requestingPermission → recording | error
  Future<void> start() async {
    if (state is! RecordingIdle && state is! RecordingError) return;
    state = const RecordingState.requestingPermission();

    final location = ref.read(locationRepositoryProvider);
    final access = await location.ensurePermission();
    final failure = switch (access) {
      LocationAccess.granted => null,
      LocationAccess.denied => RecordingErrorKind.permissionDenied,
      LocationAccess.deniedForever =>
        RecordingErrorKind.permissionDeniedForever,
      LocationAccess.serviceDisabled =>
        RecordingErrorKind.locationServiceDisabled,
    };
    if (failure != null) {
      state = RecordingState.error(kind: failure);
      return;
    }

    final tripId = const Uuid().v4();
    final startedAt = DateTime.now().toUtc();
    await ref
        .read(tripRepositoryProvider)
        .createInProgress(id: tripId, startedAt: startedAt);
    _log.i('trip $tripId started');

    state = RecordingState.recording(tripId: tripId, startedAt: startedAt);
    _sub = location.positions().listen(_onFix, onError: _onStreamError);
    _flushTimer = Timer.periodic(
      ref.read(recordingConfigProvider).flushInterval,
      (_) => _flush(),
    );
  }

  /// recording → paused. Keeps the subscription so the foreground service
  /// (and its notification) stays alive; fixes are ignored while paused.
  void pause() {
    final s = state;
    if (s is! RecordingActive) return;
    state = RecordingState.paused(
      tripId: s.tripId,
      startedAt: s.startedAt,
      fixCount: s.fixCount,
      lastFix: s.lastFix,
      trace: s.trace,
    );
  }

  /// paused → recording
  void resume() {
    final s = state;
    if (s is! RecordingPaused) return;
    state = RecordingState.recording(
      tripId: s.tripId,
      startedAt: s.startedAt,
      fixCount: s.fixCount,
      lastFix: s.lastFix,
      trace: s.trace,
    );
  }

  /// recording | paused → processing → idle
  Future<void> stop() async {
    final s = state;
    final (tripId, startedAt, trace, lastFix) = switch (s) {
      RecordingActive(
        :final tripId,
        :final startedAt,
        :final trace,
        :final lastFix,
      ) =>
        (tripId, startedAt, trace, lastFix),
      RecordingPaused(
        :final tripId,
        :final startedAt,
        :final trace,
        :final lastFix,
      ) =>
        (tripId, startedAt, trace, lastFix),
      _ => (null, null, null, null),
    };
    if (tripId == null || startedAt == null || trace == null) return;

    _teardown();
    state = RecordingState.processing(tripId: tripId, startedAt: startedAt);

    await _flush();
    await ref
        .read(tripRepositoryProvider)
        .finish(
          id: tripId,
          endedAt: lastFix?.timestamp.toUtc() ?? DateTime.now().toUtc(),
          distanceM: Distance.along(trace),
          rawPolyline6: Polyline6.encode(trace),
          start: trace.firstOrNull,
          end: trace.lastOrNull,
        );
    _log.i('trip $tripId finished: ${trace.length} points');
    // TODO(M3): TripProcessor.process(tripId)
    state = const RecordingState.idle();
  }

  /// error → idle
  void dismissError() {
    if (state is RecordingError) state = const RecordingState.idle();
  }

  void _onFix(Position p) {
    final s = state;
    if (s is! RecordingActive) return; // paused or stopping
    _log.d(
      'fix ${p.timestamp.toIso8601String()} '
      '${p.latitude.toStringAsFixed(6)},${p.longitude.toStringAsFixed(6)} '
      '±${p.accuracy.toStringAsFixed(1)}m '
      '${p.speed.toStringAsFixed(1)}m/s hdg ${p.heading.toStringAsFixed(0)}',
    );
    _pending.add(p);
    state = s.copyWith(
      fixCount: s.fixCount + 1,
      lastFix: p,
      trace: [...s.trace, (lat: p.latitude, lon: p.longitude)],
    );
    if (_pending.length >= ref.read(recordingConfigProvider).flushEvery) {
      unawaited(_flush());
    }
  }

  /// Writes buffered fixes. Serialized so a timer tick and a count trigger
  /// never interleave; safe to call when nothing is pending.
  Future<void> _flush() {
    final s = state;
    final tripId = switch (s) {
      RecordingActive(:final tripId) => tripId,
      RecordingPaused(:final tripId) => tripId,
      RecordingProcessing(:final tripId) => tripId,
      _ => null,
    };
    if (tripId == null || _pending.isEmpty) return _flushing;
    final batch = List<Position>.of(_pending);
    _pending.clear();
    return _flushing = _flushing.then((_) async {
      try {
        await ref.read(tripRepositoryProvider).appendPoints(tripId, batch);
      } on Object catch (e, st) {
        _log.e(
          'flush failed; ${batch.length} fixes lost',
          error: e,
          stackTrace: st,
        );
      }
    });
  }

  void _onStreamError(Object e, StackTrace st) {
    _log.e('position stream failed', error: e, stackTrace: st);
    _teardown();
    state = RecordingState.error(
      kind: RecordingErrorKind.streamFailure,
      message: e.toString(),
    );
  }

  /// Detaches the listener and timer synchronously. The cancel future is not
  /// awaited: it never resolves under flutter_test's fake async, and
  /// geolocator stops the platform stream as soon as the listener is gone.
  void _teardown() {
    unawaited(_sub?.cancel());
    _sub = null;
    _flushTimer?.cancel();
    _flushTimer = null;
  }
}
