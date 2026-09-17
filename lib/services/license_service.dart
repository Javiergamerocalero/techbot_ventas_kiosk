import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ventas_kiosko/models/config/license_data.dart';
import 'package:ventas_kiosko/models/config/theme_config.dart';
import 'package:ventas_kiosko/models/config/configuration_data.dart';
import 'package:ventas_kiosko/models/config/license_activation_response.dart';

/// Servicio para manejar la activación y gestión de licencias
class LicenseService {
  /// Obtiene la URL base según el entorno
  String _getBaseUrl() {
    final appEnv = dotenv.get('APP_ENV');
    return appEnv == 'development'
        ? dotenv.get('DEV_URL', fallback: 'API_URL not found')
        : dotenv.get('PROD_URL', fallback: 'API_URL not found');
  }

  /// Genera un ID único del dispositivo completo
  Future<String> generateDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    
    try {
      String baseId;
      
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        baseId = androidInfo.id;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        baseId = iosInfo.identifierForVendor ?? 'ios-device';
      } else if (Platform.isMacOS) {
        final macInfo = await deviceInfo.macOsInfo;
        baseId = macInfo.systemGUID ?? 'mac-device';
      } else if (Platform.isWindows) {
        final windowsInfo = await deviceInfo.windowsInfo;
        baseId = windowsInfo.deviceId;
      } else {
        baseId = 'device-${DateTime.now().millisecondsSinceEpoch}';
      }

      print('📱 Device ID completo del sistema: $baseId');
      
