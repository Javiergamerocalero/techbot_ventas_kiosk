import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'business_info.dart';

part 'license_data.freezed.dart';
part 'license_data.g.dart';

@freezed
abstract class LicenseData with _$LicenseData {
  const factory LicenseData({
    @Default(-1) int id,
    @JsonKey(name: 'tenant_id') @Default(-1) int tenantId,
    @Default('') String type,
    @Default('') String duration,
    @Default('') String key,
    @JsonKey(name: 'expiration_date') @Default('') String expirationDate,
    @JsonKey(name: 'activation_status') @Default(false) bool activationStatus,
    @JsonKey(name: 'device_id') @Default('') String deviceId,
    @JsonKey(name: 'device_name') @Default('') String deviceName,
    @JsonKey(name: 'app_version') @Default('') String appVersion,
    @JsonKey(name: 'latest_version') @Default('') String latestVersion,
    @JsonKey(name: 'download_link') @Default('') String downloadLink,
    @JsonKey(name: 'business_info') BusinessInfo? businessInfo,
  }) = _LicenseData;

  factory LicenseData.fromJson(Map<String, dynamic> json) => _$LicenseDataFromJson(json);
}
