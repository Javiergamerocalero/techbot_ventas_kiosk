import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/config/theme_config.dart';
import '../../services/remote_config_service.dart';
import '../../providers/config/license_provider.dart';
import '../../styles/app_layout.dart';

part 'theme_provider.g.dart';

String _getBaseUrl() {
  final appEnv = dotenv.get('APP_ENV');
  return appEnv == 'development'
      ? dotenv.get('DEV_URL', fallback: 'API_URL not found')
      : dotenv.get('PROD_URL', fallback: 'API_URL not found');
}

@Riverpod(keepAlive: true)
class AppThemeNotifier extends AsyncNotifier<ThemeData> {
  ThemeConfig? _currentThemeConfig;

  @override
  Future<ThemeData> build() async {
    final themeConfig = await _loadThemeConfiguration();
    _currentThemeConfig = themeConfig;
    
    // Generar ThemeData
    return _buildThemeData(themeConfig);
  }


  Future<ThemeConfig> _loadThemeConfiguration() async {
    try {
      final tenantId = ref.read(licenseProvider.notifier).currentTenantId;
      
      // Si NO hay tenant_id, usar AppColors directamente (sin consultar endpoint)
      if (tenantId == null) {
        print('🎨 ThemeProvider: No tenant ID available, using AppColors theme');
        print('   (LicenseScreen will use default colors)');
        return ThemeConfigExtension.fromAppColors();
      }
      
      // Si HAY tenant_id, usar AppColors por defecto y esperar que LicenseProvider aplique el tema real
      print('🎨 ThemeProvider: Tenant ID $tenantId found, using AppColors as base');
      print('   (LicenseProvider will apply real theme from license endpoint)');
      return ThemeConfigExtension.fromAppColors();
      
    } catch (e) {
      print('❌ ThemeProvider: Error loading theme config: $e');
      print('⚠️ ThemeProvider: Using full AppColors theme as fallback');
      
      // Si falla completamente, usar tema 100% AppColors
      return ThemeConfigExtension.fromAppColors();
    }
  }

  ThemeData _buildThemeData(ThemeConfig themeConfig) {
    final colorScheme = themeConfig.toColorScheme();
    
    print('🎨 ThemeProvider: Building ThemeData with Material 3');
    
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      
      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: colorScheme.onPrimary,
          fontSize: AppLayout.baseFontSizeTitle,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: AppLayout.baseElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppLayout.baseBorderRadiusM),
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: AppLayout.baseElevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppLayout.baseBorderRadiusS),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppLayout.basePaddingHorizontal,
            vertical: AppLayout.basePaddingVertical,
          ),
        ),
      ),

      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppLayout.baseBorderRadiusS),
          ),
        ),
      ),

      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppLayout.baseBorderRadiusS),
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppLayout.baseBorderRadiusS),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppLayout.baseBorderRadiusS),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppLayout.baseBorderRadiusS),
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: AppLayout.baseBorderWidth,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppLayout.baseBorderRadiusS),
          borderSide: BorderSide(color: colorScheme.error),
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.secondary,
        foregroundColor: colorScheme.onSecondary,
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withValues(alpha: 0.6),
        type: BottomNavigationBarType.fixed,
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surfaceContainerHighest,
        selectedColor: colorScheme.primary,
        labelStyle: TextStyle(color: colorScheme.onSurface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppLayout.baseBorderRadiusXL),
        ),
      ),

      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppLayout.baseBorderRadiusL),
        ),
      ),

      // Scaffold Background
      scaffoldBackgroundColor: colorScheme.surface,
    );
  }

  /// Aplica un tema específico (usado cuando viene de la licencia)
  Future<void> applyTheme(ThemeConfig themeConfig) async {
    print('🎨 ThemeProvider: Applying theme from license');
    print('   Primary recibido: ${themeConfig.primary}');
    print('   Secondary recibido: ${themeConfig.secondary}');
    print('   Background recibido: ${themeConfig.background}');
    print('   Tertiary recibido: ${themeConfig.tertiary}');
    
    // Aplicar merge con AppColors para campos vacíos
    final mergedConfig = themeConfig.mergeWithAppColors();
    print('🔄 ThemeProvider: Después del merge:');
    print('   Primary merged: ${mergedConfig.primary}');
    print('   Secondary merged: ${mergedConfig.secondary}');
    print('   Background merged: ${mergedConfig.background}');
    
    _currentThemeConfig = mergedConfig;
    
    final newTheme = _buildThemeData(mergedConfig);
    state = AsyncData(newTheme);
    print('✅ ThemeProvider: Theme applied successfully');
    print('🎯 ThemeProvider: ColorScheme Primary: ${newTheme.colorScheme.primary}');
  }

  /// Fuerza recarga del tema desde el servidor (DEPRECATED - ya no se usa)
  @Deprecated('Use applyTheme() con tema de la licencia')
  Future<void> refreshTheme() async {
    print('🔄 ThemeProvider: Refreshing theme...');
    state = const AsyncLoading();
    try {
      final themeConfig = await _loadThemeConfiguration();
      _currentThemeConfig = themeConfig;
      final newTheme = _buildThemeData(themeConfig);
      state = AsyncData(newTheme);
      print('✅ ThemeProvider: Theme refreshed successfully');
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      print('❌ ThemeProvider: Error refreshing theme: $e');
    }
  }

  /// Obtiene la configuración de tema actual
  ThemeConfig? get currentThemeConfig => _currentThemeConfig;

  /// Verifica si el tema actual es el por defecto
  bool get isUsingFallbackTheme {
    if (_currentThemeConfig == null) return true;
    return _currentThemeConfig!.primary == '#0A73FF'; // Color por defecto de AppStyles
  }

}

/// Provider para acceder al servicio de configuración
@riverpod
RemoteConfigService remoteConfigService(Ref ref) {
  final tenantId = ref.read(licenseProvider.notifier).currentTenantId ?? 1;
  return RemoteConfigService(
    baseUrl: _getBaseUrl(),
    tenantId: tenantId,
  );
}
