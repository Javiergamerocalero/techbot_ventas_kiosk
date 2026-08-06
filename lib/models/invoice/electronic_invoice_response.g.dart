// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'electronic_invoice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ElectronicInvoiceResponse _$ElectronicInvoiceResponseFromJson(
  Map<String, dynamic> json,
) => _ElectronicInvoiceResponse(
  tipoDeComprobante: (json['tipo_de_comprobante'] as num).toInt(),
  serie: json['serie'] as String,
  numero: (json['numero'] as num).toInt(),
  enlace: json['enlace'] as String? ?? '',
  enlaceDelPdf: json['enlace_del_pdf'] as String? ?? '',
  enlaceDelXml: json['enlace_del_xml'] as String? ?? '',
  enlaceDelCdr: json['enlace_del_cdr'] as String? ?? '',
  aceptadaPorSunat: json['aceptada_por_sunat'] as bool,
  sunatDescription: json['sunat_description'] as String? ?? '',
  sunatNote: json['sunat_note'] as String?,
  sunatResponsecode: json['sunat_responsecode'] as String? ?? '',
  sunatSoapError: json['sunat_soap_error'] as String? ?? '',
  cadenaParaCodigoQr: json['cadena_para_codigo_qr'] as String? ?? '',
  codigoHash: json['codigo_hash'] as String? ?? '',
);

Map<String, dynamic> _$ElectronicInvoiceResponseToJson(
  _ElectronicInvoiceResponse instance,
) => <String, dynamic>{
  'tipo_de_comprobante': instance.tipoDeComprobante,
  'serie': instance.serie,
  'numero': instance.numero,
  'enlace': instance.enlace,
  'enlace_del_pdf': instance.enlaceDelPdf,
  'enlace_del_xml': instance.enlaceDelXml,
  'enlace_del_cdr': instance.enlaceDelCdr,
  'aceptada_por_sunat': instance.aceptadaPorSunat,
  'sunat_description': instance.sunatDescription,
  'sunat_note': instance.sunatNote,
  'sunat_responsecode': instance.sunatResponsecode,
  'sunat_soap_error': instance.sunatSoapError,
  'cadena_para_codigo_qr': instance.cadenaParaCodigoQr,
  'codigo_hash': instance.codigoHash,
};
