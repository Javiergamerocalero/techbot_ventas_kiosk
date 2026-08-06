import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';
import '../../styles/app_styles.dart';

part 'theme_config.freezed.dart';
part 'theme_config.g.dart';

@freezed
sealed class ThemeConfig with _$ThemeConfig {
  const factory ThemeConfig({
    required String primary,
    required String secondary,
    @Default('') String tertiary,
    @Default('') String background,
    @Default('') String surface,
    @Default('') String onPrimary,
    @Default('') String onSecondary,
    @Default('') String onBackground,
    @Default('') String onSurface,
    @Default('') String error,
    @Default('') String onError,
  }) = _ThemeConfig;

  factory ThemeConfig.fromJson(Map<String, dynamic> json) => 
    _$ThemeConfigFromJson(json);
}

extension ThemeConfigExtension on ThemeConfig {
  /// Convierte hex string a Color
  Color _hexToColor(String hex, {Color fallback = Colors.grey}) {
    if (hex.isEmpty) return fallback;
    try {
      final hexColor = hex.replaceAll('#', '');
      final colorValue = int.parse('FF$hexColor', radix: 16);
      return Color(colorValue);
    } catch (e) {
      print('⚠️ ThemeConfig: Error parsing color $hex: $e');
      return fallback;
    }
  }

  /// Convierte Color a hex string
  static String _colorToHex(Color color) {
    // Obtener componentes RGB usando el método recomendado
    final r = ((color.r * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0');
    final g = ((color.g * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0');
    final b = ((color.b * 255.0).round() & 0xff).toRadixString(16).padLeft(2, '0');
    return '#$r$g$b'.toUpperCase();
  }

  /// Colores principales convertidos con fallback a AppColors
  Color get primaryColor => _hexToColor(primary, fallback: AppColors.primary);
  Color get secondaryColor => _hexToColor(secondary, fallback: AppColors.secondary);
  Color get tertiaryColor => _hexToColor(tertiary, fallback: AppColors.info);
  Color get backgroundColor => _hexToColor(background, fallback: AppColors.background);
  Color get surfaceColor => _hexToColor(surface, fallback: AppColors.white);
  Color get errorColor => _hexToColor(error, fallback: AppColors.error);

  /// Colores de texto automáticos basados en contraste
  Color get onPrimaryColor => onPrimary.isNotEmpty 
    ? _hexToColor(onPrimary, fallback: Colors.white)
    : _getContrastColor(primaryColor);
  
  Color get onSecondaryColor => onSecondary.isNotEmpty 
    ? _hexToColor(onSecondary, fallback: Colors.white)
    : _getContrastColor(secondaryColor);
  
  Color get onBackgroundColor => onBackground.isNotEmpty 
    ? _hexToColor(onBackground, fallback: AppColors.textPrimary)
    : _getContrastColor(backgroundColor);
  
  Color get onSurfaceColor => onSurface.isNotEmpty 
    ? _hexToColor(onSurface, fallback: AppColors.textPrimary)
    : _getContrastColor(surfaceColor);
  
  Color get onErrorColor => onError.isNotEmpty 
    ? _hexToColor(onError, fallback: Colors.white)
    : _getContrastColor(errorColor);

  /// Calcula color de contraste automáticamente
  Color _getContrastColor(Color backgroundColor) {
    final luminance = backgroundColor.computeLuminance();
    return luminance > 0.5 ? Colors.black87 : Colors.white;
  }

  /// Genera ColorScheme de Material 3
  ColorScheme toColorScheme({Brightness brightness = Brightness.light}) {
    // Usar ColorScheme() directamente para evitar variaciones tonales de fromSeed()
    return ColorScheme(
      brightness: brightness,
      // Colores principales - EXACTOS sin variaciones
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      secondary: secondaryColor,
      onSecondary: onSecondaryColor,
      tertiary: tertiaryColor,
      onTertiary: _getContrastColor(tertiaryColor),
      error: errorColor,
      onError: onErrorColor,
      // Colores de superficie
      surface: surfaceColor,
      onSurface: onSurfaceColor,
      // Colores derivados para Material 3
      surfaceContainerHighest: surfaceColor,
      surfaceContainerHigh: surfaceColor,
      surfaceContainer: surfaceColor,
      surfaceContainerLow: surfaceColor,
      surfaceContainerLowest: surfaceColor,
      onSurfaceVariant: onSurfaceColor.withValues(alpha: 0.8),
      outline: onSurfaceColor.withValues(alpha: 0.3),
      outlineVariant: onSurfaceColor.withValues(alpha: 0.1),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: onSurfaceColor,
      onInverseSurface: surfaceColor,
      inversePrimary: primaryColor.withValues(alpha: 0.7),
      // Colores de estado (usando primary como base)
      primaryContainer: primaryColor.withValues(alpha: 0.1),
      onPrimaryContainer: primaryColor,
      secondaryContainer: secondaryColor.withValues(alpha: 0.1),
      onSecondaryContainer: secondaryColor,
      tertiaryContainer: tertiaryColor.withValues(alpha: 0.1),
      onTertiaryContainer: tertiaryColor,
      errorContainer: errorColor.withValues(alpha: 0.1),
      onErrorContainer: errorColor,
    );
  }

  /// Factory que crea ThemeConfig 100% desde AppColors
  static ThemeConfig fromAppColors() {
    return ThemeConfig(
      primary: _colorToHex(AppColors.primary),
      secondary: _colorToHex(AppColors.secondary),
      tertiary: _colorToHex(AppColors.info),
      background: _colorToHex(AppColors.background),
      surface: _colorToHex(AppColors.white),
      error: _colorToHex(AppColors.error),
      onPrimary: '#FFFFFF',
      onSecondary: '#FFFFFF',
      onBackground: _colorToHex(AppColors.textPrimary),
      onSurface: _colorToHex(AppColors.textPrimary),
      onError: '#FFFFFF',
    );
  }

  /// Merge con AppColors para campos vacíos
  ThemeConfig mergeWithAppColors() {
    return ThemeConfig(
      primary: primary,  // Ya es requerido
      secondary: secondary,  // Ya es requerido
      tertiary: tertiary.isNotEmpty ? tertiary : _colorToHex(AppColors.info),
      background: background.isNotEmpty ? background : _colorToHex(AppColors.background),
      surface: surface.isNotEmpty ? surface : _colorToHex(AppColors.white),
      error: error.isNotEmpty ? error : _colorToHex(AppColors.error),
      onPrimary: onPrimary.isNotEmpty ? onPrimary : '#FFFFFF',
      onSecondary: onSecondary.isNotEmpty ? onSecondary : '#FFFFFF',
      onBackground: onBackground.isNotEmpty ? onBackground : _colorToHex(AppColors.textPrimary),
      onSurface: onSurface.isNotEmpty ? onSurface : _colorToHex(AppColors.textPrimary),
      onError: onError.isNotEmpty ? onError : '#FFFFFF',
    );
  }

  /// Configuración por defecto basada en AppStyles (deprecated, usar fromAppColors)
  @Deprecated('Use fromAppColors() instead')
  static ThemeConfig get defaultTheme => fromAppColors();
}
