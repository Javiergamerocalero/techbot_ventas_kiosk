import 'package:freezed_annotation/freezed_annotation.dart';
import 'invoice_item.dart';

part 'electronic_invoice_request.freezed.dart';
part 'electronic_invoice_request.g.dart';

/// Modelo principal para el request de facturación electrónica
@freezed
sealed class ElectronicInvoiceRequest with _$ElectronicInvoiceRequest {
  const ElectronicInvoiceRequest._();

  const factory ElectronicInvoiceRequest({
    /// Operación a realizar (siempre "generar_comprobante")
    @Default('generar_comprobante') String operacion,
    
    /// Tipo de comprobante: 1 = FACTURA, 2 = BOLETA, 3 = NOTA CRÉDITO, 4 = NOTA DÉBITO
    @JsonKey(name: 'tipo_de_comprobante') required int tipoDeComprobante,
    
    /// Serie del comprobante (F para facturas, B para boletas)
    required String serie,
    
    /// Número correlativo del documento
    required String numero,
    
    /// Tipo de transacción SUNAT (1 = VENTA INTERNA)
    @JsonKey(name: 'sunat_transaction') @Default(1) int sunatTransaction,
    
    /// Tipo de documento del cliente: 6 = RUC, 1 = DNI, - = VARIOS
    @JsonKey(name: 'cliente_tipo_de_documento') required String clienteTipoDeDocumento,
    
    /// Número de documento del cliente
    @JsonKey(name: 'cliente_numero_de_documento') required String clienteNumeroDeDocumento,
    
    /// Razón social o nombre completo del cliente
    @JsonKey(name: 'cliente_denominacion') required String clienteDenominacion,
    
    /// Dirección del cliente
    @JsonKey(name: 'cliente_direccion') required String clienteDireccion,
    
    /// Email principal del cliente
    @JsonKey(name: 'cliente_email') @Default('') String clienteEmail,
    
    /// Email secundario 1
    @JsonKey(name: 'cliente_email_1') @Default('') String clienteEmail1,
    
    /// Email secundario 2
    @JsonKey(name: 'cliente_email_2') @Default('') String clienteEmail2,
    
    /// Fecha de emisión (formato DD-MM-AAAA)
    @JsonKey(name: 'fecha_de_emision') required String fechaDeEmision,
    
    /// Fecha de vencimiento (formato DD-MM-AAAA)
    @JsonKey(name: 'fecha_de_vencimiento') @Default('') String fechaDeVencimiento,
    
    /// Moneda: 1 = SOLES, 2 = DÓLARES, 3 = EUROS
    @Default('1') String moneda,
    
    /// Tipo de cambio (solo si moneda != soles)
    @JsonKey(name: 'tipo_de_cambio') @Default('') String tipoDeCambio,
    
    /// Porcentaje de IGV (18.00 en Perú)
    @JsonKey(name: 'porcentaje_de_igv') @Default('18.00') String porcentajeDeIgv,
    
    /// Descuento global aplicado
    @JsonKey(name: 'descuento_global') @Default('') String descuentoGlobal,
    
    /// Total de descuentos
    @JsonKey(name: 'total_descuento') @Default('') String totalDescuento,
    
    /// Total de anticipos
    @JsonKey(name: 'total_anticipo') @Default('') String totalAnticipo,
    
    /// Total gravado (base imponible)
    @JsonKey(name: 'total_gravada') required String totalGravada,
    
    /// Total inafecto
    @JsonKey(name: 'total_inafecta') @Default('') String totalInafecta,
    
    /// Total exonerado
    @JsonKey(name: 'total_exonerada') @Default('') String totalExonerada,
    
    /// Total IGV
    @JsonKey(name: 'total_igv') required String totalIgv,
    
    /// Total gratuito
    @JsonKey(name: 'total_gratuita') @Default('') String totalGratuita,
    
    /// Total otros cargos
    @JsonKey(name: 'total_otros_cargos') @Default('') String totalOtrosCargos,
    
    /// Total del comprobante
    required String total,
    
    /// Tipo de percepción
    @JsonKey(name: 'percepcion_tipo') @Default('') String percepcionTipo,
    
    /// Base imponible de percepción
    @JsonKey(name: 'percepcion_base_imponible') @Default('') String percepcionBaseImponible,
    
    /// Total de percepción
    @JsonKey(name: 'total_percepcion') @Default('') String totalPercepcion,
    
    /// Total incluido percepción
    @JsonKey(name: 'total_incluido_percepcion') @Default('') String totalIncluidoPercepcion,
    
    /// Indica si tiene detracción
    @Default('false') String detraccion,
    
    /// Observaciones del comprobante
    @Default('') String observaciones,
    
    /// Tipo de documento que se modifica (para notas)
    @JsonKey(name: 'documento_que_se_modifica_tipo') @Default('') String documentoQueSeModificaTipo,
    
    /// Serie del documento que se modifica
    @JsonKey(name: 'documento_que_se_modifica_serie') @Default('') String documentoQueSeModificaSerie,
    
    /// Número del documento que se modifica
    @JsonKey(name: 'documento_que_se_modifica_numero') @Default('') String documentoQueSeModificaNumero,
    
    /// Tipo de nota de crédito
    @JsonKey(name: 'tipo_de_nota_de_credito') @Default('') String tipoDeNotaDeCredito,
    
    /// Tipo de nota de débito
    @JsonKey(name: 'tipo_de_nota_de_debito') @Default('') String tipoDeNotaDeDebito,
    
    /// Enviar automáticamente a SUNAT
    @JsonKey(name: 'enviar_automaticamente_a_la_sunat') @Default('true') String enviarAutomaticamenteALaSunat,
    
    /// Enviar automáticamente al cliente
    @JsonKey(name: 'enviar_automaticamente_al_cliente') @Default('false') String enviarAutomaticamenteAlCliente,
    
    /// Código único generado por el sistema
    @JsonKey(name: 'codigo_unico') @Default('') String codigoUnico,
    
    /// Condiciones de pago
    @JsonKey(name: 'condiciones_de_pago') @Default('') String condicionesDePago,
    
    /// Medio de pago
    @JsonKey(name: 'medio_de_pago') @Default('') String medioDePago,
    
    /// Placa del vehículo
    @JsonKey(name: 'placa_vehiculo') @Default('') String placaVehiculo,
    
    /// Orden de compra o servicio
    @JsonKey(name: 'orden_compra_servicio') @Default('') String ordenCompraServicio,
    
    /// Código de tabla personalizada
    @JsonKey(name: 'tabla_personalizada_codigo') @Default('') String tablaPersonalizadaCodigo,
    
    /// Formato de PDF (A4, A5, TICKET)
    @JsonKey(name: 'formato_de_pdf') @Default('') String formatoDePdf,
    
    /// Items del comprobante
    required List<InvoiceItem> items,
  }) = _ElectronicInvoiceRequest;

