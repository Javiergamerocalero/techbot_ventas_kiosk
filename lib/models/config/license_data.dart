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

    /// Ruta y token del emisor de comprobantes de ESTE cliente, tal como
    /// vienen en `data.tech_fact` de la licencia. Sin esto el kiosco
    /// emitiría con el emisor de otro, que fue lo que pasó: las boletas
    /// de San Fernando salieron con el RUC de TECHBOT porque la ruta y
    /// el token estaban fijos en el código (Javier, 2026-09-17).
    @JsonKey(name: 'tech_fact_route') String? techFactRoute,
    @JsonKey(name: 'tech_fact_token') String? techFactToken,
  }) = _LicenseData;

  factory LicenseData.fromJson(Map<String, dynamic> json) => _$LicenseDataFromJson(json);
}
