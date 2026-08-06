// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StockResponse _$StockResponseFromJson(Map<String, dynamic> json) =>
    _StockResponse(
      isAvailable: json['isAvailable'] as bool,
      availableStock: (json['availableStock'] as num).toInt(),
      message: json['message'] as String,
      additionalData: json['additionalData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$StockResponseToJson(_StockResponse instance) =>
    <String, dynamic>{
      'isAvailable': instance.isAvailable,
      'availableStock': instance.availableStock,
      'message': instance.message,
      'additionalData': instance.additionalData,
    };
