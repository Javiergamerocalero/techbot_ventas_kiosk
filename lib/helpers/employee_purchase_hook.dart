import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/cart/cart.dart';
import '../models/cart/cart_item.dart';
import '../models/combos/combo.dart';
import '../models/combos/combo_cart_item.dart';
import '../providers/employee/employee_session_provider.dart';
import '../services/employee_validator_service.dart';
import '../services/sanfernando_vtex_service.dart';

/// Registra la compra actual contra el servicio de validación de San
/// Fernando si hay una sesión de empleado activa. Idempotente por
/// sesión: al registrar exitosamente limpia la sesión, así llamar
/// desde múltiples puntos post-pago no genera duplicados.
///
/// No lanza excepciones — cualquier error se loguea y se continúa,
/// para no bloquear el flow del pago (el cobro ya está hecho por el
/// pinpad / efectivo).
///
/// Desde 2026-08-25 acepta también un [cart] + [paymentMethod] +
/// [invoiceType] + [invoiceDocument] opcionales para reportar la
/// venta al backend VTEX de San Fernando (ver
/// [SanFernandoVtexService]). Si esos parámetros no vienen o si el
/// feature flag `SANFERNANDO_VTEX_ENABLED` está `false`, se omite
/// silenciosamente — así los callers que aún no arman el context no
/// se rompen.
class EmployeePurchaseHook {
  const EmployeePurchaseHook._();

