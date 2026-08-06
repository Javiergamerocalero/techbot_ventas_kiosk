// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategories_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$subcategoriesForSelectedCategoryHash() =>
    r'2d116e5ac48a23fb17f9e278d3fb63c954036ffb';

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

/// Provider que obtiene las subcategorías de la categoría seleccionada
///
/// Copied from [subcategoriesForSelectedCategory].
@ProviderFor(subcategoriesForSelectedCategory)
const subcategoriesForSelectedCategoryProvider =
    SubcategoriesForSelectedCategoryFamily();

/// Provider que obtiene las subcategorías de la categoría seleccionada
///
/// Copied from [subcategoriesForSelectedCategory].
class SubcategoriesForSelectedCategoryFamily extends Family<List<Subcategory>> {
  /// Provider que obtiene las subcategorías de la categoría seleccionada
  ///
  /// Copied from [subcategoriesForSelectedCategory].
  const SubcategoriesForSelectedCategoryFamily();

  /// Provider que obtiene las subcategorías de la categoría seleccionada
  ///
  /// Copied from [subcategoriesForSelectedCategory].
  SubcategoriesForSelectedCategoryProvider call(int? selectedCategoryId) {
    return SubcategoriesForSelectedCategoryProvider(selectedCategoryId);
  }

  @override
  SubcategoriesForSelectedCategoryProvider getProviderOverride(
    covariant SubcategoriesForSelectedCategoryProvider provider,
  ) {
    return call(provider.selectedCategoryId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'subcategoriesForSelectedCategoryProvider';
}

/// Provider que obtiene las subcategorías de la categoría seleccionada
///
/// Copied from [subcategoriesForSelectedCategory].
class SubcategoriesForSelectedCategoryProvider
    extends Provider<List<Subcategory>> {
  /// Provider que obtiene las subcategorías de la categoría seleccionada
  ///
  /// Copied from [subcategoriesForSelectedCategory].
  SubcategoriesForSelectedCategoryProvider(int? selectedCategoryId)
    : this._internal(
        (ref) => subcategoriesForSelectedCategory(
          ref as SubcategoriesForSelectedCategoryRef,
          selectedCategoryId,
        ),
        from: subcategoriesForSelectedCategoryProvider,
        name: r'subcategoriesForSelectedCategoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$subcategoriesForSelectedCategoryHash,
        dependencies: SubcategoriesForSelectedCategoryFamily._dependencies,
        allTransitiveDependencies:
            SubcategoriesForSelectedCategoryFamily._allTransitiveDependencies,
        selectedCategoryId: selectedCategoryId,
      );

  SubcategoriesForSelectedCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.selectedCategoryId,
  }) : super.internal();

  final int? selectedCategoryId;

  @override
  Override overrideWith(
    List<Subcategory> Function(SubcategoriesForSelectedCategoryRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubcategoriesForSelectedCategoryProvider._internal(
        (ref) => create(ref as SubcategoriesForSelectedCategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        selectedCategoryId: selectedCategoryId,
      ),
    );
  }

  @override
  ProviderElement<List<Subcategory>> createElement() {
    return _SubcategoriesForSelectedCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubcategoriesForSelectedCategoryProvider &&
        other.selectedCategoryId == selectedCategoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, selectedCategoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubcategoriesForSelectedCategoryRef on ProviderRef<List<Subcategory>> {
  /// The parameter `selectedCategoryId` of this provider.
  int? get selectedCategoryId;
}

class _SubcategoriesForSelectedCategoryProviderElement
    extends ProviderElement<List<Subcategory>>
    with SubcategoriesForSelectedCategoryRef {
  _SubcategoriesForSelectedCategoryProviderElement(super.provider);

  @override
  int? get selectedCategoryId =>
      (origin as SubcategoriesForSelectedCategoryProvider).selectedCategoryId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
