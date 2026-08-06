// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electronic_invoice_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$hasGeneratedInvoiceHash() =>
    r'faf05591f7557d034eb1129eeb8fae617691061e';

/// Provider para verificar si hay una factura generada
///
/// Copied from [hasGeneratedInvoice].
@ProviderFor(hasGeneratedInvoice)
final hasGeneratedInvoiceProvider = AutoDisposeProvider<bool>.internal(
  hasGeneratedInvoice,
  name: r'hasGeneratedInvoiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasGeneratedInvoiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasGeneratedInvoiceRef = AutoDisposeProviderRef<bool>;
String _$invoiceTypeHash() => r'b9dd62d30080beeb18bae8358e8c9738e9120fa1';

/// Provider para obtener el tipo de comprobante de la última factura
///
/// Copied from [invoiceType].
@ProviderFor(invoiceType)
final invoiceTypeProvider = AutoDisposeProvider<String?>.internal(
  invoiceType,
  name: r'invoiceTypeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$invoiceTypeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InvoiceTypeRef = AutoDisposeProviderRef<String?>;
String _$invoiceTotalHash() => r'd3b048887b6dbfd87eb26f40366b337ed057a296';

/// Provider para obtener el total de la última factura
///
/// Copied from [invoiceTotal].
@ProviderFor(invoiceTotal)
final invoiceTotalProvider = AutoDisposeProvider<String?>.internal(
  invoiceTotal,
  name: r'invoiceTotalProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$invoiceTotalHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InvoiceTotalRef = AutoDisposeProviderRef<String?>;
String _$invoiceSerieNumeroHash() =>
    r'ffa205e70f3740e61d3bc2ead4fcc540ecee4907';

/// Provider para obtener la serie y número de la última factura
///
/// Copied from [invoiceSerieNumero].
@ProviderFor(invoiceSerieNumero)
final invoiceSerieNumeroProvider = AutoDisposeProvider<String?>.internal(
  invoiceSerieNumero,
  name: r'invoiceSerieNumeroProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$invoiceSerieNumeroHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InvoiceSerieNumeroRef = AutoDisposeProviderRef<String?>;
String _$electronicInvoiceHash() => r'b4599247d9f2094c017f8ed9b68f363a3d90f05d';

/// Provider para manejar la generación de facturas electrónicas
///
/// Copied from [ElectronicInvoice].
@ProviderFor(ElectronicInvoice)
final electronicInvoiceProvider =
    AutoDisposeNotifierProvider<
      ElectronicInvoice,
      Map<String, dynamic>?
    >.internal(
      ElectronicInvoice.new,
      name: r'electronicInvoiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$electronicInvoiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ElectronicInvoice = AutoDisposeNotifier<Map<String, dynamic>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
