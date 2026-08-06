// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_methods_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activePaymentMethodsHash() =>
    r'146d44f5f9dfafa4579d535599a2d6f59b48741c';

/// Provider derivado para obtener métodos activos
///
/// Copied from [activePaymentMethods].
@ProviderFor(activePaymentMethods)
final activePaymentMethodsProvider =
    AutoDisposeProvider<List<PaymentMethod>>.internal(
      activePaymentMethods,
      name: r'activePaymentMethodsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$activePaymentMethodsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ActivePaymentMethodsRef = AutoDisposeProviderRef<List<PaymentMethod>>;
String _$isPaymentMethodActiveHash() =>
    r'148dfcf1b571eec4dfe99ec9f389d669a80fdc71';

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

/// Provider derivado para verificar si un método está activo
///
/// Copied from [isPaymentMethodActive].
@ProviderFor(isPaymentMethodActive)
const isPaymentMethodActiveProvider = IsPaymentMethodActiveFamily();

/// Provider derivado para verificar si un método está activo
///
/// Copied from [isPaymentMethodActive].
class IsPaymentMethodActiveFamily extends Family<bool> {
  /// Provider derivado para verificar si un método está activo
  ///
  /// Copied from [isPaymentMethodActive].
  const IsPaymentMethodActiveFamily();

  /// Provider derivado para verificar si un método está activo
  ///
  /// Copied from [isPaymentMethodActive].
  IsPaymentMethodActiveProvider call(PaymentMethodType type) {
    return IsPaymentMethodActiveProvider(type);
  }

  @override
  IsPaymentMethodActiveProvider getProviderOverride(
    covariant IsPaymentMethodActiveProvider provider,
  ) {
    return call(provider.type);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isPaymentMethodActiveProvider';
}

/// Provider derivado para verificar si un método está activo
///
/// Copied from [isPaymentMethodActive].
class IsPaymentMethodActiveProvider extends AutoDisposeProvider<bool> {
  /// Provider derivado para verificar si un método está activo
  ///
  /// Copied from [isPaymentMethodActive].
  IsPaymentMethodActiveProvider(PaymentMethodType type)
    : this._internal(
        (ref) => isPaymentMethodActive(ref as IsPaymentMethodActiveRef, type),
        from: isPaymentMethodActiveProvider,
        name: r'isPaymentMethodActiveProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isPaymentMethodActiveHash,
        dependencies: IsPaymentMethodActiveFamily._dependencies,
        allTransitiveDependencies:
            IsPaymentMethodActiveFamily._allTransitiveDependencies,
        type: type,
      );

  IsPaymentMethodActiveProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
  }) : super.internal();

  final PaymentMethodType type;

  @override
  Override overrideWith(
    bool Function(IsPaymentMethodActiveRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsPaymentMethodActiveProvider._internal(
        (ref) => create(ref as IsPaymentMethodActiveRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsPaymentMethodActiveProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsPaymentMethodActiveProvider && other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsPaymentMethodActiveRef on AutoDisposeProviderRef<bool> {
  /// The parameter `type` of this provider.
  PaymentMethodType get type;
}

class _IsPaymentMethodActiveProviderElement
    extends AutoDisposeProviderElement<bool>
    with IsPaymentMethodActiveRef {
  _IsPaymentMethodActiveProviderElement(super.provider);

  @override
  PaymentMethodType get type => (origin as IsPaymentMethodActiveProvider).type;
}

String _$paymentMethodsNotifierHash() =>
    r'69ed916219b998d1174fc5f4d6cb00aa1c00aa9f';

/// Provider para gestionar los métodos de pago
///
/// Copied from [PaymentMethodsNotifier].
@ProviderFor(PaymentMethodsNotifier)
final paymentMethodsNotifierProvider =
    AsyncNotifierProvider<
      PaymentMethodsNotifier,
      PaymentMethodsConfig
    >.internal(
      PaymentMethodsNotifier.new,
      name: r'paymentMethodsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$paymentMethodsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PaymentMethodsNotifier = AsyncNotifier<PaymentMethodsConfig>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
