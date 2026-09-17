// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'live_map.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Builds the live map. Overridden in widget tests, where the MapLibre
/// platform view cannot render (docs/PLAN.md §7).

@ProviderFor(liveMapBuilder)
final liveMapBuilderProvider = LiveMapBuilderProvider._();

/// Builds the live map. Overridden in widget tests, where the MapLibre
/// platform view cannot render (docs/PLAN.md §7).

final class LiveMapBuilderProvider
    extends $FunctionalProvider<WidgetBuilder, WidgetBuilder, WidgetBuilder>
    with $Provider<WidgetBuilder> {
  /// Builds the live map. Overridden in widget tests, where the MapLibre
  /// platform view cannot render (docs/PLAN.md §7).
  LiveMapBuilderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'liveMapBuilderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$liveMapBuilderHash();

  @$internal
  @override
  $ProviderElement<WidgetBuilder> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WidgetBuilder create(Ref ref) {
    return liveMapBuilder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WidgetBuilder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WidgetBuilder>(value),
    );
  }
}

String _$liveMapBuilderHash() => r'0be054cb637ae78c6dd8bab072009f3faba2bbdd';
