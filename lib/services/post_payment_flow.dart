import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/cart/cart.dart';
import 'package:ventas_kiosko/models/config/invoice_type.dart';
import 'package:ventas_kiosko/providers/config/invoice_settings_provider.dart';
import 'package:ventas_kiosko/providers/config/license_provider.dart';
import 'package:ventas_kiosko/providers/invoice/electronic_invoice_provider.dart';
import 'package:ventas_kiosko/providers/invoice/internal_invoice_provider.dart';
import 'package:ventas_kiosko/providers/orders/order_provider.dart';
import 'package:ventas_kiosko/providers/printer/printer_provider.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/services/app_log.dart';
import 'package:ventas_kiosko/services/ticket_service.dart';

/// Lo que hay que hacer DESPUÉS de que el pago se aprueba, sin importar
/// con qué medio se cobró: registrar la orden, emitir el comprobante e
/// imprimir el ticket de venta.
///
/// Existe porque el camino de Izipay se saltaba los tres pasos: cobraba,
/// imprimía el voucher del pinpad y daba la venta por terminada. Javier lo
/// notó el 2026-09-16 — "solo está imprimiendo el voucher, no el
/// comprobante de pago" — y el voucher es del banco, no es el comprobante
/// de la venta.
///
/// Ningún paso puede tumbar una venta ya cobrada: el dinero ya se movió.
/// Por eso cada uno atrapa su error, lo deja anotado en el registro y el
/// resto sigue.
class PostPaymentFlow {
  const PostPaymentFlow._();

  /// Corre la secuencia completa. [paymentData] son los datos del cobro
  /// que van al backend y al ticket.
  static Future<PostPaymentResult> run({
    required WidgetRef ref,
    required Cart cart,
    required Map<String, dynamic> paymentData,
    required String paymentMethodName,
    InvoiceData? invoiceData,
  }) async {
    int? orderId;
    String? numeroComprobante;
    final problemas = <String>[];

    // ── Carrito en el servidor ───────────────────────────────────────
    // `order/store` NO recibe las líneas: arma la orden con el carrito
    // que tiene el servidor para esta licencia. Si alguna línea no llegó
    // —una validación de stock que no salió, un error suelto— la orden
    // se crea sin detalle, que es lo que vio Javier el 2026-09-17: la
    // factura existía pero "Detalles de Orden: Sin resultados".
    //
    // Por eso se vuelven a mandar todas las líneas justo antes de crear
    // la orden. Es idempotente: `cart/manage` fija la cantidad total del
    // producto, no la incrementa.
    await _sincronizarCarrito(ref, cart, problemas);

    // ── Orden ────────────────────────────────────────────────────────
    try {
      final respuesta = await ref.read(
        processOrderProvider(
          cart.finalPrice,
          cart.appliedCoupon?.code,
          paymentData,
        ).future,
      );
      orderId = respuesta.orderId;
    } catch (e) {
      problemas.add('no se pudo registrar la orden: $e');
      AppLog.registrar(
        categoria: AppLogCategoria.facturacion,
        operacion: 'crear orden',
        request: {'total': cart.finalPrice, 'medio': paymentMethodName},
        ok: false,
        detalle: e.toString(),
      );
    }

    // ── Comprobante electrónico ──────────────────────────────────────
    final suspendida = ref.read(electronicInvoiceSuspendedProvider);
    if (!suspendida && invoiceData != null && orderId != null) {
      numeroComprobante = await _facturar(
        ref: ref,
        cart: cart,
        invoiceData: invoiceData,
        orderId: orderId,
        paymentMethodName: paymentMethodName,
        problemas: problemas,
      );
    }

    // ── Ticket de venta ──────────────────────────────────────────────
    // Va al final y con el carrito todavía cargado: si se limpia antes,
    // el ticket sale vacío.
    try {
      final licencia = await ref.read(licenseProvider.future);
      final esFactura = invoiceData?.type == InvoiceType.facturaElectronica;
      final ticket = TicketService.generateTicketString(
        cart: cart,
        paymentData: paymentData,
        deviceName: licencia.deviceName,
        businessInfo: ref.read(licenseProvider.notifier).currentBusinessInfo,
        fiscal: !suspendida,
        nombreDelComprobante: esFactura
            ? 'FACTURA ELECTRÓNICA'
            : 'BOLETA DE VENTA ELECTRÓNICA',
        // El número real del comprobante, el que emitió el proveedor. Si
        // la emisión falló no se imprime ninguno, que es mejor que
        // imprimir uno inventado.
        numeroDelComprobante: numeroComprobante,
      );
      await ref
          .read(printerManagerProvider.notifier)
          .print(ticket, partialCut: true);
    } catch (e) {
      problemas.add('no se pudo imprimir el ticket: $e');
      AppLog.registrar(
        categoria: AppLogCategoria.facturacion,
        operacion: 'imprimir ticket',
        ok: false,
        detalle: e.toString(),
      );
    }

    return PostPaymentResult(
      orderId: orderId,
      numeroComprobante: numeroComprobante,
      problemas: problemas,
    );
  }

