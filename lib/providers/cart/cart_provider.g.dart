// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cartTotalItemsHash() => r'c66762049c39f54bd421ac4c8e974612d3bb0939';

/// Provider para obtener la cantidad total de items en el carrito (productos + combos)
///
/// Copied from [cartTotalItems].
@ProviderFor(cartTotalItems)
final cartTotalItemsProvider = AutoDisposeProvider<int>.internal(
  cartTotalItems,
  name: r'cartTotalItemsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartTotalItemsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartTotalItemsRef = AutoDisposeProviderRef<int>;
String _$cartTotalPriceHash() => r'bdfc20c3ed4c674a7a466d9b5db90d9c8e05710c';

/// Obtener el precio total del carrito
///
/// Copied from [cartTotalPrice].
@ProviderFor(cartTotalPrice)
final cartTotalPriceProvider = AutoDisposeProvider<double>.internal(
  cartTotalPrice,
  name: r'cartTotalPriceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartTotalPriceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CartTotalPriceRef = AutoDisposeProviderRef<double>;
String _$productInCartHash() => r'954a9ac5524d1bb89de72cfc1d1000ff26e0598a';

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

/// Para verificar si un producto está en el carrito
///
/// Copied from [productInCart].
@ProviderFor(productInCart)
const productInCartProvider = ProductInCartFamily();

/// Para verificar si un producto está en el carrito
///
/// Copied from [productInCart].
class ProductInCartFamily extends Family<CartItem?> {
  /// Para verificar si un producto está en el carrito
  ///
  /// Copied from [productInCart].
  const ProductInCartFamily();

  /// Para verificar si un producto está en el carrito
  ///
  /// Copied from [productInCart].
  ProductInCartProvider call(String productId) {
    return ProductInCartProvider(productId);
  }

  @override
  ProductInCartProvider getProviderOverride(
    covariant ProductInCartProvider provider,
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
  String? get name => r'productInCartProvider';
}

/// Para verificar si un producto está en el carrito
///
/// Copied from [productInCart].
class ProductInCartProvider extends AutoDisposeProvider<CartItem?> {
  /// Para verificar si un producto está en el carrito
  ///
  /// Copied from [productInCart].
  ProductInCartProvider(String productId)
    : this._internal(
        (ref) => productInCart(ref as ProductInCartRef, productId),
        from: productInCartProvider,
        name: r'productInCartProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productInCartHash,
        dependencies: ProductInCartFamily._dependencies,
        allTransitiveDependencies:
            ProductInCartFamily._allTransitiveDependencies,
        productId: productId,
      );

  ProductInCartProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.productId,
  }) : super.internal();

  final String productId;

  @override
  Override overrideWith(CartItem? Function(ProductInCartRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: ProductInCartProvider._internal(
        (ref) => create(ref as ProductInCartRef),
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
  AutoDisposeProviderElement<CartItem?> createElement() {
    return _ProductInCartProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductInCartProvider && other.productId == productId;
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
mixin ProductInCartRef on AutoDisposeProviderRef<CartItem?> {
  /// The parameter `productId` of this provider.
  String get productId;
}

class _ProductInCartProviderElement
    extends AutoDisposeProviderElement<CartItem?>
    with ProductInCartRef {
  _ProductInCartProviderElement(super.provider);

  @override
  String get productId => (origin as ProductInCartProvider).productId;
}

String _$comboInCartHash() => r'e24e7c82198b59e0b9283c21a590a0bf6a9351ac';

/// Para verificar si un combo está en el carrito
///
/// Copied from [comboInCart].
@ProviderFor(comboInCart)
const comboInCartProvider = ComboInCartFamily();

/// Para verificar si un combo está en el carrito
///
/// Copied from [comboInCart].
class ComboInCartFamily extends Family<ComboCartItem?> {
  /// Para verificar si un combo está en el carrito
  ///
  /// Copied from [comboInCart].
  const ComboInCartFamily();

  /// Para verificar si un combo está en el carrito
  ///
  /// Copied from [comboInCart].
  ComboInCartProvider call(String comboId) {
    return ComboInCartProvider(comboId);
  }

  @override
  ComboInCartProvider getProviderOverride(
    covariant ComboInCartProvider provider,
  ) {
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
  String? get name => r'comboInCartProvider';
}

/// Para verificar si un combo está en el carrito
///
/// Copied from [comboInCart].
class ComboInCartProvider extends AutoDisposeProvider<ComboCartItem?> {
  /// Para verificar si un combo está en el carrito
  ///
  /// Copied from [comboInCart].
  ComboInCartProvider(String comboId)
    : this._internal(
        (ref) => comboInCart(ref as ComboInCartRef, comboId),
        from: comboInCartProvider,
        name: r'comboInCartProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$comboInCartHash,
        dependencies: ComboInCartFamily._dependencies,
        allTransitiveDependencies: ComboInCartFamily._allTransitiveDependencies,
        comboId: comboId,
      );

  ComboInCartProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.comboId,
  }) : super.internal();

  final String comboId;

  @override
  Override overrideWith(
    ComboCartItem? Function(ComboInCartRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ComboInCartProvider._internal(
        (ref) => create(ref as ComboInCartRef),
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
  AutoDisposeProviderElement<ComboCartItem?> createElement() {
    return _ComboInCartProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ComboInCartProvider && other.comboId == comboId;
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
mixin ComboInCartRef on AutoDisposeProviderRef<ComboCartItem?> {
  /// The parameter `comboId` of this provider.
  String get comboId;
}

class _ComboInCartProviderElement
    extends AutoDisposeProviderElement<ComboCartItem?>
    with ComboInCartRef {
  _ComboInCartProviderElement(super.provider);

  @override
  String get comboId => (origin as ComboInCartProvider).comboId;
}

String _$cartNotifierHash() => r'a360e1083f061d97d33d9754e209198377ff643f';

/// See also [CartNotifier].
@ProviderFor(CartNotifier)
final cartNotifierProvider = NotifierProvider<CartNotifier, Cart>.internal(
  CartNotifier.new,
  name: r'cartNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cartNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CartNotifier = Notifier<Cart>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
