import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../services/internal_invoice_service.dart';
import '../config/license_provider.dart';

part 'internal_invoice_provider.g.dart';

/// Función helper para obtener la URL base
String _getBaseUrl() {
  final appEnv = dotenv.get('APP_ENV');
  return appEnv == 'development'
      ? dotenv.get('DEV_URL', fallback: 'DEV_URL not found')
      : dotenv.get('PROD_URL', fallback: 'PROD_URL not found');
}

/// Provider del servicio de facturación interna
@riverpod
InternalInvoiceService internalInvoiceService(
     ref,
) {
  return InternalInvoiceService(
    baseUrl: _getBaseUrl(),
    token: dotenv.get('TECHBOT_API_TOKEN'),
  );
}

/// Provider para operaciones de facturación interna
@riverpod
class InternalInvoice extends _$InternalInvoice {
  @override
  FutureOr<void> build() {}

  /// Reserva un número de correlativo para la factura
  Future<Map<String, dynamic>> reserveNumber({
    required int orderId,
    required String documentType, // "boleta" o "factura"
  }) async {
    final service = ref.read(internalInvoiceServiceProvider);
    final licenseAsync = await ref.read(licenseProvider.future);

    print('🔑 Usando License ID: ${licenseAsync.id}');

    return await service.reserveInvoiceNumber(
      orderId: orderId,
      licenseId: licenseAsync.id,
      documentType: documentType,
    );
  }

  /// Finaliza la factura guardando la respuesta del API externo
  Future<Map<String, dynamic>> finalize({
    required int invoiceId,
    required Map<String, dynamic> invoiceData,
  }) async {
    final service = ref.read(internalInvoiceServiceProvider);
    final licenseAsync = await ref.read(licenseProvider.future);

    print('🔑 Usando License ID: ${licenseAsync.id}');

    return await service.finalizeInvoice(
      invoiceId: invoiceId,
      licenseId: licenseAsync.id,
      invoiceData: invoiceData,
    );
  }

  /// Cancela una factura reservada (rollback)
  Future<void> cancel({
    required int invoiceId,
    String? reason,
  }) async {
    final service = ref.read(internalInvoiceServiceProvider);
    final licenseAsync = await ref.read(licenseProvider.future);

    print('🔑 Usando License ID: ${licenseAsync.id}');

    await service.cancelInvoice(
      invoiceId: invoiceId,
      licenseId: licenseAsync.id,
      reason: reason,
    );
  }
}
