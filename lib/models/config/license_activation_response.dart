import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

import 'package:ventas_kiosko/models/config/license_data.dart';
import 'package:ventas_kiosko/models/config/theme_config.dart';
import 'package:ventas_kiosko/models/config/configuration_data.dart';

part 'license_activation_response.freezed.dart';
part 'license_activation_response.g.dart';

/// Modelo para la respuesta de activación de licencia
@freezed
sealed class LicenseActivationResponse with _$LicenseActivationResponse {
  const factory LicenseActivationResponse({
    required bool success,
    LicenseData? licenseData,
    ThemeConfig? themeConfig,  // ← Campo para el tema
    ConfigurationData? configurationData,  // ← Nuevo campo para la configuración
    String? errorMessage,
    Map<String, dynamic>? errorDetails,
    int? statusCode,
  }) = _LicenseActivationResponse;

  /// Constructor para respuesta exitosa
  const LicenseActivationResponse._();

  factory LicenseActivationResponse.fromJson(Map<String, dynamic> json) =>
      _$LicenseActivationResponseFromJson(json);

  /// Constructor para respuesta exitosa
  factory LicenseActivationResponse.success(
    LicenseData licenseData, {
    ThemeConfig? themeConfig,
    ConfigurationData? configurationData,
  }) {
    return LicenseActivationResponse(
      success: true,
      licenseData: licenseData,
      themeConfig: themeConfig,
      configurationData: configurationData,
      statusCode: 200,
    );
  }

  /// Constructor para respuesta de error
  factory LicenseActivationResponse.error({
    required String message,
    Map<String, dynamic>? details,
    int? statusCode,
  }) {
    return LicenseActivationResponse(
      success: false,
      errorMessage: message,
      errorDetails: details,
      statusCode: statusCode,
    );
  }
}
