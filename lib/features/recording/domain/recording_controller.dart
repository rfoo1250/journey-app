import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:journey/features/recording/data/location_repository.dart';
import 'package:journey/features/recording/domain/recording_state.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'recording_controller.g.dart';

/// THE recording state machine (docs/PLAN.md §4.1). Owns the position
/// subscription. Persistence of fixes arrives in M2; here every accepted fix
/// is counted and logged.
@Riverpod(keepAlive: true)
class RecordingController extends _$RecordingController {
  StreamSubscription<Position>? _sub;
  final _log = Logger();

  @override
  RecordingState build() {
    ref.onDispose(_cancel);
    return const RecordingState.idle();
  }

  /// idle | error → requestingPermission → recording | error
  Future<void> start() async {
    if (state is! RecordingIdle && state is! RecordingError) return;
    state = const RecordingState.requestingPermission();

    final repo = ref.read(locationRepositoryProvider);
    final access = await repo.ensurePermission();
    switch (access) {
      case LocationAccess.granted:
        break;
      case LocationAccess.denied:
        state = const RecordingState.error(
          kind: RecordingErrorKind.permissionDenied,
        );
        return;
      case LocationAccess.deniedForever:
        state = const RecordingState.error(
          kind: RecordingErrorKind.permissionDeniedForever,
        );
        return;
      case LocationAccess.serviceDisabled:
        state = const RecordingState.error(
          kind: RecordingErrorKind.locationServiceDisabled,
        );
        return;
    }

    state = RecordingState.recording(startedAt: DateTime.now().toUtc());
    _sub = repo.positions().listen(_onFix, onError: _onStreamError);
  }

  /// recording → paused. Keeps the subscription so the foreground service
  /// (and its notification) stays alive; fixes are ignored while paused.
  void pause() {
    final s = state;
    if (s is! RecordingActive) return;
    state = RecordingState.paused(
      startedAt: s.startedAt,
      fixCount: s.fixCount,
      lastFix: s.lastFix,
    );
  }

  /// paused → recording
  void resume() {
    final s = state;
    if (s is! RecordingPaused) return;
    state = RecordingState.recording(
      startedAt: s.startedAt,
      fixCount: s.fixCount,
      lastFix: s.lastFix,
    );
  }

  /// recording | paused → processing → idle
  Future<void> stop() async {
    final s = state;
    final startedAt = switch (s) {
      RecordingActive(:final startedAt) => startedAt,
      RecordingPaused(:final startedAt) => startedAt,
      _ => null,
    };
    if (startedAt == null) return;

    await _cancel();
    state = RecordingState.processing(startedAt: startedAt);
    // TODO(M2): persist trip; TODO(M3): TripProcessor.process(tripId)
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
    state = s.copyWith(fixCount: s.fixCount + 1, lastFix: p);
  }

  Future<void> _onStreamError(Object e, StackTrace st) async {
    _log.e('position stream failed', error: e, stackTrace: st);
    await _cancel();
    state = RecordingState.error(
      kind: RecordingErrorKind.streamFailure,
      message: e.toString(),
    );
  }

  Future<void> _cancel() async {
    await _sub?.cancel();
    _sub = null;
  }
}
