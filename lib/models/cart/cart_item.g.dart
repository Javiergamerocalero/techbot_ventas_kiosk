// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CartItem _$CartItemFromJson(Map<String, dynamic> json) => _CartItem(
  product: Product.fromJson(json['product'] as Map<String, dynamic>),
  quantity: (json['quantity'] as num?)?.toInt() ?? 1,
  selectedVariation: json['selectedVariation'] == null
      ? null
      : ProductVariation.fromJson(
          json['selectedVariation'] as Map<String, dynamic>,
        ),
  addedAt: json['addedAt'] == null
      ? null
      : DateTime.parse(json['addedAt'] as String),
);

Map<String, dynamic> _$CartItemToJson(_CartItem instance) => <String, dynamic>{
  'product': instance.product,
  'quantity': instance.quantity,
  'selectedVariation': instance.selectedVariation,
  'addedAt': instance.addedAt?.toIso8601String(),
};
