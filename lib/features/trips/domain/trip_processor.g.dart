// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_processor.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tripProcessor)
final tripProcessorProvider = TripProcessorProvider._();

final class TripProcessorProvider
    extends $FunctionalProvider<TripProcessor, TripProcessor, TripProcessor>
    with $Provider<TripProcessor> {
  TripProcessorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tripProcessorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tripProcessorHash();

  @$internal
  @override
  $ProviderElement<TripProcessor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TripProcessor create(Ref ref) {
    return tripProcessor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TripProcessor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TripProcessor>(value),
    );
  }
}

String _$tripProcessorHash() => r'c7ec6e3eae84144679ca04b7eab5277dc65da3ac';
