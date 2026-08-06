// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InvoiceItem _$InvoiceItemFromJson(Map<String, dynamic> json) => _InvoiceItem(
  unidadDeMedida: json['unidad_de_medida'] as String,
  codigo: json['codigo'] as String,
  descripcion: json['descripcion'] as String,
  cantidad: json['cantidad'] as String,
  valorUnitario: json['valor_unitario'] as String,
  precioUnitario: json['precio_unitario'] as String,
  descuento: json['descuento'] as String? ?? '',
  subtotal: json['subtotal'] as String,
  tipoDeIgv: (json['tipo_de_igv'] as num).toInt(),
  igv: json['igv'] as String,
  total: json['total'] as String,
  anticipoRegularizacion: json['anticipo_regularizacion'] as String? ?? 'false',
  anticipoDocumentoSerie: json['anticipo_documento_serie'] as String? ?? '',
  anticipoDocumentoNumero: json['anticipo_documento_numero'] as String? ?? '',
  codigoProductoSunat: json['codigo_producto_sunat'] as String? ?? '10000000',
);

Map<String, dynamic> _$InvoiceItemToJson(_InvoiceItem instance) =>
    <String, dynamic>{
      'unidad_de_medida': instance.unidadDeMedida,
      'codigo': instance.codigo,
      'descripcion': instance.descripcion,
      'cantidad': instance.cantidad,
      'valor_unitario': instance.valorUnitario,
      'precio_unitario': instance.precioUnitario,
      'descuento': instance.descuento,
      'subtotal': instance.subtotal,
      'tipo_de_igv': instance.tipoDeIgv,
      'igv': instance.igv,
      'total': instance.total,
      'anticipo_regularizacion': instance.anticipoRegularizacion,
      'anticipo_documento_serie': instance.anticipoDocumentoSerie,
      'anticipo_documento_numero': instance.anticipoDocumentoNumero,
      'codigo_producto_sunat': instance.codigoProductoSunat,
    };
