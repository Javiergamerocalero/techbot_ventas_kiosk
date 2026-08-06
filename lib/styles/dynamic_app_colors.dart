import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/config/theme_config.dart';
import '../providers/config/theme_provider.dart';
import 'app_styles.dart';

/// Colores dinámicos que se adaptan a la configuración del tema
class DynamicAppColors {
  final ThemeConfig? themeConfig;
  
  const DynamicAppColors(this.themeConfig);

  /// Colores principales dinámicos con fallback a AppColors
  Color get primary => themeConfig?.primaryColor ?? AppColors.primary;
  Color get secondary => themeConfig?.secondaryColor ?? AppColors.secondary;
  Color get tertiary => themeConfig?.tertiaryColor ?? AppColors.info;
  Color get background => themeConfig?.backgroundColor ?? AppColors.background;
  Color get surface => themeConfig?.surfaceColor ?? AppColors.white;
  Color get error => themeConfig?.errorColor ?? AppColors.error;

  /// Colores de texto dinámicos
  Color get onPrimary => themeConfig?.onPrimaryColor ?? AppColors.white;
  Color get onSecondary => themeConfig?.onSecondaryColor ?? AppColors.white;
  Color get onBackground => themeConfig?.onBackgroundColor ?? AppColors.textPrimary;
  Color get onSurface => themeConfig?.onSurfaceColor ?? AppColors.textPrimary;
  Color get onError => themeConfig?.onErrorColor ?? AppColors.white;

  /// Colores estáticos que no cambian (mantienen valores de AppColors)
  /// Estos colores son específicos del negocio y no se personalizan por tenant
  Color get textSecondary => AppColors.textSecondary;
  Color get divider => AppColors.divider;
  Color get success => AppColors.success;
  Color get warning => AppColors.warning;
  Color get greyLight => AppColors.greyLight;
  Color get grey => AppColors.grey;
  Color get greyDark => AppColors.greyDark;
  Color get green => AppColors.green;
  Color get greenLight => AppColors.greenLight;
  Color get greenDark => AppColors.greenDark;
  Color get white => AppColors.white;

  /// Método estático para crear instancia desde provider
  static DynamicAppColors of(BuildContext context, WidgetRef ref) {
    final themeProvider = ref.watch(appThemeNotifierProvider);
    return DynamicAppColors(
      themeProvider.when(
        data: (theme) => ref.read(appThemeNotifierProvider.notifier).currentThemeConfig,
        loading: () => null,
        error: (_, __) => null,
      ),
    );
  }

  /// Método de conveniencia para obtener colores dinámicos
  static DynamicAppColors fromProvider(WidgetRef ref) {
    final themeNotifier = ref.read(appThemeNotifierProvider.notifier);
    return DynamicAppColors(themeNotifier.currentThemeConfig);
  }

  /// Verifica si se están usando colores personalizados
  bool get isUsingCustomColors => themeConfig != null && 
    themeConfig!.primary != '#0A73FF'; // AppColors.primary por defecto

  /// Obtiene el ColorScheme actual
  ColorScheme get colorScheme => themeConfig?.toColorScheme() ?? 
    const ThemeConfig(
      primary: '#0A73FF',
      secondary: '#00C897',
      tertiary: '#2196F3',
      background: '#F9F9F9',
      surface: '#FFFFFF',
      error: '#E53935',
    ).toColorScheme();
}

/// Extension para facilitar el uso en widgets
extension DynamicAppColorsExtension on WidgetRef {
  /// Acceso rápido a colores dinámicos
  DynamicAppColors get dynamicColors => DynamicAppColors.fromProvider(this);
}

/// Clase de utilidad para migración gradual desde AppColors
class AppColorsCompat {
  static Color getPrimary(WidgetRef? ref) {
    if (ref != null) {
      return ref.dynamicColors.primary;
    }
    return AppColors.primary;
  }

  static Color getSecondary(WidgetRef? ref) {
    if (ref != null) {
      return ref.dynamicColors.secondary;
    }
    return AppColors.secondary;
  }

  static Color getBackground(WidgetRef? ref) {
    if (ref != null) {
      return ref.dynamicColors.background;
    }
    return AppColors.background;
  }

  static Color getTextPrimary(WidgetRef? ref) {
    if (ref != null) {
      return ref.dynamicColors.onBackground;
    }
    return AppColors.textPrimary;
  }
}
