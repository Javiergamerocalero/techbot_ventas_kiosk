// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Product _$ProductFromJson(Map<String, dynamic> json) => _Product(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  description: json['description'] as String,
  price: json['price'] as String,
  hasDiscount: json['hasDiscount'] as bool? ?? false,
  discountPercentage: (json['discountPercentage'] as num?)?.toDouble(),
  discountedPrice: json['discountedPrice'] as String,
  thumbnail: json['thumbnail'] as String,
  images:
      (json['images'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  categoryId: (json['categoryId'] as num).toInt(),
  subCategoryId: (json['subCategoryId'] as num?)?.toInt(),
  isFavorite: json['isFavorite'] as bool? ?? false,
  stock: (json['stock'] as num?)?.toInt(),
  availableStock: (json['availableStock'] as num?)?.toInt(),
  reservedStock: (json['reservedStock'] as num?)?.toInt(),
  sku: json['sku'] as String? ?? '',
  hasVariations: json['hasVariations'] as bool? ?? false,
  variations:
      (json['variations'] as List<dynamic>?)
          ?.map((e) => ProductVariation.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  currencyCode: json['currencyCode'] as String? ?? 'PEN',
  currencySymbol: json['currencySymbol'] as String? ?? 'PEN',
  requiresVariationSelection:
      json['requires_variation_selection'] as bool? ?? false,
);

Map<String, dynamic> _$ProductToJson(_Product instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'price': instance.price,
  'hasDiscount': instance.hasDiscount,
  'discountPercentage': instance.discountPercentage,
  'discountedPrice': instance.discountedPrice,
  'thumbnail': instance.thumbnail,
  'images': instance.images,
  'categoryId': instance.categoryId,
  'subCategoryId': instance.subCategoryId,
  'isFavorite': instance.isFavorite,
  'stock': instance.stock,
  'availableStock': instance.availableStock,
  'reservedStock': instance.reservedStock,
  'sku': instance.sku,
  'hasVariations': instance.hasVariations,
  'variations': instance.variations,
  'currencyCode': instance.currencyCode,
  'currencySymbol': instance.currencySymbol,
  'requires_variation_selection': instance.requiresVariationSelection,
};
