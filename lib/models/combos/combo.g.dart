// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Combo _$ComboFromJson(Map<String, dynamic> json) => _Combo(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  price: json['price'] as String,
  hasTax: json['hasTax'] as bool? ?? false,
  taxPercentage: (json['taxPercentage'] as num?)?.toDouble(),
  hasDiscount: json['hasDiscount'] as bool? ?? false,
  discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
  discountedPrice: json['discountedPrice'] as String,
  finalPrice: json['finalPrice'] as String?,
  thumbnail: json['thumbnail'] as String,
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  isActive: json['isActive'] as bool? ?? true,
  products:
      (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  stock: (json['stock'] as num?)?.toInt() ?? 5,
  sku: json['sku'] as String? ?? '',
  currencyCode: json['currencyCode'] as String? ?? 'PEN',
  currencySymbol: json['currencySymbol'] as String? ?? 'PEN',
  requiresVariationSelection:
      json['requires_variation_selection'] as bool? ?? false,
);

Map<String, dynamic> _$ComboToJson(_Combo instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'hasTax': instance.hasTax,
  'taxPercentage': instance.taxPercentage,
  'hasDiscount': instance.hasDiscount,
  'discountPercentage': instance.discountPercentage,
  'discountedPrice': instance.discountedPrice,
  'finalPrice': instance.finalPrice,
  'thumbnail': instance.thumbnail,
  'images': instance.images,
  'isActive': instance.isActive,
  'products': instance.products,
  'stock': instance.stock,
  'sku': instance.sku,
  'currencyCode': instance.currencyCode,
  'currencySymbol': instance.currencySymbol,
  'requires_variation_selection': instance.requiresVariationSelection,
};