  factory ElectronicInvoiceRequest.fromJson(Map<String, dynamic> json) =>
      _$ElectronicInvoiceRequestFromJson(json);

  /// Convierte el modelo a JSON para enviar al API
  Map<String, dynamic> toApiJson() {
    final json = toJson();
    
    // Remover campos vacíos para optimizar el request
    json.removeWhere((key, value) => 
      value == '' || 
      value == null ||
      (value is List && value.isEmpty)
    );
    
    return json;
  }

  /// Valida que el request tenga todos los campos obligatorios
  bool get isValid {
    return tipoDeComprobante > 0 &&
           serie.isNotEmpty &&
           numero.isNotEmpty &&
           clienteTipoDeDocumento.isNotEmpty &&
           clienteNumeroDeDocumento.isNotEmpty &&
           clienteDenominacion.isNotEmpty &&
           fechaDeEmision.isNotEmpty &&
           totalGravada.isNotEmpty &&
           totalIgv.isNotEmpty &&
           total.isNotEmpty &&
           items.isNotEmpty;
  }

  /// Obtiene errores de validación
  List<String> get validationErrors {
    final errors = <String>[];
    
    if (tipoDeComprobante <= 0) {
      errors.add('Tipo de comprobante inválido');
    }
    if (serie.isEmpty) {
      errors.add('Serie es obligatoria');
    }
    if (numero.isEmpty) {
      errors.add('Número es obligatorio');
    }
    if (clienteTipoDeDocumento.isEmpty) {
      errors.add('Tipo de documento del cliente es obligatorio');
    }
    if (clienteNumeroDeDocumento.isEmpty) {
      errors.add('Número de documento del cliente es obligatorio');
    }
    if (clienteDenominacion.isEmpty) {
      errors.add('Denominación del cliente es obligatoria');
    }
    if (fechaDeEmision.isEmpty) {
      errors.add('Fecha de emisión es obligatoria');
    }
    if (totalGravada.isEmpty) {
      errors.add('Total gravada es obligatorio');
    }
    if (totalIgv.isEmpty) {
      errors.add('Total IGV es obligatorio');
    }
    if (total.isEmpty) {
      errors.add('Total es obligatorio');
    }
    if (items.isEmpty) {
      errors.add('Debe haber al menos un item');
    }
    
    return errors;
  }
}
