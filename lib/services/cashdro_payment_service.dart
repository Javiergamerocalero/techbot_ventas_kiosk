import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/payment/cashdro_transaction.dart';

const Duration _defaultTimeout = Duration(seconds: 15);

/// Servicio para gestionar pagos con CashDro S
/// Implementa el flujo completo de transacciones de venta
class CashDroPaymentService {
  final http.Client _client;
  final bool simulationMode;

  CashDroPaymentService({
    http.Client? client,
    this.simulationMode = true, // Por defecto en modo simulación
  }) : _client = client ?? http.Client();

  /// Construye la URL base del web service
  String _buildBaseUrl(String ipAddress) {
    // Asegurar que la IP tenga el protocolo
    final ip = ipAddress.startsWith('http') ? ipAddress : 'http://$ipAddress';
    return '$ip/Cashdro3WS/index3.php';
  }

  /// Construye la URL del WebView
  String buildWebViewUrl(String ipAddress) {
    final ip = ipAddress.startsWith('http') ? ipAddress : 'http://$ipAddress';
    return '$ip/Cashdro3Web/index.html#/splash/true';
  }

  /// 1. Iniciar transacción de venta
  /// Informa al CashDro que se desea iniciar una transacción de tipo venta (type=4)
  Future<CashDroStartResponse> startSaleOperation({
    required String ipAddress,
    required String username,
    required String password,
    required double amount,
    String? posId,
    String? posUser,
    String? aliasId,
  }) async {
    try {
      // Convertir amount a centavos (multiplicar por 100)
      final amountInCents = (amount * 100).toInt();
      
      final url = Uri.parse(_buildBaseUrl(ipAddress)).replace(
        queryParameters: {
          'operation': 'startOperation',
          'name': username,
          'password': password,
          'type': '4', // Tipo 4 = Venta
          'posid': posId ?? 'KioskTerminal',
          'posuser': posUser ?? 'Kiosk',
          if (aliasId != null) 'aliasid': aliasId,
          'parameters': jsonEncode({'amount': amountInCents.toString()}),
        },
      );

      print('🚀 CashDro: Iniciando transacción de venta [SIMULADO]');
      print('   URL: $url');
      print('   Monto: \$${amount.toStringAsFixed(2)} ($amountInCents centavos)');

      if (simulationMode) {
        // Simular respuesta exitosa
        await Future.delayed(const Duration(milliseconds: 500));
        
        final simulatedResponse = {
          'code': 1,
          'response': {
            'errorMessage': 'none',
            'operation': {
              'operationId': 'SIM-${DateTime.now().millisecondsSinceEpoch}'
            }
          }
        };
        
        print('📥 CashDro: Respuesta simulada (200)');
        print('   Body: ${jsonEncode(simulatedResponse)}');
        
        final result = CashDroStartResponse.fromJson(simulatedResponse);
        print('✅ CashDro: Transacción iniciada - OperationId: ${result.operationId}');
        return result;
      }

      final response = await _client
          .get(url)
          .timeout(_defaultTimeout);

      print('📥 CashDro: Respuesta recibida (${response.statusCode})');
      print('   Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final result = CashDroStartResponse.fromJson(jsonResponse);
        
        if (result.isSuccess) {
          print('✅ CashDro: Transacción iniciada - OperationId: ${result.operationId}');
        } else {
          print('❌ CashDro: Error al iniciar - Code: ${result.code}, Message: ${result.errorMessage}');
        }
        
        return result;
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('❌ CashDro: Error en startSaleOperation: $e');
      return CashDroStartResponse(
        code: -999,
        errorMessage: 'Error de conexión: $e',
      );
    }
  }

  /// 2. Confirmar ejecución de la transacción
  /// Después de obtener el operationId, se confirma la ejecución
  Future<CashDroSimpleResponse> acknowledgeOperation({
    required String ipAddress,
    required String username,
    required String password,
    required String operationId,
  }) async {
    try {
      final url = Uri.parse(_buildBaseUrl(ipAddress)).replace(
        queryParameters: {
          'operation': 'acknowledgeOperationId',
          'name': username,
          'password': password,
          'operationId': operationId,
        },
      );

      print('🔄 CashDro: Confirmando ejecución de operación $operationId [SIMULADO]');
      print('   URL: ${url.toString()}');

      if (simulationMode) {
        await Future.delayed(const Duration(milliseconds: 300));
        final simulatedResponse = {'code': 1, 'response': {'errorMessage': 'none'}};
        print('📥 CashDro: Respuesta simulada (200)');
        print('   Body: ${jsonEncode(simulatedResponse)}');
        final result = CashDroSimpleResponse.fromJson(simulatedResponse);
        print('✅ CashDro: Operación confirmada y en ejecución');
        return result;
      }

      final response = await _client
          .get(url)
          .timeout(_defaultTimeout);

      print('📥 CashDro: Respuesta acknowledge (${response.statusCode})');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final result = CashDroSimpleResponse.fromJson(jsonResponse);
        
        if (result.isSuccess) {
          print('✅ CashDro: Operación confirmada y en ejecución');
        } else {
          print('❌ CashDro: Error al confirmar - Code: ${result.code}, Message: ${result.errorMessage}');
        }
        
        return result;
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('❌ CashDro: Error en acknowledgeOperation: $e');
      return CashDroSimpleResponse(
        code: -999,
        errorMessage: 'Error de conexión: $e',
      );
    }
  }

  /// 3. Consultar estado de la transacción
  /// Permite consultar el estado actual de la operación (polling)
  Future<CashDroOperationStatus> askOperation({
    required String ipAddress,
    required String username,
    required String password,
    required String operationId,
  }) async {
    try {
      final url = Uri.parse(_buildBaseUrl(ipAddress)).replace(
        queryParameters: {
          'operation': 'askOperation',
          'operationId': operationId,
          'name': username,
          'password': password,
        },
      );

      if (simulationMode) {
        // Simular progreso de transacción
        await Future.delayed(const Duration(milliseconds: 100));
        
        // Simular estado finalizado después de algunos intentos
        final simulatedResponse = {
          'code': 1,
          'response': {
            'errorMessage': 'none',
            'operation': {
              'operation': {
                'operationid': operationId,
                'state': 'F', // Finalizada
                'payInProgress': 1,
                'payOutProgress': 1,
                'total': '1000',
                'totalin': '1000',
                'totalout': '0',
              },
              'withError': false,
            }
          }
        };
        
        final result = CashDroOperationStatus.fromJson(simulatedResponse);
        if (result.state == 'F') {
          print('✅ CashDro: Operación finalizada [SIMULADO]');
          print('   TotalIn: ${result.totalIn}, TotalOut: ${result.totalOut}');
          print('   PayInProgress: ${result.payInProgress}, WithError: ${result.withError}');
        }
        return result;
      }

      final response = await _client
          .get(url)
          .timeout(_defaultTimeout);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final result = CashDroOperationStatus.fromJson(jsonResponse);
        
        // Log solo cuando hay cambios importantes
        if (result.state == 'F') {
          print('✅ CashDro: Operación finalizada');
          print('   TotalIn: ${result.totalIn}, TotalOut: ${result.totalOut}');
          print('   PayInProgress: ${result.payInProgress}, WithError: ${result.withError}');
        } else if (result.state == 'E') {
          // Solo log inicial de ejecución
          print('⏳ CashDro: Operación en ejecución (state: ${result.state})');
        }
        
        return result;
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('❌ CashDro: Error en askOperation: $e');
      return CashDroOperationStatus(
        code: -999,
        errorMessage: 'Error de conexión: $e',
      );
    }
  }

  /// 4. Importar transacción
  /// Indica al CashDro que la transacción ha sido recibida y procesada por el Host
  Future<CashDroSimpleResponse> importOperation({
    required String ipAddress,
    required String username,
    required String password,
    required String operationId,
  }) async {
    try {
      final url = Uri.parse(_buildBaseUrl(ipAddress)).replace(
        queryParameters: {
          'operation': 'setOperationImported',
          'name': username,
          'password': password,
          'operationId': operationId,
        },
      );

      print('📦 CashDro: Importando transacción $operationId [SIMULADO]');
      print('   URL: ${url.toString()}');

      if (simulationMode) {
        await Future.delayed(const Duration(milliseconds: 200));
        final simulatedResponse = {'code': 1, 'response': {'errorMessage': 'none'}};
        print('📥 CashDro: Respuesta simulada (200)');
        print('   Body: ${jsonEncode(simulatedResponse)}');
        final result = CashDroSimpleResponse.fromJson(simulatedResponse);
        print('✅ CashDro: Transacción importada correctamente');
        return result;
      }

      final response = await _client
          .get(url)
          .timeout(_defaultTimeout);

      print('📥 CashDro: Respuesta import (${response.statusCode})');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final result = CashDroSimpleResponse.fromJson(jsonResponse);
        
        if (result.isSuccess) {
          print('✅ CashDro: Transacción importada correctamente');
        } else {
          print('❌ CashDro: Error al importar - Code: ${result.code}, Message: ${result.errorMessage}');
        }
        
        return result;
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('❌ CashDro: Error en importOperation: $e');
      return CashDroSimpleResponse(
        code: -999,
        errorMessage: 'Error de conexión: $e',
      );
    }
  }

  /// 5. Cancelar o finalizar transacción (Opcional)
  /// type=1: Finalizar, type=2: Cancelar
  Future<CashDroSimpleResponse> finishOperation({
    required String ipAddress,
    required String username,
    required String password,
    required String operationId,
    required int type, // 1=Finalizar, 2=Cancelar
  }) async {
    try {
      final url = Uri.parse(_buildBaseUrl(ipAddress)).replace(
        queryParameters: {
          'operation': 'finishOperation',
          'name': username,
          'password': password,
          'operationId': operationId,
          'type': type.toString(),
        },
      );

      print('🛑 CashDro: ${type == 2 ? "Cancelando" : "Finalizando"} transacción $operationId');

      final response = await _client
          .get(url)
          .timeout(_defaultTimeout);

      print('📥 CashDro: Respuesta finish (${response.statusCode})');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        final result = CashDroSimpleResponse.fromJson(jsonResponse);
        
        if (result.isSuccess) {
          print('✅ CashDro: Transacción ${type == 2 ? "cancelada" : "finalizada"}');
        } else {
          print('❌ CashDro: Error - Code: ${result.code}, Message: ${result.errorMessage}');
        }
        
        return result;
      } else {
        throw Exception('HTTP ${response.statusCode}: ${response.body}');
      }
    } catch (e) {
      print('❌ CashDro: Error en finishOperation: $e');
      return CashDroSimpleResponse(
        code: -999,
        errorMessage: 'Error de conexión: $e',
      );
    }
  }

