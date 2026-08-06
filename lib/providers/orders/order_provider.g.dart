// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$orderServiceHash() => r'ae4eccb84bbce46d738a84c83952fe6bcc801ec2';

/// Provider para el servicio de órdenes.
///
/// Copied from [orderService].
@ProviderFor(orderService)
final orderServiceProvider = Provider<OrderService>.internal(
  orderService,
  name: r'orderServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef OrderServiceRef = ProviderRef<OrderService>;
String _$processOrderHash() => r'506bda7a1fd45fb1182fa808c277ca3e14a31975';

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

/// Provider para procesar una orden.
///
/// Copied from [processOrder].
@ProviderFor(processOrder)
const processOrderProvider = ProcessOrderFamily();

/// Provider para procesar una orden.
///
/// Copied from [processOrder].
class ProcessOrderFamily extends Family<AsyncValue<OrderResponse>> {
  /// Provider para procesar una orden.
  ///
  /// Copied from [processOrder].
  const ProcessOrderFamily();

  /// Provider para procesar una orden.
  ///
  /// Copied from [processOrder].
  ProcessOrderProvider call(
    double finalAmount,
    String? couponCode,
    Map<String, dynamic>? paymentData,
  ) {
    return ProcessOrderProvider(finalAmount, couponCode, paymentData);
  }

  @override
  ProcessOrderProvider getProviderOverride(
    covariant ProcessOrderProvider provider,
  ) {
    return call(
      provider.finalAmount,
      provider.couponCode,
      provider.paymentData,
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
  String? get name => r'processOrderProvider';
}

/// Provider para procesar una orden.
///
/// Copied from [processOrder].
class ProcessOrderProvider extends AutoDisposeFutureProvider<OrderResponse> {
  /// Provider para procesar una orden.
  ///
  /// Copied from [processOrder].
  ProcessOrderProvider(
    double finalAmount,
    String? couponCode,
    Map<String, dynamic>? paymentData,
  ) : this._internal(
        (ref) => processOrder(
          ref as ProcessOrderRef,
          finalAmount,
          couponCode,
          paymentData,
        ),
        from: processOrderProvider,
        name: r'processOrderProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$processOrderHash,
        dependencies: ProcessOrderFamily._dependencies,
        allTransitiveDependencies:
            ProcessOrderFamily._allTransitiveDependencies,
        finalAmount: finalAmount,
        couponCode: couponCode,
        paymentData: paymentData,
      );

  ProcessOrderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.finalAmount,
    required this.couponCode,
    required this.paymentData,
  }) : super.internal();

  final double finalAmount;
  final String? couponCode;
  final Map<String, dynamic>? paymentData;

  @override
  Override overrideWith(
    FutureOr<OrderResponse> Function(ProcessOrderRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ProcessOrderProvider._internal(
        (ref) => create(ref as ProcessOrderRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        finalAmount: finalAmount,
        couponCode: couponCode,
        paymentData: paymentData,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<OrderResponse> createElement() {
    return _ProcessOrderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProcessOrderProvider &&
        other.finalAmount == finalAmount &&
        other.couponCode == couponCode &&
        other.paymentData == paymentData;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, finalAmount.hashCode);
    hash = _SystemHash.combine(hash, couponCode.hashCode);
    hash = _SystemHash.combine(hash, paymentData.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProcessOrderRef on AutoDisposeFutureProviderRef<OrderResponse> {
  /// The parameter `finalAmount` of this provider.
  double get finalAmount;

  /// The parameter `couponCode` of this provider.
  String? get couponCode;

  /// The parameter `paymentData` of this provider.
  Map<String, dynamic>? get paymentData;
}

class _ProcessOrderProviderElement
    extends AutoDisposeFutureProviderElement<OrderResponse>
    with ProcessOrderRef {
  _ProcessOrderProviderElement(super.provider);

  @override
  double get finalAmount => (origin as ProcessOrderProvider).finalAmount;
  @override
  String? get couponCode => (origin as ProcessOrderProvider).couponCode;
  @override
  Map<String, dynamic>? get paymentData =>
      (origin as ProcessOrderProvider).paymentData;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
