// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recording_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(recordingConfig)
final recordingConfigProvider = RecordingConfigProvider._();

final class RecordingConfigProvider
    extends
        $FunctionalProvider<RecordingConfig, RecordingConfig, RecordingConfig>
    with $Provider<RecordingConfig> {
  RecordingConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recordingConfigProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recordingConfigHash();

  @$internal
  @override
  $ProviderElement<RecordingConfig> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RecordingConfig create(Ref ref) {
    return recordingConfig(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RecordingConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RecordingConfig>(value),
    );
  }
}

String _$recordingConfigHash() => r'5f5325a2f0b168a83973e1c4bf1753f1a4a68439';
