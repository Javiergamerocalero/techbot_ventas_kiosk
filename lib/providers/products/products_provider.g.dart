// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isProductOutOfStockHash() =>
    r'b750071a716731a19c84e5c9ba026f251d9d145e';

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

/// Provider para verificar si un producto está sin stock
///
/// Copied from [isProductOutOfStock].
@ProviderFor(isProductOutOfStock)
const isProductOutOfStockProvider = IsProductOutOfStockFamily();

/// Provider para verificar si un producto está sin stock
///
/// Copied from [isProductOutOfStock].
class IsProductOutOfStockFamily extends Family<bool> {
  /// Provider para verificar si un producto está sin stock
  ///
  /// Copied from [isProductOutOfStock].
  const IsProductOutOfStockFamily();

  /// Provider para verificar si un producto está sin stock
  ///
  /// Copied from [isProductOutOfStock].
  IsProductOutOfStockProvider call(int productId) {
    return IsProductOutOfStockProvider(productId);
  }

  @override
  IsProductOutOfStockProvider getProviderOverride(
    covariant IsProductOutOfStockProvider provider,
  ) {
    return call(provider.productId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isProductOutOfStockProvider';
}

/// Provider para verificar si un producto está sin stock
///
/// Copied from [isProductOutOfStock].
class IsProductOutOfStockProvider extends AutoDisposeProvider<bool> {
  /// Provider para verificar si un producto está sin stock
  ///
  /// Copied from [isProductOutOfStock].
  IsProductOutOfStockProvider(int productId)
    : this._internal(
        (ref) => isProductOutOfStock(ref as IsProductOutOfStockRef, productId),
        from: isProductOutOfStockProvider,
        name: r'isProductOutOfStockProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isProductOutOfStockHash,
        dependencies: IsProductOutOfStockFamily._dependencies,
        allTransitiveDependencies:
            IsProductOutOfStockFamily._allTransitiveDependencies,
        productId: productId,
      );

  IsProductOutOfStockProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final int productId;

  @override
  Override overrideWith(bool Function(IsProductOutOfStockRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: IsProductOutOfStockProvider._internal(
        (ref) => create(ref as IsProductOutOfStockRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsProductOutOfStockProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsProductOutOfStockProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsProductOutOfStockRef on AutoDisposeProviderRef<bool> {
  /// The parameter `productId` of this provider.
  int get productId;
}

class _IsProductOutOfStockProviderElement
    extends AutoDisposeProviderElement<bool>
    with IsProductOutOfStockRef {
  _IsProductOutOfStockProviderElement(super.provider);

  @override
  int get productId => (origin as IsProductOutOfStockProvider).productId;
}

String _$currentProductStockHash() =>
    r'a643aee977363fd93a9d4584400dcc7e9a07d2ea';

/// Provider para obtener el stock actual de un producto específico
///
/// Copied from [currentProductStock].
@ProviderFor(currentProductStock)
const currentProductStockProvider = CurrentProductStockFamily();

/// Provider para obtener el stock actual de un producto específico
///
/// Copied from [currentProductStock].
class CurrentProductStockFamily extends Family<int> {
  /// Provider para obtener el stock actual de un producto específico
  ///
  /// Copied from [currentProductStock].
  const CurrentProductStockFamily();

  /// Provider para obtener el stock actual de un producto específico
  ///
  /// Copied from [currentProductStock].
  CurrentProductStockProvider call(int productId) {
    return CurrentProductStockProvider(productId);
  }

  @override
  CurrentProductStockProvider getProviderOverride(
    covariant CurrentProductStockProvider provider,
  ) {
    return call(provider.productId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'currentProductStockProvider';
}

/// Provider para obtener el stock actual de un producto específico
///
/// Copied from [currentProductStock].
class CurrentProductStockProvider extends AutoDisposeProvider<int> {
  /// Provider para obtener el stock actual de un producto específico
  ///
  /// Copied from [currentProductStock].
  CurrentProductStockProvider(int productId)
    : this._internal(
        (ref) => currentProductStock(ref as CurrentProductStockRef, productId),
        from: currentProductStockProvider,
        name: r'currentProductStockProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$currentProductStockHash,
        dependencies: CurrentProductStockFamily._dependencies,
        allTransitiveDependencies:
            CurrentProductStockFamily._allTransitiveDependencies,
        productId: productId,
      );

  CurrentProductStockProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final int productId;

  @override
  Override overrideWith(int Function(CurrentProductStockRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: CurrentProductStockProvider._internal(
        (ref) => create(ref as CurrentProductStockRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _CurrentProductStockProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentProductStockProvider && other.productId == productId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CurrentProductStockRef on AutoDisposeProviderRef<int> {
  /// The parameter `productId` of this provider.
  int get productId;
}

class _CurrentProductStockProviderElement
    extends AutoDisposeProviderElement<int>
    with CurrentProductStockRef {
  _CurrentProductStockProviderElement(super.provider);

  @override
  int get productId => (origin as CurrentProductStockProvider).productId;
}

String _$currentProductVariationStockHash() =>
    r'cddf9f87ba0e904f84f2666cd6dd40a1ded1f7bc';

/// Provider para obtener el stock actual de una variación específica
///
/// Copied from [currentProductVariationStock].
@ProviderFor(currentProductVariationStock)
const currentProductVariationStockProvider =
    CurrentProductVariationStockFamily();

/// Provider para obtener el stock actual de una variación específica
///
/// Copied from [currentProductVariationStock].
class CurrentProductVariationStockFamily extends Family<int> {
  /// Provider para obtener el stock actual de una variación específica
  ///
  /// Copied from [currentProductVariationStock].
  const CurrentProductVariationStockFamily();

  /// Provider para obtener el stock actual de una variación específica
  ///
  /// Copied from [currentProductVariationStock].
  CurrentProductVariationStockProvider call(int productId, int variationId) {
    return CurrentProductVariationStockProvider(productId, variationId);
  }

  @override
  CurrentProductVariationStockProvider getProviderOverride(
    covariant CurrentProductVariationStockProvider provider,
  ) {
    return call(provider.productId, provider.variationId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'currentProductVariationStockProvider';
}

/// Provider para obtener el stock actual de una variación específica
///
/// Copied from [currentProductVariationStock].
class CurrentProductVariationStockProvider extends AutoDisposeProvider<int> {
  /// Provider para obtener el stock actual de una variación específica
  ///
  /// Copied from [currentProductVariationStock].
  CurrentProductVariationStockProvider(int productId, int variationId)
    : this._internal(
        (ref) => currentProductVariationStock(
          ref as CurrentProductVariationStockRef,
          productId,
          variationId,
        ),
        from: currentProductVariationStockProvider,
        name: r'currentProductVariationStockProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$currentProductVariationStockHash,
        dependencies: CurrentProductVariationStockFamily._dependencies,
        allTransitiveDependencies:
            CurrentProductVariationStockFamily._allTransitiveDependencies,
        productId: productId,
        variationId: variationId,
      );

  CurrentProductVariationStockProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
    required this.variationId,
  }) : super.internal();

  final int productId;
  final int variationId;

  @override
  Override overrideWith(
    int Function(CurrentProductVariationStockRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CurrentProductVariationStockProvider._internal(
        (ref) => create(ref as CurrentProductVariationStockRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
        variationId: variationId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _CurrentProductVariationStockProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentProductVariationStockProvider &&
        other.productId == productId &&
        other.variationId == variationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, variationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CurrentProductVariationStockRef on AutoDisposeProviderRef<int> {
  /// The parameter `productId` of this provider.
  int get productId;

  /// The parameter `variationId` of this provider.
  int get variationId;
}

class _CurrentProductVariationStockProviderElement
    extends AutoDisposeProviderElement<int>
    with CurrentProductVariationStockRef {
  _CurrentProductVariationStockProviderElement(super.provider);

  @override
  int get productId =>
      (origin as CurrentProductVariationStockProvider).productId;
  @override
  int get variationId =>
      (origin as CurrentProductVariationStockProvider).variationId;
}

String _$filteredProductsPaginatedHash() =>
    r'f687cd403226ca279386fd73d790115b0839bd4a';

/// Devuelve productos filtrados por categoría y/o subcategoría seleccionada con paginación
///
/// Copied from [filteredProductsPaginated].
@ProviderFor(filteredProductsPaginated)
final filteredProductsPaginatedProvider =
    FutureProvider<List<Product>>.internal(
      filteredProductsPaginated,
      name: r'filteredProductsPaginatedProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$filteredProductsPaginatedHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredProductsPaginatedRef = FutureProviderRef<List<Product>>;
String _$hasMoreFilteredProductsHash() =>
    r'10b4002ed5fe843f57a294cc06a68f331c98458e';

/// Provider que indica si hay más productos para mostrar en el filtro actual
///
/// Copied from [hasMoreFilteredProducts].
@ProviderFor(hasMoreFilteredProducts)
final hasMoreFilteredProductsProvider = FutureProvider<bool>.internal(
  hasMoreFilteredProducts,
  name: r'hasMoreFilteredProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasMoreFilteredProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasMoreFilteredProductsRef = FutureProviderRef<bool>;
String _$stockServiceHash() => r'b1e1a1e0a952961276cdeb59f4689c15d43b66b4';

/// Provider del servicio de stock
///
/// Copied from [stockService].
@ProviderFor(stockService)
final stockServiceProvider = Provider<StockService>.internal(
  stockService,
  name: r'stockServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$stockServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StockServiceRef = ProviderRef<StockService>;
String _$productsWithUpdatedStockHash() =>
    r'dbff8441f2fff1b7b063e3cf168f35175d514752';

/// Provider que retorna productos con stock actualizado
///
/// Copied from [productsWithUpdatedStock].
@ProviderFor(productsWithUpdatedStock)
final productsWithUpdatedStockProvider = FutureProvider<List<Product>>.internal(
  productsWithUpdatedStock,
  name: r'productsWithUpdatedStockProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsWithUpdatedStockHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsWithUpdatedStockRef = FutureProviderRef<List<Product>>;
String _$productsBaseStableHash() =>
    r'4b7082c8832481876c9942d0a9a280493d6ffb8e';

/// Provider optimizado para productos base (sin refrescar por stock)
///
/// Copied from [productsBaseStable].
@ProviderFor(productsBaseStable)
final productsBaseStableProvider = FutureProvider<List<Product>>.internal(
  productsBaseStable,
  name: r'productsBaseStableProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsBaseStableHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsBaseStableRef = FutureProviderRef<List<Product>>;
String _$productCurrentStockHash() =>
    r'cf00c0738e580071f18e77eb7a08310209e9445f';

/// Provider para obtener stock específico de un producto
///
/// Copied from [productCurrentStock].
@ProviderFor(productCurrentStock)
const productCurrentStockProvider = ProductCurrentStockFamily();

/// Provider para obtener stock específico de un producto
///
/// Copied from [productCurrentStock].
class ProductCurrentStockFamily extends Family<int> {
  /// Provider para obtener stock específico de un producto
  ///
  /// Copied from [productCurrentStock].
  const ProductCurrentStockFamily();

  /// Provider para obtener stock específico de un producto
  ///
  /// Copied from [productCurrentStock].
  ProductCurrentStockProvider call(int productId, int originalStock) {
    return ProductCurrentStockProvider(productId, originalStock);
  }

  @override
  ProductCurrentStockProvider getProviderOverride(
    covariant ProductCurrentStockProvider provider,
  ) {
    return call(provider.productId, provider.originalStock);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productCurrentStockProvider';
}

/// Provider para obtener stock específico de un producto
///
/// Copied from [productCurrentStock].
class ProductCurrentStockProvider extends AutoDisposeProvider<int> {
  /// Provider para obtener stock específico de un producto
  ///
  /// Copied from [productCurrentStock].
  ProductCurrentStockProvider(int productId, int originalStock)
    : this._internal(
        (ref) => productCurrentStock(
          ref as ProductCurrentStockRef,
          productId,
          originalStock,
        ),
        from: productCurrentStockProvider,
        name: r'productCurrentStockProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productCurrentStockHash,
        dependencies: ProductCurrentStockFamily._dependencies,
        allTransitiveDependencies:
            ProductCurrentStockFamily._allTransitiveDependencies,
        productId: productId,
        originalStock: originalStock,
      );

  ProductCurrentStockProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
    required this.originalStock,
  }) : super.internal();

  final int productId;
  final int originalStock;

  @override
  Override overrideWith(int Function(ProductCurrentStockRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: ProductCurrentStockProvider._internal(
        (ref) => create(ref as ProductCurrentStockRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
        originalStock: originalStock,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _ProductCurrentStockProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductCurrentStockProvider &&
        other.productId == productId &&
        other.originalStock == originalStock;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, originalStock.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductCurrentStockRef on AutoDisposeProviderRef<int> {
  /// The parameter `productId` of this provider.
  int get productId;

  /// The parameter `originalStock` of this provider.
  int get originalStock;
}

class _ProductCurrentStockProviderElement
    extends AutoDisposeProviderElement<int>
    with ProductCurrentStockRef {
  _ProductCurrentStockProviderElement(super.provider);

  @override
  int get productId => (origin as ProductCurrentStockProvider).productId;
  @override
  int get originalStock =>
      (origin as ProductCurrentStockProvider).originalStock;
}

String _$productsByCategoryWithStockHash() =>
    r'95eb4dc24e3af0198fe920cafc3626c08a72c3c1';

/// Provider para productos por categoría con stock actualizado
/// Incluye productos directos de la categoría Y productos de sus subcategorías
///
/// Copied from [productsByCategoryWithStock].
@ProviderFor(productsByCategoryWithStock)
const productsByCategoryWithStockProvider = ProductsByCategoryWithStockFamily();

/// Provider para productos por categoría con stock actualizado
/// Incluye productos directos de la categoría Y productos de sus subcategorías
///
/// Copied from [productsByCategoryWithStock].
class ProductsByCategoryWithStockFamily
    extends Family<AsyncValue<List<Product>>> {
  /// Provider para productos por categoría con stock actualizado
  /// Incluye productos directos de la categoría Y productos de sus subcategorías
  ///
  /// Copied from [productsByCategoryWithStock].
  const ProductsByCategoryWithStockFamily();

  /// Provider para productos por categoría con stock actualizado
  /// Incluye productos directos de la categoría Y productos de sus subcategorías
  ///
  /// Copied from [productsByCategoryWithStock].
  ProductsByCategoryWithStockProvider call(int categoryId) {
    return ProductsByCategoryWithStockProvider(categoryId);
  }

  @override
  ProductsByCategoryWithStockProvider getProviderOverride(
    covariant ProductsByCategoryWithStockProvider provider,
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
  String? get name => r'productsByCategoryWithStockProvider';
}

/// Provider para productos por categoría con stock actualizado
/// Incluye productos directos de la categoría Y productos de sus subcategorías
///
/// Copied from [productsByCategoryWithStock].
class ProductsByCategoryWithStockProvider
    extends AutoDisposeFutureProvider<List<Product>> {
  /// Provider para productos por categoría con stock actualizado
  /// Incluye productos directos de la categoría Y productos de sus subcategorías
  ///
  /// Copied from [productsByCategoryWithStock].
  ProductsByCategoryWithStockProvider(int categoryId)
    : this._internal(
        (ref) => productsByCategoryWithStock(
          ref as ProductsByCategoryWithStockRef,
          categoryId,
        ),
        from: productsByCategoryWithStockProvider,
        name: r'productsByCategoryWithStockProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productsByCategoryWithStockHash,
        dependencies: ProductsByCategoryWithStockFamily._dependencies,
        allTransitiveDependencies:
            ProductsByCategoryWithStockFamily._allTransitiveDependencies,
        categoryId: categoryId,
      );

  ProductsByCategoryWithStockProvider._internal(
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
    FutureOr<List<Product>> Function(ProductsByCategoryWithStockRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProductsByCategoryWithStockProvider._internal(
        (ref) => create(ref as ProductsByCategoryWithStockRef),
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
  AutoDisposeFutureProviderElement<List<Product>> createElement() {
    return _ProductsByCategoryWithStockProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsByCategoryWithStockProvider &&
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
mixin ProductsByCategoryWithStockRef
    on AutoDisposeFutureProviderRef<List<Product>> {
  /// The parameter `categoryId` of this provider.
  int get categoryId;
}

class _ProductsByCategoryWithStockProviderElement
    extends AutoDisposeFutureProviderElement<List<Product>>
    with ProductsByCategoryWithStockRef {
  _ProductsByCategoryWithStockProviderElement(super.provider);

  @override
  int get categoryId =>
      (origin as ProductsByCategoryWithStockProvider).categoryId;
}

String _$featuredProductsStableHash() =>
    r'fcc1aa0266c5078756e328807920ba86a492a1ab';

/// Provider estable para productos destacados (CON stock actualizado)
///
/// Copied from [featuredProductsStable].
@ProviderFor(featuredProductsStable)
final featuredProductsStableProvider = FutureProvider<List<Product>>.internal(
  featuredProductsStable,
  name: r'featuredProductsStableProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$featuredProductsStableHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeaturedProductsStableRef = FutureProviderRef<List<Product>>;
String _$validateProductStockHash() =>
    r'540a2248fdcbd983ea63c9fefe4145243490afbc';

/// Valida el stock de un producto antes de agregarlo al carrito
///
/// Copied from [validateProductStock].
@ProviderFor(validateProductStock)
const validateProductStockProvider = ValidateProductStockFamily();

/// Valida el stock de un producto antes de agregarlo al carrito
///
/// Copied from [validateProductStock].
class ValidateProductStockFamily extends Family<AsyncValue<StockResponse>> {
  /// Valida el stock de un producto antes de agregarlo al carrito
  ///
  /// Copied from [validateProductStock].
  const ValidateProductStockFamily();

  /// Valida el stock de un producto antes de agregarlo al carrito
  ///
  /// Copied from [validateProductStock].
  ValidateProductStockProvider call(
    int productId,
    int quantity, {
    int? variationId,
  }) {
    return ValidateProductStockProvider(
      productId,
      quantity,
      variationId: variationId,
    );
  }

  @override
  ValidateProductStockProvider getProviderOverride(
    covariant ValidateProductStockProvider provider,
  ) {
    return call(
      provider.productId,
      provider.quantity,
      variationId: provider.variationId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'validateProductStockProvider';
}

/// Valida el stock de un producto antes de agregarlo al carrito
///
/// Copied from [validateProductStock].
class ValidateProductStockProvider
    extends AutoDisposeFutureProvider<StockResponse> {
  /// Valida el stock de un producto antes de agregarlo al carrito
  ///
  /// Copied from [validateProductStock].
  ValidateProductStockProvider(int productId, int quantity, {int? variationId})
    : this._internal(
        (ref) => validateProductStock(
          ref as ValidateProductStockRef,
          productId,
          quantity,
          variationId: variationId,
        ),
        from: validateProductStockProvider,
        name: r'validateProductStockProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$validateProductStockHash,
        dependencies: ValidateProductStockFamily._dependencies,
        allTransitiveDependencies:
            ValidateProductStockFamily._allTransitiveDependencies,
        productId: productId,
        quantity: quantity,
        variationId: variationId,
      );

  ValidateProductStockProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
    required this.quantity,
    required this.variationId,
  }) : super.internal();

  final int productId;
  final int quantity;
  final int? variationId;

  @override
  Override overrideWith(
    FutureOr<StockResponse> Function(ValidateProductStockRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ValidateProductStockProvider._internal(
        (ref) => create(ref as ValidateProductStockRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
        quantity: quantity,
        variationId: variationId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<StockResponse> createElement() {
    return _ValidateProductStockProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ValidateProductStockProvider &&
        other.productId == productId &&
        other.quantity == quantity &&
        other.variationId == variationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);
    hash = _SystemHash.combine(hash, variationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ValidateProductStockRef on AutoDisposeFutureProviderRef<StockResponse> {
  /// The parameter `productId` of this provider.
  int get productId;

  /// The parameter `quantity` of this provider.
  int get quantity;

  /// The parameter `variationId` of this provider.
  int? get variationId;
}

class _ValidateProductStockProviderElement
    extends AutoDisposeFutureProviderElement<StockResponse>
    with ValidateProductStockRef {
  _ValidateProductStockProviderElement(super.provider);

  @override
  int get productId => (origin as ValidateProductStockProvider).productId;
  @override
  int get quantity => (origin as ValidateProductStockProvider).quantity;
  @override
  int? get variationId => (origin as ValidateProductStockProvider).variationId;
}

String _$removeProductFromCartHash() =>
    r'efe44356186dbb425bf9af84d8fcb7b6b24566dd';

/// Elimina un producto del carrito
///
/// Copied from [removeProductFromCart].
@ProviderFor(removeProductFromCart)
const removeProductFromCartProvider = RemoveProductFromCartFamily();

/// Elimina un producto del carrito
///
/// Copied from [removeProductFromCart].
class RemoveProductFromCartFamily extends Family<AsyncValue<StockResponse>> {
  /// Elimina un producto del carrito
  ///
  /// Copied from [removeProductFromCart].
  const RemoveProductFromCartFamily();

  /// Elimina un producto del carrito
  ///
  /// Copied from [removeProductFromCart].
  RemoveProductFromCartProvider call(int productId, {int? variationId}) {
    return RemoveProductFromCartProvider(productId, variationId: variationId);
  }

  @override
  RemoveProductFromCartProvider getProviderOverride(
    covariant RemoveProductFromCartProvider provider,
  ) {
    return call(provider.productId, variationId: provider.variationId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'removeProductFromCartProvider';
}

/// Elimina un producto del carrito
///
/// Copied from [removeProductFromCart].
class RemoveProductFromCartProvider
    extends AutoDisposeFutureProvider<StockResponse> {
  /// Elimina un producto del carrito
  ///
  /// Copied from [removeProductFromCart].
  RemoveProductFromCartProvider(int productId, {int? variationId})
    : this._internal(
        (ref) => removeProductFromCart(
          ref as RemoveProductFromCartRef,
          productId,
          variationId: variationId,
        ),
        from: removeProductFromCartProvider,
        name: r'removeProductFromCartProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$removeProductFromCartHash,
        dependencies: RemoveProductFromCartFamily._dependencies,
        allTransitiveDependencies:
            RemoveProductFromCartFamily._allTransitiveDependencies,
        productId: productId,
        variationId: variationId,
      );

  RemoveProductFromCartProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
    required this.variationId,
  }) : super.internal();

  final int productId;
  final int? variationId;

  @override
  Override overrideWith(
    FutureOr<StockResponse> Function(RemoveProductFromCartRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemoveProductFromCartProvider._internal(
        (ref) => create(ref as RemoveProductFromCartRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
        variationId: variationId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<StockResponse> createElement() {
    return _RemoveProductFromCartProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoveProductFromCartProvider &&
        other.productId == productId &&
        other.variationId == variationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, variationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RemoveProductFromCartRef on AutoDisposeFutureProviderRef<StockResponse> {
  /// The parameter `productId` of this provider.
  int get productId;

  /// The parameter `variationId` of this provider.
  int? get variationId;
}

class _RemoveProductFromCartProviderElement
    extends AutoDisposeFutureProviderElement<StockResponse>
    with RemoveProductFromCartRef {
  _RemoveProductFromCartProviderElement(super.provider);

  @override
  int get productId => (origin as RemoveProductFromCartProvider).productId;
  @override
  int? get variationId => (origin as RemoveProductFromCartProvider).variationId;
}

String _$clearCartAndRestoreStockHash() =>
    r'6252f0b47686fcad09c7a361c024807846f589b7';

/// Limpia el carrito completo y repone el stock
///
/// Copied from [clearCartAndRestoreStock].
@ProviderFor(clearCartAndRestoreStock)
final clearCartAndRestoreStockProvider =
    AutoDisposeFutureProvider<StockResponse>.internal(
      clearCartAndRestoreStock,
      name: r'clearCartAndRestoreStockProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$clearCartAndRestoreStockHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClearCartAndRestoreStockRef =
    AutoDisposeFutureProviderRef<StockResponse>;
String _$updateComboStockHash() => r'0e3fd7abbff6f16ff5e96a56e9f5ec00e51f207a';

/// Actualiza la cantidad de un combo en el carrito y ajusta el stock
///
/// Copied from [updateComboStock].
@ProviderFor(updateComboStock)
const updateComboStockProvider = UpdateComboStockFamily();

/// Actualiza la cantidad de un combo en el carrito y ajusta el stock
///
/// Copied from [updateComboStock].
class UpdateComboStockFamily extends Family<AsyncValue<StockResponse>> {
  /// Actualiza la cantidad de un combo en el carrito y ajusta el stock
  ///
  /// Copied from [updateComboStock].
  const UpdateComboStockFamily();

  /// Actualiza la cantidad de un combo en el carrito y ajusta el stock
  ///
  /// Copied from [updateComboStock].
  UpdateComboStockProvider call(int comboId, int quantity) {
    return UpdateComboStockProvider(comboId, quantity);
  }

  @override
  UpdateComboStockProvider getProviderOverride(
    covariant UpdateComboStockProvider provider,
  ) {
    return call(provider.comboId, provider.quantity);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateComboStockProvider';
}

/// Actualiza la cantidad de un combo en el carrito y ajusta el stock
///
/// Copied from [updateComboStock].
class UpdateComboStockProvider
    extends AutoDisposeFutureProvider<StockResponse> {
  /// Actualiza la cantidad de un combo en el carrito y ajusta el stock
  ///
  /// Copied from [updateComboStock].
  UpdateComboStockProvider(int comboId, int quantity)
    : this._internal(
        (ref) =>
            updateComboStock(ref as UpdateComboStockRef, comboId, quantity),
        from: updateComboStockProvider,
        name: r'updateComboStockProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateComboStockHash,
        dependencies: UpdateComboStockFamily._dependencies,
        allTransitiveDependencies:
            UpdateComboStockFamily._allTransitiveDependencies,
        comboId: comboId,
        quantity: quantity,
      );

  UpdateComboStockProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.comboId,
    required this.quantity,
  }) : super.internal();

  final int comboId;
  final int quantity;

  @override
  Override overrideWith(
    FutureOr<StockResponse> Function(UpdateComboStockRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateComboStockProvider._internal(
        (ref) => create(ref as UpdateComboStockRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        comboId: comboId,
        quantity: quantity,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<StockResponse> createElement() {
    return _UpdateComboStockProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateComboStockProvider &&
        other.comboId == comboId &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, comboId.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateComboStockRef on AutoDisposeFutureProviderRef<StockResponse> {
  /// The parameter `comboId` of this provider.
  int get comboId;

  /// The parameter `quantity` of this provider.
  int get quantity;
}

class _UpdateComboStockProviderElement
    extends AutoDisposeFutureProviderElement<StockResponse>
    with UpdateComboStockRef {
  _UpdateComboStockProviderElement(super.provider);

  @override
  int get comboId => (origin as UpdateComboStockProvider).comboId;
  @override
  int get quantity => (origin as UpdateComboStockProvider).quantity;
}

String _$updateComboStockWithVariationsHash() =>
    r'fd7889e4377f04b9de227c97505adad307d15a5c';

/// Actualiza la cantidad de un combo con variaciones en el carrito
///
/// Copied from [updateComboStockWithVariations].
@ProviderFor(updateComboStockWithVariations)
const updateComboStockWithVariationsProvider =
    UpdateComboStockWithVariationsFamily();

/// Actualiza la cantidad de un combo con variaciones en el carrito
///
/// Copied from [updateComboStockWithVariations].
class UpdateComboStockWithVariationsFamily
    extends Family<AsyncValue<StockResponse>> {
  /// Actualiza la cantidad de un combo con variaciones en el carrito
  ///
  /// Copied from [updateComboStockWithVariations].
  const UpdateComboStockWithVariationsFamily();

  /// Actualiza la cantidad de un combo con variaciones en el carrito
  ///
  /// Copied from [updateComboStockWithVariations].
  UpdateComboStockWithVariationsProvider call(
    int comboId,
    int quantity,
    Map<int, int> selectedVariations,
  ) {
    return UpdateComboStockWithVariationsProvider(
      comboId,
      quantity,
      selectedVariations,
    );
  }

  @override
  UpdateComboStockWithVariationsProvider getProviderOverride(
    covariant UpdateComboStockWithVariationsProvider provider,
  ) {
    return call(
      provider.comboId,
      provider.quantity,
      provider.selectedVariations,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateComboStockWithVariationsProvider';
}

/// Actualiza la cantidad de un combo con variaciones en el carrito
///
/// Copied from [updateComboStockWithVariations].
class UpdateComboStockWithVariationsProvider
    extends AutoDisposeFutureProvider<StockResponse> {
  /// Actualiza la cantidad de un combo con variaciones en el carrito
  ///
  /// Copied from [updateComboStockWithVariations].
  UpdateComboStockWithVariationsProvider(
    int comboId,
    int quantity,
    Map<int, int> selectedVariations,
  ) : this._internal(
        (ref) => updateComboStockWithVariations(
          ref as UpdateComboStockWithVariationsRef,
          comboId,
          quantity,
          selectedVariations,
        ),
        from: updateComboStockWithVariationsProvider,
        name: r'updateComboStockWithVariationsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$updateComboStockWithVariationsHash,
        dependencies: UpdateComboStockWithVariationsFamily._dependencies,
        allTransitiveDependencies:
            UpdateComboStockWithVariationsFamily._allTransitiveDependencies,
        comboId: comboId,
        quantity: quantity,
        selectedVariations: selectedVariations,
      );

  UpdateComboStockWithVariationsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.comboId,
    required this.quantity,
    required this.selectedVariations,
  }) : super.internal();

  final int comboId;
  final int quantity;
  final Map<int, int> selectedVariations;

  @override
  Override overrideWith(
    FutureOr<StockResponse> Function(UpdateComboStockWithVariationsRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateComboStockWithVariationsProvider._internal(
        (ref) => create(ref as UpdateComboStockWithVariationsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        comboId: comboId,
        quantity: quantity,
        selectedVariations: selectedVariations,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<StockResponse> createElement() {
    return _UpdateComboStockWithVariationsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateComboStockWithVariationsProvider &&
        other.comboId == comboId &&
        other.quantity == quantity &&
        other.selectedVariations == selectedVariations;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, comboId.hashCode);
    hash = _SystemHash.combine(hash, quantity.hashCode);
    hash = _SystemHash.combine(hash, selectedVariations.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UpdateComboStockWithVariationsRef
    on AutoDisposeFutureProviderRef<StockResponse> {
  /// The parameter `comboId` of this provider.
  int get comboId;

  /// The parameter `quantity` of this provider.
  int get quantity;

  /// The parameter `selectedVariations` of this provider.
  Map<int, int> get selectedVariations;
}

class _UpdateComboStockWithVariationsProviderElement
    extends AutoDisposeFutureProviderElement<StockResponse>
    with UpdateComboStockWithVariationsRef {
  _UpdateComboStockWithVariationsProviderElement(super.provider);

  @override
  int get comboId => (origin as UpdateComboStockWithVariationsProvider).comboId;
  @override
  int get quantity =>
      (origin as UpdateComboStockWithVariationsProvider).quantity;
  @override
  Map<int, int> get selectedVariations =>
      (origin as UpdateComboStockWithVariationsProvider).selectedVariations;
}

String _$categoryProductsExpandedHash() =>
    r'bd90bb997d5445aee43246312ceae3f1b4c66033';

/// Gestiona el estado expandido/colapsado de las secciones de productos por categoría
///
/// Copied from [CategoryProductsExpanded].
@ProviderFor(CategoryProductsExpanded)
final categoryProductsExpandedProvider =
    NotifierProvider<CategoryProductsExpanded, Map<String, bool>>.internal(
      CategoryProductsExpanded.new,
      name: r'categoryProductsExpandedProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$categoryProductsExpandedHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CategoryProductsExpanded = Notifier<Map<String, bool>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
