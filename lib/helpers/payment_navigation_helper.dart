import 'package:flutter/material.dart';
import '../models/config/payment_method.dart';
import '../screens/cashdro_payment_screen.dart';
import '../screens/payment_izipay_screen.dart';
import '../services/izipay_service.dart';
import '../screens/payment_standby_screen.dart';

/// Helper para manejar la navegación condicional según el método de pago
class PaymentNavigationHelper {
  /// Navega a la pantalla de pago apropiada según el método seleccionado
  static Future<void> navigateToPaymentScreen({
    required BuildContext context,
    required PaymentMethod paymentMethod,
    required Map<String, dynamic> invoiceData,
    required double amount,
    IzipayMode izipayMode = IzipayMode.tarjeta,
  }) async {
    try {
      print('🚀 PaymentNavigationHelper: Iniciando navegación');
      print('💳 Método de pago: ${paymentMethod.type.displayName}');
      print('💰 Monto: \$${amount.toStringAsFixed(2)}');
      print('📄 Datos de facturación: $invoiceData');

      // Validaciones previas
      _validateNavigationArguments(paymentMethod, amount, invoiceData);

      if (isCashDroPayment(paymentMethod.type)) {
        await _navigateToCashDroPayment(context, paymentMethod, invoiceData, amount);
      } else if (isIzipayPayment(paymentMethod.type)) {
        await _navigateToIzipayPayment(context, invoiceData, amount, izipayMode);
      } else {
        await _navigateToStandardPayment(context, paymentMethod, invoiceData);
      }
    } catch (e) {
      print('❌ Error en navegación de pago: $e');
      // Fallback a PaymentStandbyScreen en caso de error
      print('🔄 Fallback a PaymentStandbyScreen');

      if (!context.mounted) return;
      await _navigateToStandardPayment(context, paymentMethod, invoiceData);
    }
  }

  /// Determina si el método de pago es CashDro
  static bool isCashDroPayment(PaymentMethodType type) {
    switch (type) {
      case PaymentMethodType.cashdroS:
        return true;
      case PaymentMethodType.niubizLane3000:
      case PaymentMethodType.niubizIm30:
      case PaymentMethodType.izipay:
        return false;
    }
  }

  /// Determina si el método de pago es Izipay (PinPad P400 vía API REST).
  static bool isIzipayPayment(PaymentMethodType type) =>
      type == PaymentMethodType.izipay;

  /// Navega a IzipayPaymentScreen (PinPad Izipay en dispositivo Windows).
  static Future<void> _navigateToIzipayPayment(
    BuildContext context,
    Map<String, dynamic> invoiceData,
    double amount,
    IzipayMode mode,
  ) async {
    print('💳 Navegando a IzipayPaymentScreen (amount=$amount, ${mode.name})');
    Navigator.of(context).pushNamed(
      IzipayPaymentScreen.routeName,
      arguments: {
        'amount': amount,
        'invoiceData': invoiceData,
        'izipayMode': mode.name,
      },
    );
  }

  /// Navega a CashDroPaymentScreen
  static Future<void> _navigateToCashDroPayment(
    BuildContext context,
    PaymentMethod paymentMethod,
    Map<String, dynamic> invoiceData,
    double amount,
  ) async {
    print('🏪 Navegando a CashDroPaymentScreen');

    // Generar ticketId único basado en timestamp
    final ticketId = _generateTicketId();
    print('🎫 TicketId generado: $ticketId');

    final arguments = {
      'amount': amount,
      'ticketId': ticketId,
      'invoiceData': invoiceData,
      'paymentMethod': paymentMethod.toJson(),
    };

    print('📦 Argumentos para CashDro: $arguments');

    try {
      Navigator.of(context).pushNamed(CashDroPaymentScreen.routeName, arguments: arguments);
      print('✅ Navegación a CashDroPaymentScreen exitosa');
    } catch (e, stackTrace) {
      print('❌ Error al navegar a CashDroPaymentScreen: $e');
      print('📚 Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Navega a PaymentStandbyScreen (Niubiz y otros)
  static Future<void> _navigateToStandardPayment(
    BuildContext context,
    PaymentMethod paymentMethod,
    Map<String, dynamic> invoiceData,
  ) async {
    print('💳 Navegando a PaymentStandbyScreen (${paymentMethod.type.displayName})');

    final arguments = {'invoiceData': invoiceData, 'paymentMethod': paymentMethod};

    print('📦 Argumentos para PaymentStandby: $arguments');

    Navigator.of(context).pushNamed(PaymentStandbyScreen.routeName, arguments: arguments);
  }

  /// Valida los argumentos de navegación
  static void _validateNavigationArguments(
    PaymentMethod paymentMethod,
    double amount,
    Map<String, dynamic> invoiceData,
  ) {
    if (amount <= 0) {
      throw ArgumentError('El monto debe ser mayor a 0: $amount');
    }

    if (invoiceData.isEmpty) {
      throw ArgumentError('Los datos de facturación no pueden estar vacíos');
    }

    print('✅ Validaciones de navegación pasadas correctamente');
  }

  /// Genera un ticketId único para transacciones CashDro
  static String _generateTicketId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp % 10000).toString().padLeft(4, '0');
    return 'TKT${timestamp}_$random';
  }

  /// Obtiene información detallada del método de pago para logging
  static String getPaymentMethodInfo(PaymentMethod paymentMethod) {
    return 'Tipo: ${paymentMethod.type.displayName}, '
        'Activo: ${paymentMethod.isActive}, '
        'Es CashDro: ${isCashDroPayment(paymentMethod.type)}';
  }
}
