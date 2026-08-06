import 'package:freezed_annotation/freezed_annotation.dart';

part 'invoice_item.freezed.dart';
part 'invoice_item.g.dart';

/// Modelo para un item/línea del comprobante electrónico
@freezed
sealed class InvoiceItem with _$InvoiceItem {
  const InvoiceItem._();

  const factory InvoiceItem({
    /// Unidad de medida: NIU = PRODUCTO, ZZ = SERVICIO
    @JsonKey(name: 'unidad_de_medida') required String unidadDeMedida,
    
    /// Código interno del producto
    required String codigo,
    
    /// Descripción del producto o servicio
    required String descripcion,
    
    /// Cantidad del producto
    required String cantidad,
    
    /// Valor unitario sin IGV
    @JsonKey(name: 'valor_unitario') required String valorUnitario,
    
    /// Precio unitario con IGV
    @JsonKey(name: 'precio_unitario') required String precioUnitario,
    
    /// Descuento aplicado al item
    @Default('') String descuento,
    
    /// Subtotal sin IGV (valor_unitario * cantidad - descuento)
    required String subtotal,
    
    /// Tipo de IGV: 1 = Gravado, 8 = Exonerado, 9 = Inafecto
    @JsonKey(name: 'tipo_de_igv') required int tipoDeIgv,
    
    /// Monto del IGV
    required String igv,
    
    /// Total del item (subtotal + igv)
    required String total,
    
    /// Regularización de anticipo
    @JsonKey(name: 'anticipo_regularizacion') @Default('false') String anticipoRegularizacion,
    
    /// Serie del documento de anticipo
    @JsonKey(name: 'anticipo_documento_serie') @Default('') String anticipoDocumentoSerie,
    
    /// Número del documento de anticipo
    @JsonKey(name: 'anticipo_documento_numero') @Default('') String anticipoDocumentoNumero,
    
    /// Código del producto según catálogo SUNAT
    @JsonKey(name: 'codigo_producto_sunat') @Default('10000000') String codigoProductoSunat,
  }) = _InvoiceItem;

  factory InvoiceItem.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemFromJson(json);

  /// Crea un InvoiceItem desde un producto del carrito
  factory InvoiceItem.fromCartItem({
    required int productId,
    required String productName,
    required int quantity,
    required double unitPrice,
    double discount = 0.0,
    bool isProduct = true,
  }) {
    // Constantes
    const double igvRate = 0.18;
    
    // Cálculos
    final valorUnitario = unitPrice / 1.18; // Precio sin IGV
    final subtotalSinDescuento = valorUnitario * quantity;
    final subtotal = subtotalSinDescuento - discount;
    final igv = subtotal * igvRate;
    final total = subtotal + igv;
    
    return InvoiceItem(
      unidadDeMedida: isProduct ? 'NIU' : 'ZZ',
      codigo: productId.toString(),
      descripcion: productName,
      cantidad: quantity.toString(),
      valorUnitario: valorUnitario.toStringAsFixed(2),
      precioUnitario: unitPrice.toStringAsFixed(2),
      descuento: discount > 0 ? discount.toStringAsFixed(2) : '',
      subtotal: subtotal.toStringAsFixed(2),
      tipoDeIgv: 1, // Gravado - Operación Onerosa
      igv: igv.toStringAsFixed(2),
      total: total.toStringAsFixed(2),
    );
  }
}
