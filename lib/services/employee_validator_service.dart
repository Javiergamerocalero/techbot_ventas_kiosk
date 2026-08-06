import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// Cliente del servicio de validación de empleados (San Fernando).
///
/// Backend: FastAPI hospedado en `http://31.220.102.80/api/v1` (VPS
/// Contabo, `techbot_personal_validator`). Es público — la seguridad
/// la asegura Qapp desde su lado, el `tenant_id` va en el body.
///
/// Endpoints consumidos:
///
///  - `POST /employees/validate`
///      body: `{tenantId, identifierType, identifier}`
///      → `{success, employee: {employeeCode, documentNumber, ...}, message}`
///
///  - `POST /employees/{employeeId}/purchases`
///      body: `{tenantId, amountCents, currency, kioskName, externalReference}`
///      → 201 con la compra creada. Usado tras cada pago aprobado
///        para que a futuro se apliquen límites por empleado.
///
///  - `GET  /employees/{employeeId}/purchases/today-total?tenantId=X`
///      → `{count, totalCents, ...}` — para checks de límite antes de
///        disparar el pago.
///
/// Config vive en SharedPreferences (editable desde ConfigScreen):
///   `sanfernando_validator_base_url` (ej. http://31.220.102.80/api/v1)
///   `sanfernando_validator_tenant_id` (int)
///   `sanfernando_kiosk_name` (string, opcional — sirve de auditoría)
class EmployeeValidatorService {
  static const kPrefBaseUrl = 'sanfernando_validator_base_url';
  static const kPrefTenantId = 'sanfernando_validator_tenant_id';
  static const kPrefKioskName = 'sanfernando_kiosk_name';

  static const _defaultBaseUrl = 'http://31.220.102.80/api/v1';
  static const _defaultTenantId = 22; // San Fernando en el validador
  static const _defaultTimeout = Duration(seconds: 15);

  Future<_ValidatorConfig> _config() async {
    final prefs = await SharedPreferences.getInstance();
    return _ValidatorConfig(
      baseUrl: (prefs.getString(kPrefBaseUrl) ?? _defaultBaseUrl).trim(),
      tenantId: prefs.getInt(kPrefTenantId) ?? _defaultTenantId,
      kioskName: (prefs.getString(kPrefKioskName) ?? '').trim(),
    );
  }

  Future<EmployeeValidationResult> validate({
    required EmployeeIdentifierType type,
    required String identifier,
  }) async {
    final cfg = await _config();
    final uri = Uri.parse('${cfg.baseUrl}/employees/validate');
    try {
      final resp = await http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              if (cfg.kioskName.isNotEmpty) 'X-Kiosk-Name': cfg.kioskName,
            },
            body: jsonEncode({
              'tenantId': cfg.tenantId,
              'identifierType': type.wire,
              'identifier': identifier.trim(),
            }),
          )
          .timeout(_defaultTimeout);

      if (resp.statusCode == 422) {
        return EmployeeValidationResult.error(
          'El identificador ingresado no tiene el formato esperado.',
        );
      }
      if (resp.statusCode >= 400) {
        return EmployeeValidationResult.error(
          'Servicio no disponible (HTTP ${resp.statusCode}).',
        );
      }
      final body = jsonDecode(resp.body) as Map<String, dynamic>;
      final success = body['success'] == true;
      final message = (body['message'] ?? '').toString();
      if (!success) {
        return EmployeeValidationResult.notAuthorized(
          message.isNotEmpty
              ? message
              : 'Empleado no autorizado para realizar compras.',
        );
      }
      final emp = body['employee'];
      if (emp is! Map<String, dynamic>) {
        return const EmployeeValidationResult.error(
          'Respuesta inesperada del servicio.',
        );
      }
      return EmployeeValidationResult.authorized(
        Employee.fromJson(emp),
        message: message,
      );
    } catch (e) {
      return EmployeeValidationResult.error(
        'No se pudo contactar al servicio de validación.',
      );
    }
  }

  /// Registra una compra ya cobrada para el empleado. No bloquea el
  /// flow del pago si falla (el pago ya está cobrado por el pinpad
  /// o efectivo); dejamos log para diagnóstico.
  Future<PurchaseRecordResult> registerPurchase({
    required int employeeId,
    required double amount,
    String? externalReference,
  }) async {
    final cfg = await _config();
    final uri = Uri.parse('${cfg.baseUrl}/employees/$employeeId/purchases');
    final amountCents = (amount * 100).round();
    try {
      final resp = await http
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'tenantId': cfg.tenantId,
              'amountCents': amountCents,
              'currency': 'PEN',
              if (cfg.kioskName.isNotEmpty) 'kioskName': cfg.kioskName,
              if (externalReference != null)
                'externalReference': externalReference,
            }),
          )
          .timeout(_defaultTimeout);
      if (resp.statusCode == 201) return const PurchaseRecordResult.ok();
      return PurchaseRecordResult.failed(
        'HTTP ${resp.statusCode}: ${resp.body}',
      );
    } catch (e) {
      return PurchaseRecordResult.failed(e.toString());
    }
  }

  /// Devuelve el total (en soles) que el empleado ya gastó hoy. Sirve
  /// para checks de límite futuros — hoy sin límite implementado, se
  /// devuelve para logging/UI si se necesita.
  Future<double> todayTotalSoles(int employeeId) async {
    final cfg = await _config();
    final uri = Uri.parse(
      '${cfg.baseUrl}/employees/$employeeId/purchases/today-total'
      '?tenantId=${cfg.tenantId}',
    );
    try {
      final resp = await http.get(uri).timeout(_defaultTimeout);
      if (resp.statusCode != 200) return 0.0;
      final body = jsonDecode(resp.body) as Map<String, dynamic>;
      final cents = (body['totalCents'] ?? 0) as int;
      return cents / 100.0;
    } catch (_) {
      return 0.0;
    }
  }
}

