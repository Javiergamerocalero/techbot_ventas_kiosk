// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'license_activation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LicenseActivationResponse _$LicenseActivationResponseFromJson(
  Map<String, dynamic> json,
) => _LicenseActivationResponse(
  success: json['success'] as bool,
  licenseData: json['licenseData'] == null
      ? null
      : LicenseData.fromJson(json['licenseData'] as Map<String, dynamic>),
  themeConfig: json['themeConfig'] == null
      ? null
      : ThemeConfig.fromJson(json['themeConfig'] as Map<String, dynamic>),
  configurationData: json['configurationData'] == null
      ? null
      : ConfigurationData.fromJson(
          json['configurationData'] as Map<String, dynamic>,
        ),
  errorMessage: json['errorMessage'] as String?,
  errorDetails: json['errorDetails'] as Map<String, dynamic>?,
  statusCode: (json['statusCode'] as num?)?.toInt(),
);

Map<String, dynamic> _$LicenseActivationResponseToJson(
  _LicenseActivationResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'licenseData': instance.licenseData,
  'themeConfig': instance.themeConfig,
  'configurationData': instance.configurationData,
  'errorMessage': instance.errorMessage,
  'errorDetails': instance.errorDetails,
  'statusCode': instance.statusCode,
};
