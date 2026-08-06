// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Subcategory _$SubcategoryFromJson(Map<String, dynamic> json) => _Subcategory(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  categoryId: json['categoryId'] as String?,
  description: json['description'] as String?,
  icon: json['icon'] == null
      ? null
      : AppIconData.fromJson(json['icon'] as Map<String, dynamic>),
  products:
      (json['products'] as List<dynamic>?)
          ?.map((e) => Product.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$SubcategoryToJson(_Subcategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'categoryId': instance.categoryId,
      'description': instance.description,
      'icon': instance.icon,
      'products': instance.products,
    };
