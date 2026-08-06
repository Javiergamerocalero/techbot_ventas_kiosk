import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/cart/cart.dart';
import '../../models/config/invoice_type.dart';
import '../../models/invoice/electronic_invoice_response.dart';
import '../../services/electronic_invoice_service.dart';

part 'electronic_invoice_provider.g.dart';

/// Provider para manejar la generación de facturas electrónicas
@riverpod
class ElectronicInvoice extends _$ElectronicInvoice {
  @override
  Map<String, dynamic>? build() => null;
  
  /// Genera el JSON de facturación electrónica
  /// 
  Future<Map<String, dynamic>> generateInvoice({
    required Cart cart,
    required InvoiceData invoiceData,
    required int numeroCorrelativo,
    required String serie,
    String? orderId,
    String? paymentMethodName,
  }) async {
    try {
      final service = ElectronicInvoiceService();
      
      final json = await service.generateInvoiceJson(
        cart: cart,
        invoiceData: invoiceData,
        numeroCorrelativo: numeroCorrelativo,
        serie: serie,
        orderId: orderId,
        paymentMethodName: paymentMethodName,
      );
      
      state = json;
      return json;
    } catch (e) {
      print('❌ Error generando factura: $e');
      rethrow;
    }
  }
  
  /// Genera y envía el comprobante al API externo 
  /// 
  Future<ElectronicInvoiceResponse> generateAndSendInvoice({
    required Cart cart,
    required InvoiceData invoiceData,
    required int numeroCorrelativo,
    required String serie,
    String? orderId,
    String? paymentMethodName,
  }) async {
    print('📤 Generando y enviando comprobante...');
    
    try {
      final service = ElectronicInvoiceService();
      
      final json = await service.generateInvoiceJson(
        cart: cart,
        invoiceData: invoiceData,
        numeroCorrelativo: numeroCorrelativo,
        serie: serie,
        orderId: orderId,
        paymentMethodName: paymentMethodName,
      );
      
      final response = await service.sendToApi(json);
      print('✅ Respuesta del API: ${response.aceptadaPorSunat ? "Aceptada" : "Pendiente"}');
      
      return response;
    } catch (e) {
      print('❌ Error enviando comprobante: $e');
      rethrow;
    }
  }
  
  /// Limpia el estado de la factura
  void resetInvoice() {
    state = null;
  }
}

/// Provider para verificar si hay una factura generada
@riverpod
bool hasGeneratedInvoice(Ref ref) {
  final invoice = ref.watch(electronicInvoiceProvider);
  return invoice != null;
}

/// Provider para obtener el tipo de comprobante de la última factura
@riverpod
String? invoiceType(Ref ref) {
  final invoice = ref.watch(electronicInvoiceProvider);
  if (invoice == null) return null;
  
  final tipoComprobante = invoice['tipo_de_comprobante'] as int?;
  if (tipoComprobante == null) return null;
  
  switch (tipoComprobante) {
    case 1:
      return 'FACTURA';
    case 2:
      return 'BOLETA';
    case 3:
      return 'NOTA DE CRÉDITO';
    case 4:
      return 'NOTA DE DÉBITO';
    default:
      return 'DESCONOCIDO';
  }
}

/// Provider para obtener el total de la última factura
@riverpod
String? invoiceTotal(Ref ref) {
  final invoice = ref.watch(electronicInvoiceProvider);
  return invoice?['total'] as String?;
}

/// Provider para obtener la serie y número de la última factura
@riverpod
String? invoiceSerieNumero(Ref ref) {
  final invoice = ref.watch(electronicInvoiceProvider);
  if (invoice == null) return null;
  
  final serie = invoice['serie'] as String?;
  final numero = invoice['numero'] as String?;
  
  if (serie == null || numero == null) return null;
  
  return '$serie-$numero';
}
