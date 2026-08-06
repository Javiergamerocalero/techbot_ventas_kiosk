// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialIconData _$MaterialIconDataFromJson(Map<String, dynamic> json) =>
    MaterialIconData(
      codePoint: (json['codePoint'] as num).toInt(),
      fontFamily: json['fontFamily'] as String,
      isMaterialIcon: json['isMaterialIcon'] as bool,
      iconName: json['iconName'] as String?,
      assetPath: json['assetPath'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$MaterialIconDataToJson(MaterialIconData instance) =>
    <String, dynamic>{
      'codePoint': instance.codePoint,
      'fontFamily': instance.fontFamily,
      'isMaterialIcon': instance.isMaterialIcon,
      'iconName': instance.iconName,
      'assetPath': instance.assetPath,
      'runtimeType': instance.$type,
    };

AssetIconData _$AssetIconDataFromJson(Map<String, dynamic> json) =>
    AssetIconData(
      codePoint: (json['codePoint'] as num).toInt(),
      fontFamily: json['fontFamily'] as String,
      isMaterialIcon: json['isMaterialIcon'] as bool,
      iconName: json['iconName'] as String?,
      assetPath: json['assetPath'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$AssetIconDataToJson(AssetIconData instance) =>
    <String, dynamic>{
      'codePoint': instance.codePoint,
      'fontFamily': instance.fontFamily,
      'isMaterialIcon': instance.isMaterialIcon,
      'iconName': instance.iconName,
      'assetPath': instance.assetPath,
      'runtimeType': instance.$type,
    };
