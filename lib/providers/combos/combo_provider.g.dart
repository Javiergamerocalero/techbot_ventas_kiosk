// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allCombosHash() => r'45682b5d9a9a4380c0151aa06b56d8a0de2384c8';

/// Provider principal que obtiene todos los combos desde la API
///
/// Copied from [allCombos].
@ProviderFor(allCombos)
final allCombosProvider = FutureProvider<List<Combo>>.internal(
  allCombos,
  name: r'allCombosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allCombosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllCombosRef = FutureProviderRef<List<Combo>>;
String _$featuredCombosHash() => r'b8585c14459849e78a5e8fa5a7d59697b2973384';

/// Provider que filtra combos destacados (activos)
///
/// Copied from [featuredCombos].
@ProviderFor(featuredCombos)
final featuredCombosProvider = FutureProvider<List<Combo>>.internal(
  featuredCombos,
  name: r'featuredCombosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$featuredCombosHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeaturedCombosRef = FutureProviderRef<List<Combo>>;
String _$comboByIdHash() => r'13d7f652f17452b48c2d07a2151c33abfdb548d8';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// Provider que obtiene un combo específico por ID
///
/// Copied from [comboById].
@ProviderFor(comboById)
const comboByIdProvider = ComboByIdFamily();

/// Provider que obtiene un combo específico por ID
///
/// Copied from [comboById].
class ComboByIdFamily extends Family<AsyncValue<Combo?>> {
  /// Provider que obtiene un combo específico por ID
  ///
  /// Copied from [comboById].
  const ComboByIdFamily();

  /// Provider que obtiene un combo específico por ID
  ///
  /// Copied from [comboById].
  ComboByIdProvider call(int comboId) {
    return ComboByIdProvider(comboId);
  }

  @override
  ComboByIdProvider getProviderOverride(covariant ComboByIdProvider provider) {
    return call(provider.comboId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'comboByIdProvider';
}

/// Provider que obtiene un combo específico por ID
///
/// Copied from [comboById].
class ComboByIdProvider extends FutureProvider<Combo?> {
  /// Provider que obtiene un combo específico por ID
  ///
  /// Copied from [comboById].
  ComboByIdProvider(int comboId)
    : this._internal(
        (ref) => comboById(ref as ComboByIdRef, comboId),
        from: comboByIdProvider,
        name: r'comboByIdProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$comboByIdHash,
        dependencies: ComboByIdFamily._dependencies,
        allTransitiveDependencies: ComboByIdFamily._allTransitiveDependencies,
        comboId: comboId,
      );

  ComboByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.comboId,
  }) : super.internal();

  final int comboId;

  @override
  Override overrideWith(
    FutureOr<Combo?> Function(ComboByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ComboByIdProvider._internal(
        (ref) => create(ref as ComboByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        comboId: comboId,
      ),
    );
  }

  @override
  FutureProviderElement<Combo?> createElement() {
    return _ComboByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ComboByIdProvider && other.comboId == comboId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, comboId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ComboByIdRef on FutureProviderRef<Combo?> {
  /// The parameter `comboId` of this provider.
  int get comboId;
}

class _ComboByIdProviderElement extends FutureProviderElement<Combo?>
    with ComboByIdRef {
  _ComboByIdProviderElement(super.provider);

  @override
  int get comboId => (origin as ComboByIdProvider).comboId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
