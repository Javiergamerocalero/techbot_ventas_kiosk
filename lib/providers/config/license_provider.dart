import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ventas_kiosko/models/config/license_data.dart';
import 'package:ventas_kiosko/models/config/license_activation_response.dart';
import 'package:ventas_kiosko/models/config/configuration_data.dart';
import 'package:ventas_kiosko/models/config/business_info.dart';
import 'package:ventas_kiosko/models/config/theme_config.dart';
import 'package:ventas_kiosko/services/license_service.dart';
import 'package:ventas_kiosko/providers/config/theme_provider.dart';

part 'license_provider.g.dart';

/// Provider para el servicio de licencias
@Riverpod(keepAlive: true)
LicenseService licenseService(Ref ref) {
  return LicenseService();
}

@Riverpod(keepAlive: true)
class License extends _$License {
  // Campo privado para almacenar la configuración
  ConfigurationData? _configurationData;

  @override
  Future<LicenseData> build() async {
    try {
      print('🔄 LicenseProvider.build() iniciando...');
      
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      String appVersion = '$version+$buildNumber';
      print('📱 App version: $appVersion');

      final licenseData = await getLicenseData();
      print('📋 Retrieved licenseData: ${licenseData != null ? "SÍ" : "NO"}');

      if (licenseData == null) {
        print('❌ No licenseData stored locally');
        return LicenseData(appVersion: appVersion);
      }

      // Si la licencia está guardada localmente, asumimos que fue activada exitosamente
      LicenseData currentLicenseData = licenseData;
      if (!licenseData.activationStatus) {
        print('🔧 Corrigiendo activationStatus: false → true');
        currentLicenseData = licenseData.copyWith(activationStatus: true);
        await saveLicenseData(currentLicenseData);
      }

      // Actualizar versión si cambió
      if (currentLicenseData.appVersion != appVersion) {
        print('🔄 Versión actualizada: ${currentLicenseData.appVersion} → $appVersion');
        
        currentLicenseData = currentLicenseData.copyWith(appVersion: appVersion);
        await saveLicenseData(currentLicenseData);
        
        // Actualizar en servidor en background
        Future.microtask(() {
          updateServerLicenseData(licenseId: licenseData.id, appVersion: appVersion);
        });
      }

      print('🎨 Cargando tema guardado localmente...');
      await _loadAndApplySavedTheme();

      print('🔄 Verificando licencia en servidor para actualizar configuración...');
      final refresco = await refreshFromServer(silentMode: true);

      // Lo que acaba de llegar del servidor manda sobre la copia guardada
      // en el equipo. Antes se refrescaba y acto seguido se devolvía la
      // copia vieja, que pisaba el estado: cualquier dato nuevo de la
      // licencia —el emisor de comprobantes, sin ir más lejos— no se veía
      // hasta el siguiente arranque (Javier, 2026-09-17: "no está
      // reconociendo esos datos").
      if (refresco.success && refresco.licenseData != null) {
        print('✅ Retornando licencia recién traída del servidor');
        return refresco.licenseData!;
      }

      print('✅ Retornando licencia local (el servidor no respondió)');
      return currentLicenseData;
    } catch (e, stackTrace) {
      print('❌ Error en build(): $e');
      print('📚 StackTrace: $stackTrace');
      // En caso de error, retornar licencia vacía
      return LicenseData(appVersion: '0.0.0+0');
    }
  }

