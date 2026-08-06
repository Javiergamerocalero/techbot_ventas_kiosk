// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Cart _$CartFromJson(Map<String, dynamic> json) => _Cart(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => CartItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  comboItems:
      (json['comboItems'] as List<dynamic>?)
          ?.map((e) => ComboCartItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  cartDiscountPercentage:
      (json['cartDiscountPercentage'] as num?)?.toDouble() ?? 0.0,
  appliedCoupon: json['appliedCoupon'] == null
      ? null
      : const CouponConverter().fromJson(
          json['appliedCoupon'] as Map<String, dynamic>?,
        ),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$CartToJson(_Cart instance) => <String, dynamic>{
  'items': instance.items,
  'comboItems': instance.comboItems,
  'cartDiscountPercentage': instance.cartDiscountPercentage,
  'appliedCoupon': const CouponConverter().toJson(instance.appliedCoupon),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};
