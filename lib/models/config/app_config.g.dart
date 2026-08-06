// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppConfig _$AppConfigFromJson(Map<String, dynamic> json) => _AppConfig(
  styles: json['styles'] as Map<String, dynamic>,
  layout: json['layout'] as Map<String, dynamic>,
  logoUrl: json['logoUrl'] as String?,
  extras: json['extras'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$AppConfigToJson(_AppConfig instance) =>
    <String, dynamic>{
      'styles': instance.styles,
      'layout': instance.layout,
      'logoUrl': instance.logoUrl,
      'extras': instance.extras,
    };
