// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'master_data_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$masterDataHash() => r'6ae94279df2233d291738437bd2393c6e9a028de';

/// Provider maestro que obtiene todas las categorías con subcategorías y productos
///
/// Copied from [masterData].
@ProviderFor(masterData)
final masterDataProvider = FutureProvider<List<Category>>.internal(
  masterData,
  name: r'masterDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$masterDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MasterDataRef = FutureProviderRef<List<Category>>;
String _$allCategoriesHash() => r'af4f191fca5365eedf85ae43f6808caaa914a584';

/// Provider derivado que extrae todas las categorías del cache maestro
///
/// Copied from [allCategories].
@ProviderFor(allCategories)
final allCategoriesProvider = FutureProvider<List<Category>>.internal(
  allCategories,
  name: r'allCategoriesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allCategoriesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllCategoriesRef = FutureProviderRef<List<Category>>;
String _$allProductsHash() => r'1664802fe9122775bb9a1b19ea1b61a084d9c7ba';

/// Provider derivado que extrae todos los productos de categorías y subcategorías
///
/// Copied from [allProducts].
@ProviderFor(allProducts)
final allProductsProvider = FutureProvider<List<Product>>.internal(
  allProducts,
  name: r'allProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllProductsRef = FutureProviderRef<List<Product>>;
String _$featuredProductsHash() => r'629f5b70ef7bae933eef7cdefc333eb0b758057c';

/// Provider que filtra productos favoritos (is_favorite = true)
///
/// Copied from [featuredProducts].
@ProviderFor(featuredProducts)
final featuredProductsProvider = FutureProvider<List<Product>>.internal(
  featuredProducts,
  name: r'featuredProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$featuredProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeaturedProductsRef = FutureProviderRef<List<Product>>;
String _$productsByCategoryHash() =>
    r'17ea52edbdb98eac754d52d52bbb431ce9d9d904';

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

/// Provider que obtiene productos por categoría
///
/// Copied from [productsByCategory].
@ProviderFor(productsByCategory)
const productsByCategoryProvider = ProductsByCategoryFamily();

/// Provider que obtiene productos por categoría
///
/// Copied from [productsByCategory].
class ProductsByCategoryFamily extends Family<AsyncValue<List<Product>>> {
  /// Provider que obtiene productos por categoría
  ///
  /// Copied from [productsByCategory].
  const ProductsByCategoryFamily();

  /// Provider que obtiene productos por categoría
  ///
  /// Copied from [productsByCategory].
  ProductsByCategoryProvider call(int categoryId) {
    return ProductsByCategoryProvider(categoryId);
  }

  @override
  ProductsByCategoryProvider getProviderOverride(
    covariant ProductsByCategoryProvider provider,
  ) {
    return call(provider.categoryId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productsByCategoryProvider';
}

/// Provider que obtiene productos por categoría
///
/// Copied from [productsByCategory].
class ProductsByCategoryProvider extends FutureProvider<List<Product>> {
  /// Provider que obtiene productos por categoría
  ///
  /// Copied from [productsByCategory].
  ProductsByCategoryProvider(int categoryId)
    : this._internal(
        (ref) => productsByCategory(ref as ProductsByCategoryRef, categoryId),
        from: productsByCategoryProvider,
        name: r'productsByCategoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productsByCategoryHash,
        dependencies: ProductsByCategoryFamily._dependencies,
        allTransitiveDependencies:
            ProductsByCategoryFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  ProductsByCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  Override overrideWith(
    FutureOr<List<Product>> Function(ProductsByCategoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsByCategoryProvider._internal(
        (ref) => create(ref as ProductsByCategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  FutureProviderElement<List<Product>> createElement() {
    return _ProductsByCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsByCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductsByCategoryRef on FutureProviderRef<List<Product>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _ProductsByCategoryProviderElement
    extends FutureProviderElement<List<Product>>
    with ProductsByCategoryRef {
  _ProductsByCategoryProviderElement(super.provider);

  @override
  int get categoryId => (origin as ProductsByCategoryProvider).categoryId;
}

String _$productsBySubcategoryHash() =>
    r'098e95ba73440280cad49b41d7631b274b563e51';

/// Provider que obtiene productos por subcategoría
///
/// Copied from [productsBySubcategory].
@ProviderFor(productsBySubcategory)
const productsBySubcategoryProvider = ProductsBySubcategoryFamily();

/// Provider que obtiene productos por subcategoría
///
/// Copied from [productsBySubcategory].
class ProductsBySubcategoryFamily extends Family<AsyncValue<List<Product>>> {
  /// Provider que obtiene productos por subcategoría
  ///
  /// Copied from [productsBySubcategory].
  const ProductsBySubcategoryFamily();

  /// Provider que obtiene productos por subcategoría
  ///
  /// Copied from [productsBySubcategory].
  ProductsBySubcategoryProvider call(int subcategoryId) {
    return ProductsBySubcategoryProvider(subcategoryId);
  }

  @override
  ProductsBySubcategoryProvider getProviderOverride(
    covariant ProductsBySubcategoryProvider provider,
  ) {
    return call(provider.subcategoryId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productsBySubcategoryProvider';
}

/// Provider que obtiene productos por subcategoría
///
/// Copied from [productsBySubcategory].
class ProductsBySubcategoryProvider extends FutureProvider<List<Product>> {
  /// Provider que obtiene productos por subcategoría
  ///
  /// Copied from [productsBySubcategory].
  ProductsBySubcategoryProvider(int subcategoryId)
    : this._internal(
        (ref) => productsBySubcategory(
          ref as ProductsBySubcategoryRef,
          subcategoryId,
        ),
        from: productsBySubcategoryProvider,
        name: r'productsBySubcategoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productsBySubcategoryHash,
        dependencies: ProductsBySubcategoryFamily._dependencies,
        allTransitiveDependencies:
            ProductsBySubcategoryFamily._allTransitiveDependencies,
        subcategoryId: subcategoryId,
      );

  ProductsBySubcategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.subcategoryId,
  }) : super.internal();

  final int subcategoryId;

  @override
  Override overrideWith(
    FutureOr<List<Product>> Function(ProductsBySubcategoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsBySubcategoryProvider._internal(
        (ref) => create(ref as ProductsBySubcategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        subcategoryId: subcategoryId,
      ),
    );
  }

  @override
  FutureProviderElement<List<Product>> createElement() {
    return _ProductsBySubcategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsBySubcategoryProvider &&
        other.subcategoryId == subcategoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, subcategoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductsBySubcategoryRef on FutureProviderRef<List<Product>> {
  /// The parameter `subcategoryId` of this provider.
  int get subcategoryId;
}

class _ProductsBySubcategoryProviderElement
    extends FutureProviderElement<List<Product>>
    with ProductsBySubcategoryRef {
  _ProductsBySubcategoryProviderElement(super.provider);

  @override
  int get subcategoryId =>
      (origin as ProductsBySubcategoryProvider).subcategoryId;
}

String _$subcategoriesByCategoryHash() =>
    r'58ccc7792a27fd61450a7e413e3a09cc52703145';

/// Provider que obtiene subcategorías por categoría
///
/// Copied from [subcategoriesByCategory].
@ProviderFor(subcategoriesByCategory)
const subcategoriesByCategoryProvider = SubcategoriesByCategoryFamily();

/// Provider que obtiene subcategorías por categoría
///
/// Copied from [subcategoriesByCategory].
class SubcategoriesByCategoryFamily
    extends Family<AsyncValue<List<Subcategory>>> {
  /// Provider que obtiene subcategorías por categoría
  ///
  /// Copied from [subcategoriesByCategory].
  const SubcategoriesByCategoryFamily();

  /// Provider que obtiene subcategorías por categoría
  ///
  /// Copied from [subcategoriesByCategory].
  SubcategoriesByCategoryProvider call(int categoryId) {
    return SubcategoriesByCategoryProvider(categoryId);
  }

  @override
  SubcategoriesByCategoryProvider getProviderOverride(
    covariant SubcategoriesByCategoryProvider provider,
  ) {
    return call(provider.categoryId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'subcategoriesByCategoryProvider';
}

/// Provider que obtiene subcategorías por categoría
///
/// Copied from [subcategoriesByCategory].
class SubcategoriesByCategoryProvider
    extends FutureProvider<List<Subcategory>> {
  /// Provider que obtiene subcategorías por categoría
  ///
  /// Copied from [subcategoriesByCategory].
  SubcategoriesByCategoryProvider(int categoryId)
    : this._internal(
        (ref) => subcategoriesByCategory(
          ref as SubcategoriesByCategoryRef,
          categoryId,
        ),
        from: subcategoriesByCategoryProvider,
        name: r'subcategoriesByCategoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$subcategoriesByCategoryHash,
        dependencies: SubcategoriesByCategoryFamily._dependencies,
        allTransitiveDependencies:
            SubcategoriesByCategoryFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  SubcategoriesByCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryId,
  }) : super.internal();

  final int categoryId;

  @override
  Override overrideWith(
    FutureOr<List<Subcategory>> Function(SubcategoriesByCategoryRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SubcategoriesByCategoryProvider._internal(
        (ref) => create(ref as SubcategoriesByCategoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryId: categoryId,
      ),
    );
  }

  @override
  FutureProviderElement<List<Subcategory>> createElement() {
    return _SubcategoriesByCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubcategoriesByCategoryProvider &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubcategoriesByCategoryRef on FutureProviderRef<List<Subcategory>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _SubcategoriesByCategoryProviderElement
    extends FutureProviderElement<List<Subcategory>>
    with SubcategoriesByCategoryRef {
  _SubcategoriesByCategoryProviderElement(super.provider);

  @override
  int get categoryId => (origin as SubcategoriesByCategoryProvider).categoryId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
