// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recording_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// THE recording state machine (docs/PLAN.md §4.1). Owns the position
/// subscription, creates the `in_progress` trip, buffers fixes and flushes
/// them to `trip_points` every [RecordingConfig.flushInterval] or
/// [RecordingConfig.flushEvery] points, and finalizes the trip on Stop.

@ProviderFor(RecordingController)
final recordingControllerProvider = RecordingControllerProvider._();

/// THE recording state machine (docs/PLAN.md §4.1). Owns the position
/// subscription, creates the `in_progress` trip, buffers fixes and flushes
/// them to `trip_points` every [RecordingConfig.flushInterval] or
/// [RecordingConfig.flushEvery] points, and finalizes the trip on Stop.
final class RecordingControllerProvider
    extends $NotifierProvider<RecordingController, RecordingState> {
  /// THE recording state machine (docs/PLAN.md §4.1). Owns the position
  /// subscription, creates the `in_progress` trip, buffers fixes and flushes
  /// them to `trip_points` every [RecordingConfig.flushInterval] or
  /// [RecordingConfig.flushEvery] points, and finalizes the trip on Stop.
  RecordingControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recordingControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recordingControllerHash();

  @$internal
  @override
  RecordingController create() => RecordingController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecordingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecordingState>(value),
    );
  }
}

String _$recordingControllerHash() =>
    r'554039baa277538d45af56ce6a698f9348916f0f';

/// THE recording state machine (docs/PLAN.md §4.1). Owns the position
/// subscription, creates the `in_progress` trip, buffers fixes and flushes
/// them to `trip_points` every [RecordingConfig.flushInterval] or
/// [RecordingConfig.flushEvery] points, and finalizes the trip on Stop.

abstract class _$RecordingController extends $Notifier<RecordingState> {
  RecordingState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<RecordingState, RecordingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RecordingState, RecordingState>,
              RecordingState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