  /// Cancelar transacción en curso
  /// Usa finishOperation con type=2 para cancelar
  Future<CashDroSimpleResponse> cancelOperation({
    required String ipAddress,
    required String username,
    required String password,
    required String operationId,
  }) async {
    print('🛑 CashDro: Cancelando transacción $operationId');
    
    if (simulationMode) {
      print('🎭 CashDro: Cancelación simulada para operación $operationId');
      await Future.delayed(const Duration(milliseconds: 500));
      return CashDroSimpleResponse(
        code: 1,
        errorMessage: 'none',
      );
    }
    
    return finishOperation(
      ipAddress: ipAddress,
      username: username,
      password: password,
      operationId: operationId,
      type: 2, // 2 = Cancelar transacción
    );
  }

  /// Finalizar transacción completada
  /// Usa finishOperation con type=1 para finalizar
  Future<CashDroSimpleResponse> completeOperation({
    required String ipAddress,
    required String username,
    required String password,
    required String operationId,
  }) async {
    print('✅ CashDro: Finalizando transacción $operationId');
    
    if (simulationMode) {
      print('🎭 CashDro: Finalización simulada para operación $operationId');
      await Future.delayed(const Duration(milliseconds: 500));
      return CashDroSimpleResponse(
        code: 1,
        errorMessage: 'none',
      );
    }
    
    return finishOperation(
      ipAddress: ipAddress,
      username: username,
      password: password,
      operationId: operationId,
      type: 1, // 1 = Finalizar transacción
    );
  }

  /// Obtener mensaje de error legible según el código
  String getErrorMessage(int code) {
    switch (code) {
      case -1:
        return 'Usuario o contraseña incorrectos';
      case -2:
        return 'CashDro ocupado con otra transacción';
      case -3:
        return 'Monto de transacción incorrecto';
      case -4:
        return 'Usuario sin permisos para realizar la transacción';
      case -99:
        return 'Parámetros incorrectos';
      case -998:
        return 'CashDro fuera de servicio. Revisar estado en diagnóstico';
      case -999:
        return 'Servicio de CashDro no está funcionando';
      case -1900:
        return 'Sistema ocupado (cargando o actualizando)';
      default:
        return 'Error desconocido (código: $code)';
    }
  }

  /// Verificar si un error es temporal y se puede reintentar
  bool isTemporaryError(int code) {
    return code == -2 || code == -1900; // Ocupado o cargando
  }

  void dispose() {
    _client.close();
  }
}