  /// Activa una licencia usando el LicenseService
  Future<LicenseActivationResponse> activateLicense({
    required String licenseKey,
    required String deviceName,
  }) async {
    final licenseService = ref.read(licenseServiceProvider);
    
    print('🔑 Provider: Iniciando activación de licencia');
    
    try {
      final response = await licenseService.activateLicense(
        licenseKey: licenseKey,
        deviceName: deviceName,
      );
      
      if (response.success && response.licenseData != null) {
        // Guardar los datos de licencia localmente
        await saveLicenseData(response.licenseData!);
        print('✅ Provider: Licencia guardada localmente');
        print('🏢 Provider: Tenant ID establecido: ${response.licenseData!.tenantId}');
        print('📱 Provider: Device Name: ${response.licenseData!.deviceName}');
        print('📅 Provider: Expiration Date: ${response.licenseData!.expirationDate}');
        print('🔑 Provider: License Key: ${response.licenseData!.key}');
        
        // Actualizar el estado del provider
        state = AsyncData(response.licenseData!);
        
        // 🔄 Aplicar y guardar tema si viene en la respuesta
        if (response.themeConfig != null) {
          print('🎨 Provider: Aplicando tema de la licencia');
          try {
            await _saveThemeLocally(response.themeConfig!);
            await ref.read(appThemeNotifierProvider.notifier).applyTheme(response.themeConfig!);
            print('✅ Provider: Tema aplicado y guardado exitosamente');
          } catch (e) {
            print('⚠️ Provider: Error aplicando tema: $e');
          }
        } else {
          print('ℹ️ Provider: No hay tema configurado, usando AppColors');
        }
        
        // 🔧 Guardar configuración si viene en la respuesta
        if (response.configurationData != null) {
          _configurationData = response.configurationData;
          print('🔧 Provider: Configuración guardada: config_password=${hasConfigPassword ? "SÍ" : "NO"}');
          debugConfigurationInfo();
        } else {
          print('ℹ️ Provider: No hay configuración en la respuesta');
        }
      }
      
      return response;
    } catch (e) {
      print('💥 Provider: Error en activación: $e');
      return LicenseActivationResponse.error(
        message: 'Error inesperado: ${e.toString()}',
      );
    }
  }

  /// Actualiza los datos de licencia en el servidor usando el service
  Future<LicenseActivationResponse> updateServerLicenseData({
    int? licenseId,
    String? appVersion,
    String? deviceName,
  }) async {
    if (licenseId == null) {
      return LicenseActivationResponse.error(
        message: 'ID de licencia requerido para actualización',
      );
    }

    final licenseService = ref.read(licenseServiceProvider);
    
    try {
      final response = await licenseService.updateLicenseData(
        licenseId: licenseId,
        appVersion: appVersion,
        deviceName: deviceName,
      );
      
      if (response.success && response.licenseData != null) {
        await saveLicenseData(response.licenseData!);
        print('✅ Provider: Licencia actualizada y guardada localmente');
        print('🏢 Provider: Tenant ID actualizado: ${response.licenseData!.tenantId}');
        print('📱 Provider: Device Name actualizado: ${response.licenseData!.deviceName}');
        print('📦 Provider: App Version actualizada: ${response.licenseData!.appVersion}');
      }
      
      return response;
    } catch (e) {
      print('💥 Provider: Error actualizando licencia: $e');
      return LicenseActivationResponse.error(
        message: 'Error actualizando licencia: ${e.toString()}',
      );
    }
  }


  /// Refresca la licencia desde el servidor usando checkLicense y aplica tema/config
  Future<LicenseActivationResponse> refreshFromServer({bool silentMode = false}) async {
    final context = silentMode ? 'startup' : 'manual';
    print('🔄 Provider: Iniciando refreshFromServer ($context)');
    
    try {
      final current = await getLicenseData();
      if (current == null || current.key.isEmpty) {
        final errorMsg = 'No hay licencia activa para refrescar';
        if (!silentMode) print('⚠️ Provider: $errorMsg');
        return LicenseActivationResponse.error(message: errorMsg);
      }

      // En modo silencioso (startup) usar timeout y comparar tema
      final timeout = silentMode ? const Duration(seconds: 10) : null;
      final response = await _syncWithServer(current.key, timeout: timeout, compareTheme: silentMode);
      
      // Solo limpiar datos locales en modo manual (no en startup)
      if (!response.success && response.statusCode == 404 && !silentMode) {
        print('🚫 Provider: Licencia no encontrada, limpiando datos locales');
        await deleteLocalLicenseData();
      } else if (!response.success && silentMode) {
        print('🚫 Licencia no encontrada en servidor, manteniendo datos locales');
      }
      
      return response;
    } catch (e) {
      final errorMsg = 'Error refrescando licencia: ${e.toString()}';
      return LicenseActivationResponse.error(message: errorMsg);
    }
  }

