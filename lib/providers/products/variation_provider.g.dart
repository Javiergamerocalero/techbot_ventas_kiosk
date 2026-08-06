// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'variation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$selectedProductVariationHash() =>
    r'7a79355e19e5d83b13d5a68d8bc630c61601f2d3';

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

/// Provider derivado para obtener la variación seleccionada de un producto específico
///
/// Copied from [selectedProductVariation].
@ProviderFor(selectedProductVariation)
const selectedProductVariationProvider = SelectedProductVariationFamily();

/// Provider derivado para obtener la variación seleccionada de un producto específico
///
/// Copied from [selectedProductVariation].
class SelectedProductVariationFamily extends Family<ProductVariation?> {
  /// Provider derivado para obtener la variación seleccionada de un producto específico
  ///
  /// Copied from [selectedProductVariation].
  const SelectedProductVariationFamily();

  /// Provider derivado para obtener la variación seleccionada de un producto específico
  ///
  /// Copied from [selectedProductVariation].
  SelectedProductVariationProvider call(int productId, Product product) {
    return SelectedProductVariationProvider(productId, product);
  }

  @override
  SelectedProductVariationProvider getProviderOverride(
    covariant SelectedProductVariationProvider provider,
  ) {
    return call(provider.productId, provider.product);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectedProductVariationProvider';
}

/// Provider derivado para obtener la variación seleccionada de un producto específico
///
/// Copied from [selectedProductVariation].
class SelectedProductVariationProvider
    extends AutoDisposeProvider<ProductVariation?> {
  /// Provider derivado para obtener la variación seleccionada de un producto específico
  ///
  /// Copied from [selectedProductVariation].
  SelectedProductVariationProvider(int productId, Product product)
    : this._internal(
        (ref) => selectedProductVariation(
          ref as SelectedProductVariationRef,
          productId,
          product,
        ),
        from: selectedProductVariationProvider,
        name: r'selectedProductVariationProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$selectedProductVariationHash,
        dependencies: SelectedProductVariationFamily._dependencies,
        allTransitiveDependencies:
            SelectedProductVariationFamily._allTransitiveDependencies,
        productId: productId,
        product: product,
      );

  SelectedProductVariationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
    required this.product,
  }) : super.internal();

  final int productId;
  final Product product;

  @override
  Override overrideWith(
    ProductVariation? Function(SelectedProductVariationRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SelectedProductVariationProvider._internal(
        (ref) => create(ref as SelectedProductVariationRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
        product: product,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<ProductVariation?> createElement() {
    return _SelectedProductVariationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedProductVariationProvider &&
        other.productId == productId &&
        other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SelectedProductVariationRef on AutoDisposeProviderRef<ProductVariation?> {
  /// The parameter `productId` of this provider.
  int get productId;

  /// The parameter `product` of this provider.
  Product get product;
}

class _SelectedProductVariationProviderElement
    extends AutoDisposeProviderElement<ProductVariation?>
    with SelectedProductVariationRef {
  _SelectedProductVariationProviderElement(super.provider);

  @override
  int get productId => (origin as SelectedProductVariationProvider).productId;
  @override
  Product get product => (origin as SelectedProductVariationProvider).product;
}

String _$requiresVariationSelectionHash() =>
    r'543a2ea3ac83c6aa1db048af897842f6cf1afbf6';

/// Provider para verificar si un producto requiere selección de variación
///
/// Copied from [requiresVariationSelection].
@ProviderFor(requiresVariationSelection)
const requiresVariationSelectionProvider = RequiresVariationSelectionFamily();

/// Provider para verificar si un producto requiere selección de variación
///
/// Copied from [requiresVariationSelection].
class RequiresVariationSelectionFamily extends Family<bool> {
  /// Provider para verificar si un producto requiere selección de variación
  ///
  /// Copied from [requiresVariationSelection].
  const RequiresVariationSelectionFamily();

  /// Provider para verificar si un producto requiere selección de variación
  ///
  /// Copied from [requiresVariationSelection].
  RequiresVariationSelectionProvider call(Product product) {
    return RequiresVariationSelectionProvider(product);
  }

  @override
  RequiresVariationSelectionProvider getProviderOverride(
    covariant RequiresVariationSelectionProvider provider,
  ) {
    return call(provider.product);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'requiresVariationSelectionProvider';
}

/// Provider para verificar si un producto requiere selección de variación
///
/// Copied from [requiresVariationSelection].
class RequiresVariationSelectionProvider extends AutoDisposeProvider<bool> {
  /// Provider para verificar si un producto requiere selección de variación
  ///
  /// Copied from [requiresVariationSelection].
  RequiresVariationSelectionProvider(Product product)
    : this._internal(
        (ref) => requiresVariationSelection(
          ref as RequiresVariationSelectionRef,
          product,
        ),
        from: requiresVariationSelectionProvider,
        name: r'requiresVariationSelectionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$requiresVariationSelectionHash,
        dependencies: RequiresVariationSelectionFamily._dependencies,
        allTransitiveDependencies:
            RequiresVariationSelectionFamily._allTransitiveDependencies,
        product: product,
      );

  RequiresVariationSelectionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.product,
  }) : super.internal();

  final Product product;

  @override
  Override overrideWith(
    bool Function(RequiresVariationSelectionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RequiresVariationSelectionProvider._internal(
        (ref) => create(ref as RequiresVariationSelectionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        product: product,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _RequiresVariationSelectionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RequiresVariationSelectionProvider &&
        other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RequiresVariationSelectionRef on AutoDisposeProviderRef<bool> {
  /// The parameter `product` of this provider.
  Product get product;
}

class _RequiresVariationSelectionProviderElement
    extends AutoDisposeProviderElement<bool>
    with RequiresVariationSelectionRef {
  _RequiresVariationSelectionProviderElement(super.provider);

  @override
  Product get product => (origin as RequiresVariationSelectionProvider).product;
}

String _$selectedVariationStockHash() =>
    r'e1add1d007258149fa96517d2fc99d6c084aeda6';

/// Provider para obtener el stock de la variación seleccionada o del producto
///
/// Copied from [selectedVariationStock].
@ProviderFor(selectedVariationStock)
const selectedVariationStockProvider = SelectedVariationStockFamily();

/// Provider para obtener el stock de la variación seleccionada o del producto
///
/// Copied from [selectedVariationStock].
class SelectedVariationStockFamily extends Family<int> {
  /// Provider para obtener el stock de la variación seleccionada o del producto
  ///
  /// Copied from [selectedVariationStock].
  const SelectedVariationStockFamily();

  /// Provider para obtener el stock de la variación seleccionada o del producto
  ///
  /// Copied from [selectedVariationStock].
  SelectedVariationStockProvider call(int productId, Product product) {
    return SelectedVariationStockProvider(productId, product);
  }

  @override
  SelectedVariationStockProvider getProviderOverride(
    covariant SelectedVariationStockProvider provider,
  ) {
    return call(provider.productId, provider.product);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectedVariationStockProvider';
}

/// Provider para obtener el stock de la variación seleccionada o del producto
///
/// Copied from [selectedVariationStock].
class SelectedVariationStockProvider extends AutoDisposeProvider<int> {
  /// Provider para obtener el stock de la variación seleccionada o del producto
  ///
  /// Copied from [selectedVariationStock].
  SelectedVariationStockProvider(int productId, Product product)
    : this._internal(
        (ref) => selectedVariationStock(
          ref as SelectedVariationStockRef,
          productId,
          product,
        ),
        from: selectedVariationStockProvider,
        name: r'selectedVariationStockProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$selectedVariationStockHash,
        dependencies: SelectedVariationStockFamily._dependencies,
        allTransitiveDependencies:
            SelectedVariationStockFamily._allTransitiveDependencies,
        productId: productId,
        product: product,
      );

  SelectedVariationStockProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
    required this.product,
  }) : super.internal();

  final int productId;
  final Product product;

  @override
  Override overrideWith(
    int Function(SelectedVariationStockRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SelectedVariationStockProvider._internal(
        (ref) => create(ref as SelectedVariationStockRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        productId: productId,
        product: product,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _SelectedVariationStockProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedVariationStockProvider &&
        other.productId == productId &&
        other.product == product;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, productId.hashCode);
    hash = _SystemHash.combine(hash, product.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SelectedVariationStockRef on AutoDisposeProviderRef<int> {
  /// The parameter `productId` of this provider.
  int get productId;

  /// The parameter `product` of this provider.
  Product get product;
}

class _SelectedVariationStockProviderElement
    extends AutoDisposeProviderElement<int>
    with SelectedVariationStockRef {
  _SelectedVariationStockProviderElement(super.provider);

  @override
  int get productId => (origin as SelectedVariationStockProvider).productId;
  @override
  Product get product => (origin as SelectedVariationStockProvider).product;
}

String _$selectedVariationHash() => r'9c83b94530d094e997f8aa9c7fd12444c6e9cf2a';

/// Gestiona las variaciones seleccionadas por producto
///
/// Copied from [SelectedVariation].
@ProviderFor(SelectedVariation)
final selectedVariationProvider =
    NotifierProvider<SelectedVariation, Map<int, int?>>.internal(
      SelectedVariation.new,
      name: r'selectedVariationProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedVariationHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedVariation = Notifier<Map<int, int?>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
