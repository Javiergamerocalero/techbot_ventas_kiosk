// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_type.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InvoiceData _$InvoiceDataFromJson(Map<String, dynamic> json) => _InvoiceData(
  type: $enumDecode(_$InvoiceTypeEnumMap, json['type']),
  dni: json['dni'] as String? ?? '',
  dniFullName: json['dniFullName'] as String? ?? '',
  ruc: json['ruc'] as String? ?? '',
  razonSocial: json['razonSocial'] as String? ?? '',
  direccion: json['direccion'] as String? ?? '',
  isValidated: json['isValidated'] as bool? ?? false,
);

Map<String, dynamic> _$InvoiceDataToJson(_InvoiceData instance) =>
    <String, dynamic>{
      'type': _$InvoiceTypeEnumMap[instance.type]!,
      'dni': instance.dni,
      'dniFullName': instance.dniFullName,
      'ruc': instance.ruc,
      'razonSocial': instance.razonSocial,
      'direccion': instance.direccion,
      'isValidated': instance.isValidated,
    };

const _$InvoiceTypeEnumMap = {
  InvoiceType.simpleBoleta: 'simple_boleta',
  InvoiceType.boletaWithDNI: 'boleta_with_dni',
  InvoiceType.facturaElectronica: 'factura_electronica',
};
