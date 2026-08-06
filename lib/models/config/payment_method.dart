import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method.freezed.dart';
part 'payment_method.g.dart';

/// Enumeración de los métodos de pago disponibles
enum PaymentMethodType {
  @JsonValue('niubiz_lane3000')
  niubizLane3000,
  @JsonValue('niubiz_im30')
  niubizIm30,
  @JsonValue('izipay')
  izipay,
  @JsonValue('cashdro_s')
  cashdroS,
}

/// Extensión para obtener el nombre legible del método de pago
extension PaymentMethodTypeExtension on PaymentMethodType {
  String get displayName {
    switch (this) {
      case PaymentMethodType.niubizLane3000:
        return 'Niubiz/Lane3000';
      case PaymentMethodType.niubizIm30:
        return 'Niubiz/IM30';
      case PaymentMethodType.izipay:
        return 'Izipay';
      case PaymentMethodType.cashdroS:
        return 'CashDro S';
    }
  }

  /// Nickname amigable para el usuario
  String get nickname {
    switch (this) {
      case PaymentMethodType.niubizLane3000:
        return 'Tarjeta/QR';
      case PaymentMethodType.niubizIm30:
        return 'Tarjeta/QR';
      case PaymentMethodType.izipay:
        return 'Tarjeta/QR';
      case PaymentMethodType.cashdroS:
        return 'Efectivo';
    }
  }
}

/// Modelo para un método de pago con su configuración
@freezed
sealed class PaymentMethod with _$PaymentMethod {
  const factory PaymentMethod({
    required PaymentMethodType type,
    @Default(false) bool isActive,
    Map<String, dynamic>? configuration,
  }) = _PaymentMethod;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodFromJson(json);
}

/// Configuración de métodos de pago
@freezed
sealed class PaymentMethodsConfig with _$PaymentMethodsConfig {
  const factory PaymentMethodsConfig({
    @Default([]) List<PaymentMethod> methods,
  }) = _PaymentMethodsConfig;

  factory PaymentMethodsConfig.fromJson(Map<String, dynamic> json) =>
      _$PaymentMethodsConfigFromJson(json);
}