  /// Obtiene el tenant_id de la licencia actual
  int? get currentTenantId {
    final licenseData = state.valueOrNull;
    return licenseData?.tenantId;
  }

  /// Obtiene el tenant_id, lanza excepción si no está disponible
  int requireTenantId() {
    final tenantId = currentTenantId;
    if (tenantId == null || tenantId == -1) {
      throw StateError('Tenant ID no disponible. Asegúrese de que la licencia esté activa.');
    }
    return tenantId;
  }

  /// Verifica si hay un tenant_id válido disponible
  bool get hasTenantId {
    final tenantId = currentTenantId;
    return tenantId != null && tenantId != -1;
  }

  // Function to save LicenseData to SharedPreferences
  Future<void> saveLicenseData(LicenseData licenseData) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(licenseData.toJson());
    await prefs.setString('licenseData', jsonString);
    await prefs.setString('nombreQuiosco', licenseData.deviceName);

    state = AsyncData(licenseData);
  }

  // Function to retrieve LicenseData from SharedPreferences
  Future<LicenseData?> getLicenseData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('licenseData');

    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      return LicenseData.fromJson(jsonMap);
    }
    return null; // Return null if no data is stored
  }

  bool isLicenseExpired(LicenseData? licenseData) {
    if (licenseData == null || licenseData.expirationDate.isEmpty) {
      return true; // Consider it expired if no data or empty expiration
    }

    final expirationDateTime = DateTime.tryParse(licenseData.expirationDate);
    if (expirationDateTime == null) {
      return true; // Consider it expired if parsing fails
    }

    final today = DateTime.now();
    return today.isAfter(expirationDateTime);
  }

  Future<void> updateLocalLicenseData({
    int? id,
    int? tenantId,
    String? type,
    String? duration,
    String? key,
    String? expirationDate,
    bool? activationStatus,
    String? deviceId,
    String? deviceName,
    String? appVersion,
    String? latestVersion,
    String? downloadLink,
  }) async {
    final previousState = await future;

    final LicenseData licenseData = LicenseData(
      id: id ?? previousState.id,
      tenantId: tenantId ?? previousState.tenantId,
      type: type ?? previousState.type,
      duration: duration ?? previousState.duration,
      key: key ?? previousState.key,
      expirationDate: expirationDate ?? previousState.expirationDate,
      activationStatus: activationStatus ?? previousState.activationStatus,
      deviceId: deviceId ?? previousState.deviceId,
      deviceName: deviceName ?? previousState.deviceName,
      appVersion: appVersion ?? previousState.appVersion,
      latestVersion: latestVersion ?? previousState.latestVersion,
      downloadLink: downloadLink ?? previousState.downloadLink,
    );

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('licenseData', jsonEncode(licenseData));

    state = AsyncData(licenseData);
  }

  Future<void> deleteLocalLicenseData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('licenseData');
    
    // También limpiar la configuración
    _configurationData = null;

    ref.invalidateSelf();

    print('🧹 Datos de licencia eliminados localmente');
  }
  
  /// Métodos para acceder a la configuración
  
  /// Obtiene la configuración actual
  ConfigurationData? get currentConfiguration => _configurationData;
  
  /// Obtiene el config_password si está disponible
  String? get configPassword => _configurationData?.configPassword;
  
  /// Verifica si hay un config_password válido
  bool get hasConfigPassword => _configurationData?.configPassword?.isNotEmpty == true;
  
  /// Valida si el password proporcionado coincide con el config_password
  bool validateConfigPassword(String password) {
    final configPwd = _configurationData?.configPassword;
    if (configPwd == null || configPwd.isEmpty) {
      print('🔐 validateConfigPassword: No hay config_password disponible');
      return false;
    }
    
    final isValid = configPwd == password;
    print('🔐 validateConfigPassword: Comparando "$password" con "$configPwd" → ${isValid ? "✅ VÁLIDO" : "❌ INVÁLIDO"}');
    return isValid;
  }
  
  /// Método de debugging para mostrar información de configuración
  void debugConfigurationInfo() {
    print('🔧 === INFORMACIÓN DE CONFIGURACIÓN ===');
    print('🔧 Configuración disponible: ${_configurationData != null ? "SÍ" : "NO"}');
    if (_configurationData != null) {
      print('🔧 APIs Net PE Key: ${_configurationData!.apisNetPeKey ?? "NO DISPONIBLE"}');
      print('🔧 Config Password: ${_configurationData!.configPassword != null ? "CONFIGURADO (${_configurationData!.configPassword!.length} chars)" : "NO CONFIGURADO"}');
      print('🔧 Has Config Password: ${hasConfigPassword ? "SÍ" : "NO"}');
    }
    print('🔧 =====================================');
  }
  
  /// Métodos para acceder a la información del negocio
  
  /// Obtiene la información del negocio actual
  BusinessInfo? get currentBusinessInfo {
    final licenseData = state.value;
    return licenseData?.businessInfo;
  }
  
  /// Verifica si hay información del negocio disponible
  bool get hasBusinessInfo => currentBusinessInfo != null;
  
  /// Obtiene el nombre del negocio
  String get businessName => currentBusinessInfo?.businessName ?? '';
  
  /// Obtiene el nombre comercial
  String get tradeName => currentBusinessInfo?.tradeName ?? '';
  
  /// Obtiene el RUC/Tax ID
  String get taxId => currentBusinessInfo?.taxId ?? '';
  
  /// Obtiene la dirección principal
  String get businessAddress => currentBusinessInfo?.address ?? '';
  
  /// Obtiene el nombre de la sucursal (puede ser null)
  String? get branchName => currentBusinessInfo?.branchName;
  
  /// Obtiene la dirección de la sucursal (puede ser null)
  String? get branchAddress => currentBusinessInfo?.branchAddress;
  
  /// Verifica si tiene información de sucursal
  bool get hasBranchInfo => branchName != null && branchName!.isNotEmpty;
  
  /// Método de debugging para mostrar información del negocio
  void debugBusinessInfo() {
    print('🏢 === INFORMACIÓN DEL NEGOCIO ===');
    print('🏢 Business Info disponible: ${hasBusinessInfo ? "SÍ" : "NO"}');
    if (hasBusinessInfo) {
      final info = currentBusinessInfo!;
      print('🏢 Nombre del negocio: ${info.businessName}');
      print('🏢 Nombre comercial: ${info.tradeName}');
      print('🏢 RUC: ${info.taxId}');
      print('🏢 Dirección: ${info.address}');
      print('🏢 Sucursal: ${info.branchName ?? "NO DISPONIBLE"}');
      print('🏢 Dirección sucursal: ${info.branchAddress ?? "NO DISPONIBLE"}');
      print('🏢 Tiene info de sucursal: ${hasBranchInfo ? "SÍ" : "NO"}');
    }
    print('🏢 ================================');
  }

  /// Carga y aplica el tema guardado localmente
  Future<void> _loadAndApplySavedTheme() async {
    try {
      print('🔍 Buscando tema guardado en SharedPreferences...');
      final prefs = await SharedPreferences.getInstance();
      final themeJson = prefs.getString('saved_theme_config');
      
      if (themeJson != null && themeJson.isNotEmpty) {
        print('📦 Tema encontrado en SharedPreferences: ${themeJson.length} chars');
        final themeMap = jsonDecode(themeJson) as Map<String, dynamic>;
        final themeConfig = ThemeConfig.fromJson(themeMap);
        
        print('🎨 Aplicando tema guardado: Primary=${themeConfig.primary}, Secondary=${themeConfig.secondary}');
        await ref.read(appThemeNotifierProvider.notifier).applyTheme(themeConfig);
        print('✅ Tema guardado aplicado exitosamente al iniciar la app');
      } else {
        print('ℹ️ No hay tema guardado en SharedPreferences, usando AppColors por defecto');
        print('   Clave "saved_theme_config" ${themeJson == null ? "no existe" : "está vacía"}');
      }
    } catch (e) {
      print('⚠️ Error cargando tema guardado: $e');
      print('   Continuando con tema por defecto');
    }
  }

  /// Guarda el tema en SharedPreferences
  Future<void> _saveThemeLocally(ThemeConfig themeConfig) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeJson = jsonEncode(themeConfig.toJson());
      await prefs.setString('saved_theme_config', themeJson);
      print('💾 Tema guardado en SharedPreferences: Primary=${themeConfig.primary}, Secondary=${themeConfig.secondary}');
      print('   JSON guardado: ${themeJson.length} chars');
    } catch (e) {
      print('⚠️ Error guardando tema: $e');
    }
  }

  /// Método común para sincronizar con el servidor
  Future<LicenseActivationResponse> _syncWithServer(
    String licenseKey, {
    Duration? timeout,
    bool compareTheme = false,
  }) async {
    final licenseService = ref.read(licenseServiceProvider);
    print('🔍 Llamando a checkLicense para ${licenseKey.substring(0, 5)}...');
    
    final response = timeout != null 
        ? await licenseService.checkLicense(licenseKey).timeout(timeout)
        : await licenseService.checkLicense(licenseKey);
    
    print('📡 Respuesta de verificación recibida: success=${response.success}');
    
    if (response.success) {
      // Actualizar configuración
      if (response.configurationData != null) {
        _configurationData = response.configurationData;
        print('🔧 Configuración actualizada desde servidor: config_password=${hasConfigPassword ? "SÍ" : "NO"}');
        debugConfigurationInfo();
      } else {
        print('ℹ️ No hay configuración en la respuesta del servidor');
      }
      
      // Actualizar tema
      if (response.themeConfig != null) {
        print('🎨 Tema del servidor: Primary=${response.themeConfig!.primary}');
        
        bool shouldUpdateTheme = true;
        
        // Solo comparar tema si se solicita (para optimizar en startup)
        if (compareTheme) {
          final prefs = await SharedPreferences.getInstance();
          final savedThemeJson = prefs.getString('saved_theme_config');
          
          if (savedThemeJson != null) {
            final savedTheme = ThemeConfig.fromJson(jsonDecode(savedThemeJson));
            shouldUpdateTheme = savedTheme.primary != response.themeConfig!.primary ||
                              savedTheme.secondary != response.themeConfig!.secondary;
          }
        }
        
        if (shouldUpdateTheme) {
          print('🔄 ${compareTheme ? "Tema cambió, actualizando" : "Aplicando tema"}...');
          await _saveThemeLocally(response.themeConfig!);
          await ref.read(appThemeNotifierProvider.notifier).applyTheme(response.themeConfig!);
          print('✅ Tema actualizado desde servidor');
        } else {
          print('✓ Tema sin cambios, no se requiere actualización');
        }
      } else {
        print('ℹ️ No hay tema en la respuesta del servidor');
      }
      
      // Actualizar datos de licencia
      if (response.licenseData != null) {
        await saveLicenseData(response.licenseData!);
        print('✅ Datos de licencia actualizados desde servidor');
      }
    }
    
    return response;
  }
}