class _ValidatorConfig {
  const _ValidatorConfig({
    required this.baseUrl,
    required this.tenantId,
    required this.kioskName,
  });
  final String baseUrl;
  final int tenantId;
  final String kioskName;
}

enum EmployeeIdentifierType {
  dni('DNI'),
  employeeCode('EMPLOYEE_CODE');

  const EmployeeIdentifierType(this.wire);
  final String wire;

  String get label => switch (this) {
        EmployeeIdentifierType.dni => 'DNI',
        EmployeeIdentifierType.employeeCode => 'Código de empleado',
      };
}

class Employee {
  const Employee({
    required this.id,
    required this.employeeCode,
    required this.documentNumber,
    required this.fullName,
    required this.status,
    this.statusReason,
    this.tenantName,
  });

  final int id;
  final String employeeCode;
  final String documentNumber;
  final String fullName;
  final String status;
  final String? statusReason;
  final String? tenantName;

  bool get isActive => status.trim().toLowerCase() == 'active';

  factory Employee.fromJson(Map<String, dynamic> json) {
    // El validador NO devuelve 'id' en el body de /validate — solo
    // el codigo y documento. Para el endpoint de compras necesitamos
    // el id numerico. Como no viene, lo derivamos del backend con un
    // POST purchase que hace matching por (tenant, employee_code) —
    // pero acá no lo tenemos. La API expone 'id' via /employees
    // (list) — futuro: pedirle a Javier que el /validate incluya el
    // 'id' en el response para no tener que buscarlo aparte.
    return Employee(
      id: (json['id'] as int?) ?? 0,
      employeeCode: (json['employeeCode'] ?? '').toString(),
      documentNumber: (json['documentNumber'] ?? '').toString(),
      fullName: (json['fullName'] ?? '').toString(),
      status: (json['status'] ?? '').toString(),
      statusReason: json['statusReason']?.toString(),
      tenantName: json['tenantName']?.toString(),
    );
  }
}

/// Resultado del intento de validación.
class EmployeeValidationResult {
  const EmployeeValidationResult._({
    required this.state,
    this.employee,
    this.message = '',
  });

  const EmployeeValidationResult.authorized(Employee employee,
      {String message = ''})
      : this._(
          state: EmployeeValidationState.authorized,
          employee: employee,
          message: message,
        );

  const EmployeeValidationResult.notAuthorized(String message)
      : this._(
          state: EmployeeValidationState.notAuthorized,
          message: message,
        );

  const EmployeeValidationResult.error(String message)
      : this._(
          state: EmployeeValidationState.error,
          message: message,
        );

  final EmployeeValidationState state;
  final Employee? employee;
  final String message;

  bool get isAuthorized => state == EmployeeValidationState.authorized;
}

enum EmployeeValidationState { authorized, notAuthorized, error }

class PurchaseRecordResult {
  const PurchaseRecordResult._({required this.success, this.error});
  const PurchaseRecordResult.ok() : this._(success: true);
  const PurchaseRecordResult.failed(String reason)
      : this._(success: false, error: reason);
  final bool success;
  final String? error;
}
