// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductImage _$ProductImageFromJson(Map<String, dynamic> json) =>
    _ProductImage(
      id: (json['id'] as num).toInt(),
      url: json['url'] as String,
      title: json['title'] as String? ?? '',
      priority: (json['priority'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$ProductImageToJson(_ProductImage instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'title': instance.title,
      'priority': instance.priority,
    };
