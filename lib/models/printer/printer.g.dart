// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrinterDevice _$PrinterDeviceFromJson(Map<String, dynamic> json) =>
    _PrinterDevice(
      vendorId: (json['vendorId'] as num).toInt(),
      productId: (json['productId'] as num).toInt(),
      productName: json['productName'] as String,
      isConnected: json['isConnected'] as bool? ?? false,
    );

Map<String, dynamic> _$PrinterDeviceToJson(_PrinterDevice instance) =>
    <String, dynamic>{
      'vendorId': instance.vendorId,
      'productId': instance.productId,
      'productName': instance.productName,
      'isConnected': instance.isConnected,
    };
