// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combo_cart_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ComboCartItem _$ComboCartItemFromJson(Map<String, dynamic> json) =>
    _ComboCartItem(
      combo: Combo.fromJson(json['combo'] as Map<String, dynamic>),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      addedAt: json['addedAt'] == null
          ? null
          : DateTime.parse(json['addedAt'] as String),
    );

Map<String, dynamic> _$ComboCartItemToJson(_ComboCartItem instance) =>
    <String, dynamic>{
      'combo': instance.combo,
      'quantity': instance.quantity,
      'addedAt': instance.addedAt?.toIso8601String(),
    };