  /// Debe llamarse UNA vez tras cada pago aprobado (Izipay, Niubiz,
  /// Cashdro, etc.). Si el kiosco no está en modo San Fernando o el
  /// usuario no se identificó, no hace nada.
  static Future<void> registerIfEmployeeSession(
    WidgetRef ref, {
    required double amount,
    String? externalReference,
    Cart? cart,
    SanFernandoPaymentMethod? paymentMethod,
    String invoiceType = 'boleta',
    String? invoiceDocument,
    String? invoiceSocialReason,
    int? paymentMethodCash,
    int? orderId,
  }) async {
    final session = ref.read(employeeSessionProvider);
    if (session == null) return;
    final employee = session.employee;
    if (employee.id == 0) {
      // Fallback: el response del /validate no trajo id — no podemos
      // registrar la compra sin el id numérico. Se loguea y se limpia
      // la sesión igual (para no bloquear futuras validaciones).
      // ignore: avoid_print
      print('⚠️ Employee id=0, skipping purchase registration');
      ref.read(employeeSessionProvider.notifier).clear();
      return;
    }
    try {
      final service = ref.read(employeeValidatorServiceProvider);
      final result = await service.registerPurchase(
        employeeId: employee.id,
        amount: amount,
        externalReference: externalReference,
      );
      if (!result.success) {
        // ignore: avoid_print
        print('⚠️ Purchase register failed: ${result.error}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('⚠️ Purchase register exception: $e');
    }

    // Reporte VTEX (San Fernando corporativo). Corre solo si el
    // feature flag está on y el caller pasó suficiente contexto —
    // sino sale silencioso. Es fire-and-forget: el resultado se
    // loguea pero NO afecta el flow del pago (el cobro ya se hizo).
    if (SanFernandoVtexService.enabled &&
        cart != null &&
        paymentMethod != null &&
        invoiceDocument != null &&
        orderId != null) {
      _reportVtexOrder(
        employee: employee,
        cart: cart,
        amount: amount,
        paymentMethod: paymentMethod,
        paymentMethodCash: paymentMethodCash,
        invoiceType: invoiceType,
        invoiceDocument: invoiceDocument,
        invoiceSocialReason: invoiceSocialReason,
        orderId: orderId,
      );
    }

    // Limpiamos la sesión igual — el próximo empleado tiene que
    // volver a identificarse desde el standby.
    ref.read(employeeSessionProvider.notifier).clear();
  }

  /// Arma el context y dispara el POST /api/v1/order al backend
  /// VTEX. Fire-and-forget: no bloquea ni retorna. Todos los errores
  /// van al log.
  ///
  /// Las decisiones de mapeo (type_cart="pt", delivery_type=4,
  /// dirección de la planta, etc.) viven en [SanFernandoVtexService]
  /// junto con las constantes editables.
  static void _reportVtexOrder({
    required Employee employee,
    required Cart cart,
    required double amount,
    required SanFernandoPaymentMethod paymentMethod,
    int? paymentMethodCash,
    required String invoiceType,
    required String invoiceDocument,
    String? invoiceSocialReason,
    required int orderId,
  }) {
    // Split nombre completo en firstName / lastName. El validador
    // solo guarda `fullName` — asumimos el primer token como nombre
    // y el resto como apellidos. Si SF necesita split preciso, hay
    // que ampliar el schema del validator con columnas separadas.
    final parts = employee.fullName.trim().split(RegExp(r'\s+'));
    final firstName = parts.isNotEmpty ? parts.first : employee.fullName;
    final lastName =
        parts.length > 1 ? parts.sublist(1).join(' ') : '';

    // Subtotal / IGV: si el kiosco maneja precios con IGV incluido
    // (asunto típico de Perú), separamos con base 1.18. Es lo mejor
    // que podemos hacer sin metadata explícita de si el precio ya
    // lleva IGV. SF puede recalcular server-side si difiere.
    final subtotal = (amount / 1.18);
    final igv = amount - subtotal;

    final products = <SanFernandoProductLine>[];
    for (final it in cart.items) {
      products.add(
        SanFernandoProductLine(
          name: it.product.name,
          sapCode: it.product.sku,
          priceUnit: double.tryParse(it.product.price) ?? 0,
          referencePrice: double.tryParse(it.product.price) ?? 0,
          subtotal: it.totalPrice,
          quantity: it.quantity,
        ),
      );
    }
    for (final it in cart.comboItems) {
      // El campo `finalPrice` (String?) del combo shadowea la
      // extensión — usamos los getters explícitos como hace el resto
      // del código del carrito. `it.totalPrice` viene de la
      // extensión de ComboCartItem y ya multiplica por quantity.
      final comboPrice = it.combo.hasDiscount
          ? it.combo.discountedPriceAsDouble
          : it.combo.priceAsDouble;
      products.add(
        SanFernandoProductLine(
          name: it.combo.name,
          sapCode: it.combo.id.toString(),
          priceUnit: comboPrice,
          referencePrice: comboPrice,
          subtotal: it.totalPrice,
          quantity: it.quantity,
        ),
      );
    }

    final ctx = SanFernandoOrderContext(
      orderId: orderId,
      total: amount,
      totalBeforeCoupon: amount + (cart.totalDiscount),
      subtotal: subtotal,
      igv: igv,
      couponSaved: cart.totalDiscount,
      employee: SanFernandoEmployeeSnapshot(
        firstName: firstName,
        lastName: lastName,
        documentNumber: employee.documentNumber,
      ),
      products: products,
      coupons: const [],
      paymentMethod: paymentMethod,
      paymentMethodCash: paymentMethodCash,
      invoice: SanFernandoInvoiceInfo(
        type: invoiceType,
        documentNumber: invoiceDocument,
        socialReason: invoiceSocialReason,
      ),
    );

    // Fire-and-forget con log.
    // ignore: discarded_futures
    SanFernandoVtexService.reportOrder(ctx).then((result) {
      if (result.success) {
        // ignore: avoid_print
        print(
          '✅ SF VTEX report OK '
          '(orderId=$orderId, cart_id=${result.cartId}, '
          'already=${result.alreadyReported})',
        );
      } else {
        // ignore: avoid_print
        print(
          '⚠️ SF VTEX report FAILED '
          '(orderId=$orderId, http=${result.statusCode}, '
          'err=${result.error})',
        );
      }
    });
  }
}