      return baseId;
    } catch (e) {
      print('⚠️ Error generando device ID: $e');
      // Fallback con timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final fallbackId = 'fallback$timestamp';
      print('🔄 Fallback device ID: $fallbackId');
      return fallbackId;
    }
  }

  /// Obtiene la versión actual de la aplicación
  Future<String> _getAppVersion() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      return '${packageInfo.version}+${packageInfo.buildNumber}';
    } catch (e) {
      print('⚠️ Error obteniendo versión de app: $e');
      return '1.0.0+1';
    }
  }

  /// Activa una licencia en el servidor
  Future<LicenseActivationResponse> activateLicense({
    required String licenseKey,
    required String deviceName,
  }) async {
    final baseUrl = _getBaseUrl();
    final url = Uri.parse('$baseUrl/api/licenses/activate');

    try {
      // Generar device ID real completo del sistema
      final deviceId = await generateDeviceId();
      final appVersion = await _getAppVersion();

      print('🔑 Activando licencia...');
      print('📱 Key: ${licenseKey.substring(0, 5)}...');
      print('🏷️ Device Name: $deviceName');
      print('🆔 Device ID: $deviceId (${deviceId.length} chars)');
      print('📦 App Version: $appVersion');
      print('🌐 URL: $url');

      final requestBody = {
        'key': licenseKey,
        'device_name': deviceName,
        'device_id': deviceId,
        'app_version': appVersion,
      };

      print('📤 Request body: ${json.encode(requestBody)}');

      final response = await http
          .post(
            url,
            headers: {
              'Authorization': 'Bearer ${dotenv.get('TECHBOT_API_TOKEN')}',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: json.encode(requestBody),
          )
          .timeout(const Duration(seconds: 15));

      print('📡 Status Code: ${response.statusCode}');
      print('📡 Response body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final jsonData = jsonDecode(response.body);
          print('📋 JSON parseado exitosamente');
        
          // Parsear tema
          ThemeConfig? themeConfig;
          if (jsonData['data'] != null && jsonData['data']['theme'] != null) {
            final themeData = jsonData['data']['theme'];
            
            if (themeData is Map && themeData.containsKey('colors')) {
              try {
                final colors = themeData['colors'] as Map<String, dynamic>;
                themeConfig = ThemeConfig.fromJson(colors);
                print('🎨 Tema activado: Primary=${themeConfig.primary}, Secondary=${themeConfig.secondary}');
              } catch (e) {
                print('⚠️ Error parseando tema: $e');
              }
            }
          }
          
          // Parsear configuración
          ConfigurationData? configurationData;
          if (jsonData['data'] != null && jsonData['data']['configuration'] != null) {
            final configData = jsonData['data']['configuration'];
            
            try {
              configurationData = ConfigurationData.fromJson(configData as Map<String, dynamic>);
              print('🔧 Configuración activada: config_password=${configurationData.configPassword != null ? "SÍ" : "NO"}');
            } catch (e) {
              print('⚠️ Error parseando configuración: $e');
            }
          }
        
          // Parsear licencia
          Map<String, dynamic> licenseJson;
          if (jsonData['data'] != null && jsonData['data']['license'] != null) {
            licenseJson = jsonData['data']['license'];
          } else if (jsonData['license'] != null) {
            licenseJson = jsonData['license'];
          } else {
            return LicenseActivationResponse.error(
              message: 'Estructura de respuesta inválida',
              statusCode: response.statusCode,
            );
          }
          
          // Agregar business_info al licenseJson si está disponible
          if (jsonData['data'] != null && jsonData['data']['business_info'] != null) {
            licenseJson['business_info'] = jsonData['data']['business_info'];
          }

          // La licencia trae el emisor de comprobantes del cliente en
          // `data.tech_fact`. Va aparte porque el modelo lo guarda plano.
          final techFact = jsonData['data']?['tech_fact'];
          if (techFact is Map<String, dynamic>) {
            licenseJson['tech_fact_route'] = techFact['route'];
            licenseJson['tech_fact_token'] = techFact['token'];
            print('🧾 Emisor de comprobantes en la licencia: '
                '${techFact['route'] != null ? "SÍ" : "NO"}');
            print('🏢 Business info agregado a licenseJson');
          }
          
          final licenseData = LicenseData.fromJson(licenseJson);
          print('✅ Licencia activada, themeConfig=${themeConfig != null ? "SÍ" : "NO"}, configurationData=${configurationData != null ? "SÍ" : "NO"}');
          
          return LicenseActivationResponse.success(
            licenseData,
            themeConfig: themeConfig,
            configurationData: configurationData,
          );
        } catch (e, stackTrace) {
          print('❌ Error: $e');
          print('📚 Stack: $stackTrace');
          return LicenseActivationResponse.error(
            message: 'Error procesando respuesta: ${e.toString()}',
            statusCode: response.statusCode,
          );
        }
      } else {
        // Manejar errores HTTP
        return _handleErrorResponse(response);
      }
    } catch (e) {
      print('💥 Excepción en activación: $e');
      
      if (e.toString().contains('TimeoutException') || e.toString().contains('timeout')) {
        return LicenseActivationResponse.error(
          message: 'Tiempo de espera agotado. Verifique su conexión a internet.',
        );
      } else if (e.toString().contains('SocketException') || e.toString().contains('network')) {
        return LicenseActivationResponse.error(
          message: 'Error de conexión. Verifique su conexión a internet.',
        );
      } else {
        return LicenseActivationResponse.error(
          message: 'Error inesperado: ${e.toString()}',
        );
      }
    }
  }

  /// Maneja las respuestas de error del servidor
  LicenseActivationResponse _handleErrorResponse(http.Response response) {
    try {
      final errorBody = jsonDecode(response.body);
      print('📋 Error body parsed: $errorBody');

      String errorMessage;
      Map<String, dynamic>? errorDetails;

      switch (response.statusCode) {
        case 400:
          errorMessage = _extractErrorMessage(errorBody) ?? 'Solicitud inválida. Verifique los datos ingresados.';
          break;
        case 401:
          errorMessage = 'No autorizado. Verifique su licencia.';
          break;
        case 403:
          errorMessage = 'Acceso denegado. La licencia no tiene permisos.';
          break;
        case 404:
          errorMessage = 'Licencia no encontrada. Verifique el número de licencia.';
          break;
        case 422:
          errorMessage = _extractValidationErrors(errorBody);
          errorDetails = errorBody;
          break;
        case 429:
          errorMessage = 'Demasiadas solicitudes. Intente nuevamente en unos minutos.';
          break;
        case 500:
          errorMessage = 'Error interno del servidor. Intente nuevamente más tarde.';
          break;
        default:
          errorMessage = _extractErrorMessage(errorBody) ?? 'Error del servidor (${response.statusCode})';
      }

      print('📝 Error message: $errorMessage');

      return LicenseActivationResponse.error(
        message: errorMessage,
        details: errorDetails,
        statusCode: response.statusCode,
      );
    } catch (e) {
      print('🔍 Error parseando respuesta de error: $e');
      print('📄 Raw response: ${response.body}');
      
      return LicenseActivationResponse.error(
        message: 'Error del servidor. Intente nuevamente.',
        statusCode: response.statusCode,
      );
    }
  }

  /// Extrae el mensaje de error principal de la respuesta
  String? _extractErrorMessage(Map<String, dynamic> errorBody) {
    // Intentar diferentes estructuras de error
    if (errorBody['message'] != null) {
      return errorBody['message'].toString();
    }
    
    if (errorBody['error'] is String) {
      return errorBody['error'].toString();
    }
    
    if (errorBody['error'] is Map && errorBody['error']['message'] != null) {
      return errorBody['error']['message'].toString();
    }

    return null;
  }

  /// Extrae y formatea errores de validación (422)
  String _extractValidationErrors(Map<String, dynamic> errorBody) {
    try {
      if (errorBody['error'] is Map) {
        final errors = errorBody['error'] as Map<String, dynamic>;
        final List<String> errorMessages = [];

        errors.forEach((field, messages) {
          if (messages is List) {
            for (final message in messages) {
              switch (field) {
                case 'device_id':
                  errorMessages.add('ID del dispositivo: $message');
                  break;
                case 'device_name':
                  errorMessages.add('Nombre del dispositivo: $message');
                  break;
                case 'key':
                  errorMessages.add('Licencia: $message');
                  break;
                case 'app_version':
                  errorMessages.add('Versión de la app: $message');
                  break;
                default:
                  errorMessages.add('$field: $message');
              }
            }
          }
        });

        if (errorMessages.isNotEmpty) {
          return errorMessages.join('\n');
        }
      }
    } catch (e) {
      print('🔍 Error extrayendo errores de validación: $e');
    }

    return 'Error de validación. Verifique los datos ingresados.';
  }

  /// Verifica el estado de una licencia existente
  Future<LicenseActivationResponse> checkLicense(String licenseKey) async {
    final baseUrl = _getBaseUrl();
    final url = Uri.parse('$baseUrl/api/licenses/$licenseKey');

    try {
      print('🔍 Verificando licencia existente...');
      print('📱 Key: ${licenseKey.substring(0, 5)}...');
      print('🌐 URL: $url');

      final response = await http
          .get(
            url,
            headers: {
              'Authorization': 'Bearer ${dotenv.get('TECHBOT_API_TOKEN')}',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          )
          .timeout(const Duration(seconds: 10));

      print('📡 Check Status Code: ${response.statusCode}');
      print('📡 Check Response body: ${response.body}');

      if (response.statusCode == 200) {
        try {
          print('🔍 Check: Iniciando parseo de respuesta...');
          final jsonData = jsonDecode(response.body);
          print('📋 Check: JSON parseado exitosamente');
        
          // Parsear tema
          ThemeConfig? themeConfig;
          print('🔍 Check: Iniciando parseo de tema...');
          if (jsonData['data'] != null && jsonData['data']['theme'] != null) {
            final themeData = jsonData['data']['theme'];
            print('🔍 Check: Theme data: $themeData');
            
            if (themeData is Map && themeData.containsKey('colors')) {
              try {
                final colors = themeData['colors'] as Map<String, dynamic>;
                themeConfig = ThemeConfig.fromJson(colors);
                print('🎨 Tema verificado: Primary=${themeConfig.primary}, Secondary=${themeConfig.secondary}');
              } catch (e) {
                print('⚠️ Check: Error parseando tema: $e');
              }
            } else {
              print('ℹ️ Check: Theme no es un mapa válido');
            }
          } else {
            print('ℹ️ Check: No hay campo theme');
          }
          
          // Parsear configuración
          ConfigurationData? configurationData;
          print('🔍 Check: Iniciando parseo de configuración...');
          if (jsonData['data'] != null && jsonData['data']['configuration'] != null) {
            final configData = jsonData['data']['configuration'];
            print('🔍 Check: Configuration data: $configData');
            
            try {
              configurationData = ConfigurationData.fromJson(configData as Map<String, dynamic>);
              print('🔧 Configuración verificada: config_password=${configurationData.configPassword != null ? "SÍ" : "NO"}');
            } catch (e) {
              print('⚠️ Check: Error parseando configuración: $e');
            }
          } else {
            print('ℹ️ Check: No hay campo configuration');
          }
        
          // Parsear licencia
          Map<String, dynamic> licenseJson;
          if (jsonData['data'] != null && jsonData['data']['license'] != null) {
            licenseJson = jsonData['data']['license'];
          } else if (jsonData['license'] != null) {
            licenseJson = jsonData['license'];
          } else {
            return LicenseActivationResponse.error(
              message: 'Estructura de respuesta inválida',
              statusCode: response.statusCode,
            );
          }
          
          // Agregar business_info al licenseJson si está disponible
          if (jsonData['data'] != null && jsonData['data']['business_info'] != null) {
            licenseJson['business_info'] = jsonData['data']['business_info'];
          }

          // La licencia trae el emisor de comprobantes del cliente en
          // `data.tech_fact`. Va aparte porque el modelo lo guarda plano.
          final techFact = jsonData['data']?['tech_fact'];
          if (techFact is Map<String, dynamic>) {
            licenseJson['tech_fact_route'] = techFact['route'];
            licenseJson['tech_fact_token'] = techFact['token'];
            print('🧾 Emisor de comprobantes en la licencia: '
                '${techFact['route'] != null ? "SÍ" : "NO"}');
            print('🏢 Check: Business info agregado a licenseJson');
          }
          
          final licenseData = LicenseData.fromJson(licenseJson);
          print('✅ Check: Licencia verificada, themeConfig=${themeConfig != null ? "SÍ" : "NO"}, configurationData=${configurationData != null ? "SÍ" : "NO"}');
          
          return LicenseActivationResponse.success(
            licenseData,
            themeConfig: themeConfig,
            configurationData: configurationData,
          );
        } catch (e, stackTrace) {
          print('❌ Check: Error general: $e');
          print('📚 Stack: $stackTrace');
          return LicenseActivationResponse.error(
            message: 'Error procesando verificación: ${e.toString()}',
            statusCode: response.statusCode,
          );
        }
      } else {
        // Manejar errores HTTP específicos para verificación
        if (response.statusCode == 404) {
          print('🚫 Licencia no encontrada en el servidor');
          return LicenseActivationResponse.error(
            message: 'Licencia no encontrada o expirada',
            statusCode: response.statusCode,
          );
        } else {
          return _handleErrorResponse(response);
        }
      }
    } catch (e) {
      print('💥 Error verificando licencia: $e');
      
      if (e.toString().contains('TimeoutException') || e.toString().contains('timeout')) {
        return LicenseActivationResponse.error(
          message: 'Tiempo de espera agotado verificando licencia. Verifique su conexión a internet.',
        );
      } else if (e.toString().contains('SocketException') || e.toString().contains('network')) {
        return LicenseActivationResponse.error(
          message: 'Error de conexión verificando licencia. Usando datos locales.',
        );
      } else {
        return LicenseActivationResponse.error(
          message: 'Error inesperado verificando licencia: ${e.toString()}',
        );
      }
    }
  }

  /// Actualiza los datos de licencia en el servidor
  Future<LicenseActivationResponse> updateLicenseData({
    required int licenseId,
    String? appVersion,
    String? deviceName,
  }) async {
    final baseUrl = _getBaseUrl();
    final url = Uri.parse('$baseUrl/api/licenses/update');

    try {
      final body = {
        'license_id': licenseId.toString(),
        if (appVersion != null) 'app_version': appVersion,
        if (deviceName != null) 'device_name': deviceName,
      };

      print('🔄 Actualizando licencia...');
      print('📤 Update body: ${json.encode(body)}');

      final response = await http
          .patch(
            url,
            headers: {
              'Authorization': 'Bearer ${dotenv.get('TECHBOT_API_TOKEN')}',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: json.encode(body),
          )
          .timeout(const Duration(seconds: 10));

      print('📡 Update Status: ${response.statusCode}');
      print('📡 Update Response: ${response.body}');

      if (response.statusCode == 200) {
        try {
          final jsonData = jsonDecode(response.body);
          print('📋 Update JSON parseado: $jsonData');
          
          // El backend responde con {"data": {"license": {...}}}
          Map<String, dynamic> licenseJson;
          
          if (jsonData['data'] != null && jsonData['data']['license'] != null) {
            // Estructura nueva: {"data": {"license": {...}}}
            licenseJson = jsonData['data']['license'];
            print('📦 Update usando estructura data.license');
          } else if (jsonData['license'] != null) {
            // Estructura anterior: {"license": {...}}
            licenseJson = jsonData['license'];
            print('📦 Update usando estructura license directa');
          } else {
            print('❌ Update: No se encontró estructura de licencia válida');
            print('📄 Update estructura recibida: ${jsonData.keys.toList()}');
            return LicenseActivationResponse.error(
              message: 'Estructura de respuesta del servidor no válida en actualización',
            );
          }
          
          print('🔍 Update parseando licenseJson: $licenseJson');
          final licenseData = LicenseData.fromJson(licenseJson);
          print('✅ Licencia actualizada exitosamente');
          
          return LicenseActivationResponse.success(licenseData);
        } catch (e, stackTrace) {
          print('❌ Error parseando respuesta de actualización: $e');
          print('📚 Update stack trace: $stackTrace');
          return LicenseActivationResponse.error(
            message: 'Error procesando la respuesta de actualización: ${e.toString()}',
          );
        }
      } else {
        return _handleErrorResponse(response);
      }
    } catch (e) {
      print('💥 Error actualizando licencia: $e');
      return LicenseActivationResponse.error(
        message: 'Error actualizando la licencia: ${e.toString()}',
      );
    }
  }
}
