import 'package:shared_preferences/shared_preferences.dart';

/// Modelo de configuración para CashDro S
class CashdroConfig {
  final String ipAddress;
  final String username;
  final String password;
  final int timeoutSeconds;

  const CashdroConfig({
    required this.ipAddress,
    required this.username,
    required this.password,
    this.timeoutSeconds = 30, // Valor por defecto de 30 segundos
  });

  bool get isConfigured {
    return ipAddress.isNotEmpty && username.isNotEmpty && password.isNotEmpty;
  }

  @override
  String toString() {
    return 'CashdroConfig(ip: $ipAddress, username: $username, timeout: ${timeoutSeconds}s)';
  }
}

/// Servicio para gestionar la configuración de CashDro S
class CashdroConfigService {
  static const String _keyIpAddress = 'cashdro_ip_address';
  static const String _keyUsername = 'cashdro_username';
  static const String _keyPassword = 'cashdro_password';
  static const String _keyTimeoutSeconds = 'cashdro_timeout_seconds';

  /// Obtiene la configuración guardada de CashDro
  static Future<CashdroConfig> getConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      final ipAddress = prefs.getString(_keyIpAddress) ?? '';
      final username = prefs.getString(_keyUsername) ?? '';
      final password = prefs.getString(_keyPassword) ?? '';
      final timeoutSeconds = prefs.getInt(_keyTimeoutSeconds) ?? 30;

      final config = CashdroConfig(
        ipAddress: ipAddress,
        username: username,
        password: password,
        timeoutSeconds: timeoutSeconds,
      );

      print('📋 Configuración CashDro obtenida: ${config.isConfigured ? "Configurada" : "No configurada"}');
      
      return config;
    } catch (e) {
      print('❌ Error obteniendo configuración CashDro: $e');
      return const CashdroConfig(
        ipAddress: '',
        username: '',
        password: '',
        timeoutSeconds: 30,
      );
    }
  }

  /// Guarda la configuración de CashDro
  static Future<bool> saveConfig(CashdroConfig config) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.setString(_keyIpAddress, config.ipAddress);
      await prefs.setString(_keyUsername, config.username);
      await prefs.setString(_keyPassword, config.password);
      await prefs.setInt(_keyTimeoutSeconds, config.timeoutSeconds);

      print('✅ Configuración CashDro guardada exitosamente');
      return true;
    } catch (e) {
      print('❌ Error guardando configuración CashDro: $e');
      return false;
    }
  }

  /// Limpia la configuración de CashDro
  static Future<bool> clearConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.remove(_keyIpAddress);
      await prefs.remove(_keyUsername);
      await prefs.remove(_keyPassword);
      await prefs.remove(_keyTimeoutSeconds);

      print('🗑️ Configuración CashDro eliminada');
      return true;
    } catch (e) {
      print('❌ Error eliminando configuración CashDro: $e');
      return false;
    }
  }

  /// Verifica si hay configuración guardada
  static Future<bool> hasConfig() async {
    final config = await getConfig();
    return config.isConfigured;
  }
}
