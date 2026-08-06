// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ThemeConfig _$ThemeConfigFromJson(Map<String, dynamic> json) => _ThemeConfig(
  primary: json['primary'] as String,
  secondary: json['secondary'] as String,
  tertiary: json['tertiary'] as String? ?? '',
  background: json['background'] as String? ?? '',
  surface: json['surface'] as String? ?? '',
  onPrimary: json['onPrimary'] as String? ?? '',
  onSecondary: json['onSecondary'] as String? ?? '',
  onBackground: json['onBackground'] as String? ?? '',
  onSurface: json['onSurface'] as String? ?? '',
  error: json['error'] as String? ?? '',
  onError: json['onError'] as String? ?? '',
);

Map<String, dynamic> _$ThemeConfigToJson(_ThemeConfig instance) =>
    <String, dynamic>{
      'primary': instance.primary,
      'secondary': instance.secondary,
      'tertiary': instance.tertiary,
      'background': instance.background,
      'surface': instance.surface,
      'onPrimary': instance.onPrimary,
      'onSecondary': instance.onSecondary,
      'onBackground': instance.onBackground,
      'onSurface': instance.onSurface,
      'error': instance.error,
      'onError': instance.onError,
    };
