// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductVariation _$ProductVariationFromJson(Map<String, dynamic> json) =>
    _ProductVariation(
      id: (json['id'] as num).toInt(),
      productId: (json['product_id'] as num).toInt(),
      sku: json['sku'] as String?,
      attributes: json['attributes'] as Map<String, dynamic>,
      formattedAttributes: json['formatted_attributes'] as String,
      stock: (json['stock'] as num).toInt(),
      availableStock: (json['available_stock'] as num).toInt(),
      reservedStock: (json['reserved_stock'] as num).toInt(),
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$ProductVariationToJson(_ProductVariation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_id': instance.productId,
      'sku': instance.sku,
      'attributes': instance.attributes,
      'formatted_attributes': instance.formattedAttributes,
      'stock': instance.stock,
      'available_stock': instance.availableStock,
      'reserved_stock': instance.reservedStock,
      'is_active': instance.isActive,
    };
