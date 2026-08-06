import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/employee/employee_session_provider.dart';

/// Registra la compra actual contra el servicio de validación de San
/// Fernando si hay una sesión de empleado activa. Idempotente por
/// sesión: al registrar exitosamente limpia la sesión, así llamar
/// desde múltiples puntos post-pago no genera duplicados.
///
/// No lanza excepciones — cualquier error se loguea y se continúa,
/// para no bloquear el flow del pago (el cobro ya está hecho por el
/// pinpad / efectivo).
class EmployeePurchaseHook {
  const EmployeePurchaseHook._();

  /// Debe llamarse UNA vez tras cada pago aprobado (Izipay, Niubiz,
  /// Cashdro, etc.). Si el kiosco no está en modo San Fernando o el
  /// usuario no se identificó, no hace nada.
  static Future<void> registerIfEmployeeSession(
    WidgetRef ref, {
    required double amount,
    String? externalReference,
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
    } finally {
      // Limpiamos la sesión igual — el próximo empleado tiene que
      // volver a identificarse desde el standby.
      ref.read(employeeSessionProvider.notifier).clear();
    }
  }
}
