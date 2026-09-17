// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'valhalla_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(valhallaClient)
final valhallaClientProvider = ValhallaClientProvider._();

final class ValhallaClientProvider
    extends $FunctionalProvider<ValhallaClient, ValhallaClient, ValhallaClient>
    with $Provider<ValhallaClient> {
  ValhallaClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'valhallaClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$valhallaClientHash();

  @$internal
  @override
  $ProviderElement<ValhallaClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ValhallaClient create(Ref ref) {
    return valhallaClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ValhallaClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ValhallaClient>(value),
    );
  }
}

String _$valhallaClientHash() => r'489fc1ade4215babc0c4789d7fb7054128689a06';
