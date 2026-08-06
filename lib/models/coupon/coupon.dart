import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon.freezed.dart';

/// Modelo que representa un cupón de descuento.
@freezed
sealed class Coupon with _$Coupon {
  const factory Coupon({
    required int id,
    required String code,
    required String description,
    required String type, // 'fixed' o 'percentage'
    required String value, // Valor como string del endpoint
    String? minPurchaseAmount,
    int? maxUses,
    required int uses,
    String? expiresAt,
    required bool isActive,
  }) = _Coupon;

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'] as int,
      code: json['code'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      value: json['value'] as String,
      minPurchaseAmount: json['min_purchase_amount'] as String?,
      maxUses: json['max_uses'] as int?,
      uses: json['uses'] as int,
      expiresAt: json['expires_at'] as String?,
      isActive: json['is_active'] as bool,
    );
  }
}

/// Extensión para serialización JSON personalizada
extension CouponJsonExtension on Coupon {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'description': description,
      'type': type,
      'value': value,
      'min_purchase_amount': minPurchaseAmount,
      'max_uses': maxUses,
      'uses': uses,
      'expires_at': expiresAt,
      'is_active': isActive,
    };
  }
}

/// Extensiones para cálculos del cupón.
extension CouponExtensions on Coupon {
  /// Convierte el valor del cupón a double.
  double get valueAsDouble => double.tryParse(value) ?? 0.0;

  /// Convierte el monto mínimo de compra a double.
  double get minPurchaseAmountAsDouble => double.tryParse(minPurchaseAmount ?? '0') ?? 0.0;

  /// Indica si el cupón es de tipo fijo.
  bool get isFixed => type.toLowerCase() == 'fixed';

  /// Indica si el cupón es de tipo porcentaje.
  bool get isPercentage => type.toLowerCase() == 'percentage';

  /// Calcula el descuento aplicable para un monto dado.
  double calculateDiscount(double purchaseAmount) {
    if (purchaseAmount < minPurchaseAmountAsDouble) {
      return 0.0; // No aplica si no cumple el monto mínimo
    }

    if (isFixed) {
      return valueAsDouble;
    } else if (isPercentage) {
      return purchaseAmount * (valueAsDouble / 100.0);
    }

    return 0.0;
  }
}

/// Respuesta del endpoint de validación de cupón.
@freezed
sealed class CouponValidationResponse with _$CouponValidationResponse {
  const factory CouponValidationResponse({
    required bool valid,
    required Coupon coupon,
    String? message, // Para mensajes de error
  }) = _CouponValidationResponse;

  factory CouponValidationResponse.fromJson(Map<String, dynamic> json) {
    return CouponValidationResponse(
      valid: json['valid'] as bool,
      coupon: Coupon.fromJson(json['coupon'] as Map<String, dynamic>),
      message: json['message'] as String?,
    );
  }
}

/// Extensión para serialización JSON de CouponValidationResponse
extension CouponValidationResponseJsonExtension on CouponValidationResponse {
  Map<String, dynamic> toJson() {
    return {
      'valid': valid,
      'coupon': coupon.toJson(),
      'message': message,
    };
  }
}

/// JsonConverter para el modelo Coupon
class CouponConverter implements JsonConverter<Coupon?, Map<String, dynamic>?> {
  const CouponConverter();

  @override
  Coupon? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    return Coupon.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(Coupon? coupon) {
    if (coupon == null) return null;
    return coupon.toJson();
  }
}