  /// Deja el carrito del servidor igual al que se va a cobrar.
  static Future<void> _sincronizarCarrito(
    WidgetRef ref,
    Cart cart,
    List<String> problemas,
  ) async {
    final stock = ref.read(stockServiceProvider);
    final enviadas = <String, dynamic>{};

    for (final item in cart.items) {
      try {
        await stock.checkProductStock(
          item.product.id,
          item.quantity,
          variationId: item.selectedVariation?.id,
        );
        enviadas['producto ${item.product.id}'] = item.quantity;
      } catch (e) {
        problemas.add('no se pudo sincronizar «${item.product.name}»: $e');
      }
    }

    for (final item in cart.comboItems) {
      try {
        await stock.updateComboCart(item.combo.id, item.quantity);
        enviadas['combo ${item.combo.id}'] = item.quantity;
      } catch (e) {
        problemas.add('no se pudo sincronizar el combo '
            '«${item.combo.name}»: $e');
      }
    }

    AppLog.registrar(
      categoria: AppLogCategoria.facturacion,
      operacion: 'sincronizar carrito antes de la orden',
      request: enviadas,
      ok: problemas.isEmpty,
      detalle: '${cart.items.length} productos y '
          '${cart.comboItems.length} combos',
    );
  }

  /// Reserva el correlativo, manda el comprobante al proveedor y lo
  /// finaliza. Si algo falla, libera la reserva para no quemar números.
  static Future<String?> _facturar({
    required WidgetRef ref,
    required Cart cart,
    required InvoiceData invoiceData,
    required int orderId,
    required String paymentMethodName,
    required List<String> problemas,
  }) async {
    final tipo = invoiceData.type == InvoiceType.facturaElectronica
        ? 'factura'
        : 'boleta';
    int? reservaId;

    try {
      final reserva = await ref
          .read(internalInvoiceProvider.notifier)
          .reserveNumber(orderId: orderId, documentType: tipo);
      final data = reserva['data'] as Map<String, dynamic>;
      reservaId = data['invoice_id'] as int;
      final numero = data['invoice_number'] as int;
      // El backend ya devuelve el número con ceros, "B999-000005", que es
      // como debe verse impreso.
      final numeroFormateado = data['formatted_number'] as String?;
      var serie = data['series_prefix'] as String?;
      if (serie == null || serie.isEmpty) {
        serie = tipo == 'factura' ? 'F001' : 'B001';
      }

      final externo = await ref
          .read(electronicInvoiceProvider.notifier)
          .generateAndSendInvoice(
            cart: cart,
            invoiceData: invoiceData,
            numeroCorrelativo: numero,
            serie: serie,
            orderId: orderId.toString(),
            paymentMethodName: paymentMethodName,
          );

      if (externo.enlace.isEmpty) {
        final motivo = externo.errorMessage?.trim().isNotEmpty == true
            ? externo.errorMessage!
            : 'el proveedor no devolvió el comprobante';
        problemas.add('el proveedor rechazó el comprobante: $motivo');
        await _liberarReserva(ref, reservaId, motivo);
        return null;
      }

      await ref.read(internalInvoiceProvider.notifier).finalize(
            invoiceId: reservaId,
            invoiceData: externo.toJson(),
          );
      return numeroFormateado?.trim().isNotEmpty == true
          ? numeroFormateado!
          : externo.numeroCompleto;
    } catch (e) {
      problemas.add('falló la facturación: $e');
      AppLog.registrar(
        categoria: AppLogCategoria.facturacion,
        operacion: 'facturar',
        request: {'orden': orderId, 'tipo': tipo},
        ok: false,
        detalle: e.toString(),
      );
      await _liberarReserva(ref, reservaId, 'Error en proceso: $e');
      return null;
    }
  }

  static Future<void> _liberarReserva(
    WidgetRef ref,
    int? reservaId,
    String motivo,
  ) async {
    if (reservaId == null) return;
    try {
      await ref
          .read(internalInvoiceProvider.notifier)
          .cancel(invoiceId: reservaId, reason: motivo);
    } catch (_) {
      // Si tampoco se puede liberar, no hay más que hacer desde acá.
    }
  }
}

class PostPaymentResult {
  const PostPaymentResult({
    this.orderId,
    this.numeroComprobante,
    this.problemas = const [],
  });

  final int? orderId;
  final String? numeroComprobante;

  /// Lo que salió mal sin llegar a invalidar la venta.
  final List<String> problemas;

  bool get todoBien => problemas.isEmpty;
}
