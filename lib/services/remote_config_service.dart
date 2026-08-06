import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/config/app_config.dart';
import '../models/config/theme_config.dart';

class RemoteConfigService {
  final String baseUrl;
  final int tenantId;

  RemoteConfigService({
    required this.baseUrl,
    required this.tenantId,
  });

  /// Obtiene configuración completa del tenant
  Future<AppConfig> fetchConfig() async {
    final url = '$baseUrl/api/tenants/$tenantId/configuration';
    
    print('⚙️ ConfigService: Fetching complete config for tenant $tenantId from: $url');
    
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${await _getAuthToken()}',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        
        if (jsonData['data'] != null && jsonData['data']['configuration'] != null) {
          print('✅ ConfigService: Configuration loaded successfully');
          return AppConfig.fromJson(jsonData['data']['configuration']);
        } else {
          print('⚠️ ConfigService: Invalid configuration structure, using mock');
          return await _getMockConfig();
        }
      } else {
        print('⚠️ ConfigService: HTTP ${response.statusCode}, using mock config');
        return await _getMockConfig();
      }
    } catch (e) {
      print('❌ ConfigService: Error fetching config: $e');
      return await _getMockConfig();
    }
  }

  /// Extrae configuración de tema desde la configuración completa
  Future<ThemeConfig> fetchThemeFromConfig() async {
    try {
      final config = await fetchConfig();
      
      // Extraer tema de la configuración completa
      if (config.styles.containsKey('theme')) {
        final themeData = config.styles['theme'] as Map<String, dynamic>;
        print('🎨 ConfigService: Theme extracted from complete configuration');
        return ThemeConfig.fromJson(themeData);
      } else {
        print('🎨 ConfigService: No theme in config, using default');
        return const ThemeConfig(
          primary: '#0A73FF',
          secondary: '#00C897',
          tertiary: '#2196F3',
          background: '#F9F9F9',
          surface: '#FFFFFF',
          error: '#E53935',
        );
      }
    } catch (e) {
      print('❌ ConfigService: Error extracting theme: $e');
      return const ThemeConfig(
        primary: '#0A73FF',
        secondary: '#00C897',
        tertiary: '#2196F3',
        background: '#F9F9F9',
        surface: '#FFFFFF',
        error: '#E53935',
      );
    }
  }

  /// Configuración mock para testing (basada en AppStyles actuales)
  Future<AppConfig> _getMockConfig() async {
    print('🧪 ConfigService: Using mock configuration based on AppStyles');
    
    // Simular delay de red
    await Future.delayed(const Duration(milliseconds: 800));
    
    final mockConfigJson = {
      'styles': {
        'theme': {
          'primary': '#0A73FF',      // AppColors.primary
          'secondary': '#00C897',    // AppColors.secondary  
          'tertiary': '#2196F3',     // AppColors.info
          'background': '#F9F9F9',   // AppColors.background
          'surface': '#FFFFFF',      // AppColors.white
          'error': '#E53935',        // AppColors.error
          'onPrimary': '#FFFFFF',
          'onSecondary': '#FFFFFF',
          'onBackground': '#222222',  // AppColors.textPrimary
          'onSurface': '#222222',
          'onError': '#FFFFFF',
        },
        'typography': {
          'fontFamily': 'Roboto',
          'scaleFactor': 1.0,
        }
      },
      'layout': {
        'scaleFactor': 1.0,
        'spacing': 'medium',
      },
      'extras': {
        'companyName': 'Ventas Kiosko',
        'supportEmail': 'soporte@ventaskiosko.com',
        'version': '1.0.0',
      }
    };
    
    return AppConfig.fromJson(mockConfigJson);
  }

  /// Obtiene token de autenticación (integración futura con LicenseProvider)
  Future<String> _getAuthToken() async {
    return 'mock-auth-token-tenant-$tenantId';
  }

  /// Constructor de conveniencia para mantener compatibilidad
  @Deprecated('Use RemoteConfigService with baseUrl and tenantId')
  RemoteConfigService.legacy({required String endpointUrl}) 
    : baseUrl = endpointUrl.split('/api').first,
      tenantId = 1;
}
