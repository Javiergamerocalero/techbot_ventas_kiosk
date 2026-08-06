// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$invoiceSettingsHash() => r'23c9e6477286b7b2720a02b9166a283b153e55ef';

/// Configuración de la facturación electrónica del kiosko.
///
/// Permite suspender el envío de comprobantes al servicio de facturación
/// electrónica (TechFact). Cuando está suspendida, el kiosko solo imprime el
/// comprobante, sin reservar correlativo ni enviar a TechFact.
///
/// Copied from [InvoiceSettings].
@ProviderFor(InvoiceSettings)
final invoiceSettingsProvider =
    AsyncNotifierProvider<InvoiceSettings, bool>.internal(
      InvoiceSettings.new,
      name: r'invoiceSettingsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$invoiceSettingsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$InvoiceSettings = AsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
