import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';

part 'recording_state.freezed.dart';

/// Why recording could not start or continue (docs/PLAN.md §4.1).
enum RecordingErrorKind {
  /// User denied location this time; may retry.
  permissionDenied,

  /// User denied permanently; must open OS settings.
  permissionDeniedForever,

  /// Device location services are off.
  locationServiceDisabled,

  /// The position stream failed.
  streamFailure,
}

/// State machine for a drive recording (docs/PLAN.md §4.1).
///
/// idle → requestingPermission → recording ⇄ paused → processing → idle
/// Any step may fall into [RecordingState.error].
@freezed
sealed class RecordingState with _$RecordingState {
  const factory idle() = RecordingIdle;

  const factory requestingPermission() = RecordingRequestingPermission;

  const factory recording({
    required String tripId,
    required DateTime startedAt,
    @Default(0) int fixCount,
    Position? lastFix,
    @Default(<({double lat, double lon})>[])
    List<({double lat, double lon})> trace,
  }) = RecordingActive;

  const factory paused({
    required String tripId,
    required DateTime startedAt,
    @Default(0) int fixCount,
    Position? lastFix,
    @Default(<({double lat, double lon})>[])
    List<({double lat, double lon})> trace,
  }) = RecordingPaused;

  const factory processing({
    required String tripId,
    required DateTime startedAt,
  }) = RecordingProcessing;

  const factory error({required RecordingErrorKind kind, String? message}) =
      RecordingError;
}
