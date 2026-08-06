import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/employee_validator_service.dart';

/// Empleado autenticado en la sesión actual del kiosco. `null` cuando
/// no hay sesión activa (standby / post-checkout). Se setea desde el
/// [EmployeeAuthScreen] tras una validación exitosa contra el
/// servicio de validación de San Fernando.
class EmployeeSession {
  const EmployeeSession({
    required this.employee,
    required this.startedAt,
  });

  final Employee employee;
  final DateTime startedAt;
}

class EmployeeSessionController extends StateNotifier<EmployeeSession?> {
  EmployeeSessionController() : super(null);

  void setEmployee(Employee employee) {
    state = EmployeeSession(employee: employee, startedAt: DateTime.now());
  }

  void clear() {
    state = null;
  }
}

final employeeSessionProvider =
    StateNotifierProvider<EmployeeSessionController, EmployeeSession?>(
  (ref) => EmployeeSessionController(),
);

/// Instancia única del cliente HTTP.
final employeeValidatorServiceProvider = Provider<EmployeeValidatorService>(
  (ref) => EmployeeValidatorService(),
);
