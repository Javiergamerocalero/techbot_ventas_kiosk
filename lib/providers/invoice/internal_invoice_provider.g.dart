// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internal_invoice_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$internalInvoiceServiceHash() =>
    r'6f73e0300a9ff962dc72daeff848a1fb41c04333';

/// Provider del servicio de facturación interna
///
/// Copied from [internalInvoiceService].
@ProviderFor(internalInvoiceService)
final internalInvoiceServiceProvider =
    AutoDisposeProvider<InternalInvoiceService>.internal(
      internalInvoiceService,
      name: r'internalInvoiceServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$internalInvoiceServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InternalInvoiceServiceRef =
    AutoDisposeProviderRef<InternalInvoiceService>;
String _$internalInvoiceHash() => r'afe1fd9b2a44a97fcbd88c20455ffa299b12b1c4';

/// Provider para operaciones de facturación interna
///
/// Copied from [InternalInvoice].
@ProviderFor(InternalInvoice)
final internalInvoiceProvider =
    AutoDisposeAsyncNotifierProvider<InternalInvoice, void>.internal(
      InternalInvoice.new,
      name: r'internalInvoiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$internalInvoiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$InternalInvoice = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
