// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'license_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LicenseData _$LicenseDataFromJson(Map<String, dynamic> json) => _LicenseData(
  id: (json['id'] as num?)?.toInt() ?? -1,
  tenantId: (json['tenant_id'] as num?)?.toInt() ?? -1,
  type: json['type'] as String? ?? '',
  duration: json['duration'] as String? ?? '',
  key: json['key'] as String? ?? '',
  expirationDate: json['expiration_date'] as String? ?? '',
  activationStatus: json['activation_status'] as bool? ?? false,
  deviceId: json['device_id'] as String? ?? '',
  deviceName: json['device_name'] as String? ?? '',
  appVersion: json['app_version'] as String? ?? '',
  latestVersion: json['latest_version'] as String? ?? '',
  downloadLink: json['download_link'] as String? ?? '',
  businessInfo: json['business_info'] == null
      ? null
      : BusinessInfo.fromJson(json['business_info'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LicenseDataToJson(_LicenseData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenant_id': instance.tenantId,
      'type': instance.type,
      'duration': instance.duration,
      'key': instance.key,
      'expiration_date': instance.expirationDate,
      'activation_status': instance.activationStatus,
      'device_id': instance.deviceId,
      'device_name': instance.deviceName,
      'app_version': instance.appVersion,
      'latest_version': instance.latestVersion,
      'download_link': instance.downloadLink,
      'business_info': instance.businessInfo,
    };
