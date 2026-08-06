// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_method.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentMethod _$PaymentMethodFromJson(Map<String, dynamic> json) =>
    _PaymentMethod(
      type: $enumDecode(_$PaymentMethodTypeEnumMap, json['type']),
      isActive: json['isActive'] as bool? ?? false,
      configuration: json['configuration'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PaymentMethodToJson(_PaymentMethod instance) =>
    <String, dynamic>{
      'type': _$PaymentMethodTypeEnumMap[instance.type]!,
      'isActive': instance.isActive,
      'configuration': instance.configuration,
    };

const _$PaymentMethodTypeEnumMap = {
  PaymentMethodType.niubizLane3000: 'niubiz_lane3000',
  PaymentMethodType.niubizIm30: 'niubiz_im30',
  PaymentMethodType.izipay: 'izipay',
  PaymentMethodType.cashdroS: 'cashdro_s',
};

_PaymentMethodsConfig _$PaymentMethodsConfigFromJson(
  Map<String, dynamic> json,
) => _PaymentMethodsConfig(
  methods:
      (json['methods'] as List<dynamic>?)
          ?.map((e) => PaymentMethod.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$PaymentMethodsConfigToJson(
  _PaymentMethodsConfig instance,
) => <String, dynamic>{'methods': instance.methods};
