// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'electronic_invoice_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ElectronicInvoiceRequest {

/// Operación a realizar (siempre "generar_comprobante")
 String get operacion;/// Tipo de comprobante: 1 = FACTURA, 2 = BOLETA, 3 = NOTA CRÉDITO, 4 = NOTA DÉBITO
@JsonKey(name: 'tipo_de_comprobante') int get tipoDeComprobante;/// Serie del comprobante (F para facturas, B para boletas)
 String get serie;/// Número correlativo del documento
 String get numero;/// Tipo de transacción SUNAT (1 = VENTA INTERNA)
@JsonKey(name: 'sunat_transaction') int get sunatTransaction;/// Tipo de documento del cliente: 6 = RUC, 1 = DNI, - = VARIOS
@JsonKey(name: 'cliente_tipo_de_documento') String get clienteTipoDeDocumento;/// Número de documento del cliente
@JsonKey(name: 'cliente_numero_de_documento') String get clienteNumeroDeDocumento;/// Razón social o nombre completo del cliente
@JsonKey(name: 'cliente_denominacion') String get clienteDenominacion;/// Dirección del cliente
@JsonKey(name: 'cliente_direccion') String get clienteDireccion;/// Email principal del cliente
@JsonKey(name: 'cliente_email') String get clienteEmail;/// Email secundario 1
@JsonKey(name: 'cliente_email_1') String get clienteEmail1;/// Email secundario 2
@JsonKey(name: 'cliente_email_2') String get clienteEmail2;/// Fecha de emisión (formato DD-MM-AAAA)
@JsonKey(name: 'fecha_de_emision') String get fechaDeEmision;/// Fecha de vencimiento (formato DD-MM-AAAA)
@JsonKey(name: 'fecha_de_vencimiento') String get fechaDeVencimiento;/// Moneda: 1 = SOLES, 2 = DÓLARES, 3 = EUROS
 String get moneda;/// Tipo de cambio (solo si moneda != soles)
@JsonKey(name: 'tipo_de_cambio') String get tipoDeCambio;/// Porcentaje de IGV (18.00 en Perú)
@JsonKey(name: 'porcentaje_de_igv') String get porcentajeDeIgv;/// Descuento global aplicado
@JsonKey(name: 'descuento_global') String get descuentoGlobal;/// Total de descuentos
@JsonKey(name: 'total_descuento') String get totalDescuento;/// Total de anticipos
@JsonKey(name: 'total_anticipo') String get totalAnticipo;/// Total gravado (base imponible)
@JsonKey(name: 'total_gravada') String get totalGravada;/// Total inafecto
@JsonKey(name: 'total_inafecta') String get totalInafecta;/// Total exonerado
@JsonKey(name: 'total_exonerada') String get totalExonerada;/// Total IGV
@JsonKey(name: 'total_igv') String get totalIgv;/// Total gratuito
@JsonKey(name: 'total_gratuita') String get totalGratuita;/// Total otros cargos
@JsonKey(name: 'total_otros_cargos') String get totalOtrosCargos;/// Total del comprobante
 String get total;/// Tipo de percepción
@JsonKey(name: 'percepcion_tipo') String get percepcionTipo;/// Base imponible de percepción
@JsonKey(name: 'percepcion_base_imponible') String get percepcionBaseImponible;/// Total de percepción
@JsonKey(name: 'total_percepcion') String get totalPercepcion;/// Total incluido percepción
@JsonKey(name: 'total_incluido_percepcion') String get totalIncluidoPercepcion;/// Indica si tiene detracción
 String get detraccion;/// Observaciones del comprobante
 String get observaciones;/// Tipo de documento que se modifica (para notas)
@JsonKey(name: 'documento_que_se_modifica_tipo') String get documentoQueSeModificaTipo;/// Serie del documento que se modifica
@JsonKey(name: 'documento_que_se_modifica_serie') String get documentoQueSeModificaSerie;/// Número del documento que se modifica
@JsonKey(name: 'documento_que_se_modifica_numero') String get documentoQueSeModificaNumero;/// Tipo de nota de crédito
@JsonKey(name: 'tipo_de_nota_de_credito') String get tipoDeNotaDeCredito;/// Tipo de nota de débito
@JsonKey(name: 'tipo_de_nota_de_debito') String get tipoDeNotaDeDebito;/// Enviar automáticamente a SUNAT
@JsonKey(name: 'enviar_automaticamente_a_la_sunat') String get enviarAutomaticamenteALaSunat;/// Enviar automáticamente al cliente
@JsonKey(name: 'enviar_automaticamente_al_cliente') String get enviarAutomaticamenteAlCliente;/// Código único generado por el sistema
@JsonKey(name: 'codigo_unico') String get codigoUnico;/// Condiciones de pago
@JsonKey(name: 'condiciones_de_pago') String get condicionesDePago;/// Medio de pago
@JsonKey(name: 'medio_de_pago') String get medioDePago;/// Placa del vehículo
@JsonKey(name: 'placa_vehiculo') String get placaVehiculo;/// Orden de compra o servicio
@JsonKey(name: 'orden_compra_servicio') String get ordenCompraServicio;/// Código de tabla personalizada
@JsonKey(name: 'tabla_personalizada_codigo') String get tablaPersonalizadaCodigo;/// Formato de PDF (A4, A5, TICKET)
@JsonKey(name: 'formato_de_pdf') String get formatoDePdf;/// Items del comprobante
 List<InvoiceItem> get items;
/// Create a copy of ElectronicInvoiceRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElectronicInvoiceRequestCopyWith<ElectronicInvoiceRequest> get copyWith => _$ElectronicInvoiceRequestCopyWithImpl<ElectronicInvoiceRequest>(this as ElectronicInvoiceRequest, _$identity);

  /// Serializes this ElectronicInvoiceRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElectronicInvoiceRequest&&(identical(other.operacion, operacion) || other.operacion == operacion)&&(identical(other.tipoDeComprobante, tipoDeComprobante) || other.tipoDeComprobante == tipoDeComprobante)&&(identical(other.serie, serie) || other.serie == serie)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.sunatTransaction, sunatTransaction) || other.sunatTransaction == sunatTransaction)&&(identical(other.clienteTipoDeDocumento, clienteTipoDeDocumento) || other.clienteTipoDeDocumento == clienteTipoDeDocumento)&&(identical(other.clienteNumeroDeDocumento, clienteNumeroDeDocumento) || other.clienteNumeroDeDocumento == clienteNumeroDeDocumento)&&(identical(other.clienteDenominacion, clienteDenominacion) || other.clienteDenominacion == clienteDenominacion)&&(identical(other.clienteDireccion, clienteDireccion) || other.clienteDireccion == clienteDireccion)&&(identical(other.clienteEmail, clienteEmail) || other.clienteEmail == clienteEmail)&&(identical(other.clienteEmail1, clienteEmail1) || other.clienteEmail1 == clienteEmail1)&&(identical(other.clienteEmail2, clienteEmail2) || other.clienteEmail2 == clienteEmail2)&&(identical(other.fechaDeEmision, fechaDeEmision) || other.fechaDeEmision == fechaDeEmision)&&(identical(other.fechaDeVencimiento, fechaDeVencimiento) || other.fechaDeVencimiento == fechaDeVencimiento)&&(identical(other.moneda, moneda) || other.moneda == moneda)&&(identical(other.tipoDeCambio, tipoDeCambio) || other.tipoDeCambio == tipoDeCambio)&&(identical(other.porcentajeDeIgv, porcentajeDeIgv) || other.porcentajeDeIgv == porcentajeDeIgv)&&(identical(other.descuentoGlobal, descuentoGlobal) || other.descuentoGlobal == descuentoGlobal)&&(identical(other.totalDescuento, totalDescuento) || other.totalDescuento == totalDescuento)&&(identical(other.totalAnticipo, totalAnticipo) || other.totalAnticipo == totalAnticipo)&&(identical(other.totalGravada, totalGravada) || other.totalGravada == totalGravada)&&(identical(other.totalInafecta, totalInafecta) || other.totalInafecta == totalInafecta)&&(identical(other.totalExonerada, totalExonerada) || other.totalExonerada == totalExonerada)&&(identical(other.totalIgv, totalIgv) || other.totalIgv == totalIgv)&&(identical(other.totalGratuita, totalGratuita) || other.totalGratuita == totalGratuita)&&(identical(other.totalOtrosCargos, totalOtrosCargos) || other.totalOtrosCargos == totalOtrosCargos)&&(identical(other.total, total) || other.total == total)&&(identical(other.percepcionTipo, percepcionTipo) || other.percepcionTipo == percepcionTipo)&&(identical(other.percepcionBaseImponible, percepcionBaseImponible) || other.percepcionBaseImponible == percepcionBaseImponible)&&(identical(other.totalPercepcion, totalPercepcion) || other.totalPercepcion == totalPercepcion)&&(identical(other.totalIncluidoPercepcion, totalIncluidoPercepcion) || other.totalIncluidoPercepcion == totalIncluidoPercepcion)&&(identical(other.detraccion, detraccion) || other.detraccion == detraccion)&&(identical(other.observaciones, observaciones) || other.observaciones == observaciones)&&(identical(other.documentoQueSeModificaTipo, documentoQueSeModificaTipo) || other.documentoQueSeModificaTipo == documentoQueSeModificaTipo)&&(identical(other.documentoQueSeModificaSerie, documentoQueSeModificaSerie) || other.documentoQueSeModificaSerie == documentoQueSeModificaSerie)&&(identical(other.documentoQueSeModificaNumero, documentoQueSeModificaNumero) || other.documentoQueSeModificaNumero == documentoQueSeModificaNumero)&&(identical(other.tipoDeNotaDeCredito, tipoDeNotaDeCredito) || other.tipoDeNotaDeCredito == tipoDeNotaDeCredito)&&(identical(other.tipoDeNotaDeDebito, tipoDeNotaDeDebito) || other.tipoDeNotaDeDebito == tipoDeNotaDeDebito)&&(identical(other.enviarAutomaticamenteALaSunat, enviarAutomaticamenteALaSunat) || other.enviarAutomaticamenteALaSunat == enviarAutomaticamenteALaSunat)&&(identical(other.enviarAutomaticamenteAlCliente, enviarAutomaticamenteAlCliente) || other.enviarAutomaticamenteAlCliente == enviarAutomaticamenteAlCliente)&&(identical(other.codigoUnico, codigoUnico) || other.codigoUnico == codigoUnico)&&(identical(other.condicionesDePago, condicionesDePago) || other.condicionesDePago == condicionesDePago)&&(identical(other.medioDePago, medioDePago) || other.medioDePago == medioDePago)&&(identical(other.placaVehiculo, placaVehiculo) || other.placaVehiculo == placaVehiculo)&&(identical(other.ordenCompraServicio, ordenCompraServicio) || other.ordenCompraServicio == ordenCompraServicio)&&(identical(other.tablaPersonalizadaCodigo, tablaPersonalizadaCodigo) || other.tablaPersonalizadaCodigo == tablaPersonalizadaCodigo)&&(identical(other.formatoDePdf, formatoDePdf) || other.formatoDePdf == formatoDePdf)&&const DeepCollectionEquality().equals(other.items, items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,operacion,tipoDeComprobante,serie,numero,sunatTransaction,clienteTipoDeDocumento,clienteNumeroDeDocumento,clienteDenominacion,clienteDireccion,clienteEmail,clienteEmail1,clienteEmail2,fechaDeEmision,fechaDeVencimiento,moneda,tipoDeCambio,porcentajeDeIgv,descuentoGlobal,totalDescuento,totalAnticipo,totalGravada,totalInafecta,totalExonerada,totalIgv,totalGratuita,totalOtrosCargos,total,percepcionTipo,percepcionBaseImponible,totalPercepcion,totalIncluidoPercepcion,detraccion,observaciones,documentoQueSeModificaTipo,documentoQueSeModificaSerie,documentoQueSeModificaNumero,tipoDeNotaDeCredito,tipoDeNotaDeDebito,enviarAutomaticamenteALaSunat,enviarAutomaticamenteAlCliente,codigoUnico,condicionesDePago,medioDePago,placaVehiculo,ordenCompraServicio,tablaPersonalizadaCodigo,formatoDePdf,const DeepCollectionEquality().hash(items)]);

@override
String toString() {
  return 'ElectronicInvoiceRequest(operacion: $operacion, tipoDeComprobante: $tipoDeComprobante, serie: $serie, numero: $numero, sunatTransaction: $sunatTransaction, clienteTipoDeDocumento: $clienteTipoDeDocumento, clienteNumeroDeDocumento: $clienteNumeroDeDocumento, clienteDenominacion: $clienteDenominacion, clienteDireccion: $clienteDireccion, clienteEmail: $clienteEmail, clienteEmail1: $clienteEmail1, clienteEmail2: $clienteEmail2, fechaDeEmision: $fechaDeEmision, fechaDeVencimiento: $fechaDeVencimiento, moneda: $moneda, tipoDeCambio: $tipoDeCambio, porcentajeDeIgv: $porcentajeDeIgv, descuentoGlobal: $descuentoGlobal, totalDescuento: $totalDescuento, totalAnticipo: $totalAnticipo, totalGravada: $totalGravada, totalInafecta: $totalInafecta, totalExonerada: $totalExonerada, totalIgv: $totalIgv, totalGratuita: $totalGratuita, totalOtrosCargos: $totalOtrosCargos, total: $total, percepcionTipo: $percepcionTipo, percepcionBaseImponible: $percepcionBaseImponible, totalPercepcion: $totalPercepcion, totalIncluidoPercepcion: $totalIncluidoPercepcion, detraccion: $detraccion, observaciones: $observaciones, documentoQueSeModificaTipo: $documentoQueSeModificaTipo, documentoQueSeModificaSerie: $documentoQueSeModificaSerie, documentoQueSeModificaNumero: $documentoQueSeModificaNumero, tipoDeNotaDeCredito: $tipoDeNotaDeCredito, tipoDeNotaDeDebito: $tipoDeNotaDeDebito, enviarAutomaticamenteALaSunat: $enviarAutomaticamenteALaSunat, enviarAutomaticamenteAlCliente: $enviarAutomaticamenteAlCliente, codigoUnico: $codigoUnico, condicionesDePago: $condicionesDePago, medioDePago: $medioDePago, placaVehiculo: $placaVehiculo, ordenCompraServicio: $ordenCompraServicio, tablaPersonalizadaCodigo: $tablaPersonalizadaCodigo, formatoDePdf: $formatoDePdf, items: $items)';
}


}

/// @nodoc
abstract mixin class $ElectronicInvoiceRequestCopyWith<$Res>  {
  factory $ElectronicInvoiceRequestCopyWith(ElectronicInvoiceRequest value, $Res Function(ElectronicInvoiceRequest) _then) = _$ElectronicInvoiceRequestCopyWithImpl;
@useResult
$Res call({
 String operacion,@JsonKey(name: 'tipo_de_comprobante') int tipoDeComprobante, String serie, String numero,@JsonKey(name: 'sunat_transaction') int sunatTransaction,@JsonKey(name: 'cliente_tipo_de_documento') String clienteTipoDeDocumento,@JsonKey(name: 'cliente_numero_de_documento') String clienteNumeroDeDocumento,@JsonKey(name: 'cliente_denominacion') String clienteDenominacion,@JsonKey(name: 'cliente_direccion') String clienteDireccion,@JsonKey(name: 'cliente_email') String clienteEmail,@JsonKey(name: 'cliente_email_1') String clienteEmail1,@JsonKey(name: 'cliente_email_2') String clienteEmail2,@JsonKey(name: 'fecha_de_emision') String fechaDeEmision,@JsonKey(name: 'fecha_de_vencimiento') String fechaDeVencimiento, String moneda,@JsonKey(name: 'tipo_de_cambio') String tipoDeCambio,@JsonKey(name: 'porcentaje_de_igv') String porcentajeDeIgv,@JsonKey(name: 'descuento_global') String descuentoGlobal,@JsonKey(name: 'total_descuento') String totalDescuento,@JsonKey(name: 'total_anticipo') String totalAnticipo,@JsonKey(name: 'total_gravada') String totalGravada,@JsonKey(name: 'total_inafecta') String totalInafecta,@JsonKey(name: 'total_exonerada') String totalExonerada,@JsonKey(name: 'total_igv') String totalIgv,@JsonKey(name: 'total_gratuita') String totalGratuita,@JsonKey(name: 'total_otros_cargos') String totalOtrosCargos, String total,@JsonKey(name: 'percepcion_tipo') String percepcionTipo,@JsonKey(name: 'percepcion_base_imponible') String percepcionBaseImponible,@JsonKey(name: 'total_percepcion') String totalPercepcion,@JsonKey(name: 'total_incluido_percepcion') String totalIncluidoPercepcion, String detraccion, String observaciones,@JsonKey(name: 'documento_que_se_modifica_tipo') String documentoQueSeModificaTipo,@JsonKey(name: 'documento_que_se_modifica_serie') String documentoQueSeModificaSerie,@JsonKey(name: 'documento_que_se_modifica_numero') String documentoQueSeModificaNumero,@JsonKey(name: 'tipo_de_nota_de_credito') String tipoDeNotaDeCredito,@JsonKey(name: 'tipo_de_nota_de_debito') String tipoDeNotaDeDebito,@JsonKey(name: 'enviar_automaticamente_a_la_sunat') String enviarAutomaticamenteALaSunat,@JsonKey(name: 'enviar_automaticamente_al_cliente') String enviarAutomaticamenteAlCliente,@JsonKey(name: 'codigo_unico') String codigoUnico,@JsonKey(name: 'condiciones_de_pago') String condicionesDePago,@JsonKey(name: 'medio_de_pago') String medioDePago,@JsonKey(name: 'placa_vehiculo') String placaVehiculo,@JsonKey(name: 'orden_compra_servicio') String ordenCompraServicio,@JsonKey(name: 'tabla_personalizada_codigo') String tablaPersonalizadaCodigo,@JsonKey(name: 'formato_de_pdf') String formatoDePdf, List<InvoiceItem> items
});




}
/// @nodoc
class _$ElectronicInvoiceRequestCopyWithImpl<$Res>
    implements $ElectronicInvoiceRequestCopyWith<$Res> {
  _$ElectronicInvoiceRequestCopyWithImpl(this._self, this._then);

  final ElectronicInvoiceRequest _self;
  final $Res Function(ElectronicInvoiceRequest) _then;

/// Create a copy of ElectronicInvoiceRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? operacion = null,Object? tipoDeComprobante = null,Object? serie = null,Object? numero = null,Object? sunatTransaction = null,Object? clienteTipoDeDocumento = null,Object? clienteNumeroDeDocumento = null,Object? clienteDenominacion = null,Object? clienteDireccion = null,Object? clienteEmail = null,Object? clienteEmail1 = null,Object? clienteEmail2 = null,Object? fechaDeEmision = null,Object? fechaDeVencimiento = null,Object? moneda = null,Object? tipoDeCambio = null,Object? porcentajeDeIgv = null,Object? descuentoGlobal = null,Object? totalDescuento = null,Object? totalAnticipo = null,Object? totalGravada = null,Object? totalInafecta = null,Object? totalExonerada = null,Object? totalIgv = null,Object? totalGratuita = null,Object? totalOtrosCargos = null,Object? total = null,Object? percepcionTipo = null,Object? percepcionBaseImponible = null,Object? totalPercepcion = null,Object? totalIncluidoPercepcion = null,Object? detraccion = null,Object? observaciones = null,Object? documentoQueSeModificaTipo = null,Object? documentoQueSeModificaSerie = null,Object? documentoQueSeModificaNumero = null,Object? tipoDeNotaDeCredito = null,Object? tipoDeNotaDeDebito = null,Object? enviarAutomaticamenteALaSunat = null,Object? enviarAutomaticamenteAlCliente = null,Object? codigoUnico = null,Object? condicionesDePago = null,Object? medioDePago = null,Object? placaVehiculo = null,Object? ordenCompraServicio = null,Object? tablaPersonalizadaCodigo = null,Object? formatoDePdf = null,Object? items = null,}) {
  return _then(_self.copyWith(
operacion: null == operacion ? _self.operacion : operacion // ignore: cast_nullable_to_non_nullable
as String,tipoDeComprobante: null == tipoDeComprobante ? _self.tipoDeComprobante : tipoDeComprobante // ignore: cast_nullable_to_non_nullable
as int,serie: null == serie ? _self.serie : serie // ignore: cast_nullable_to_non_nullable
as String,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String,sunatTransaction: null == sunatTransaction ? _self.sunatTransaction : sunatTransaction // ignore: cast_nullable_to_non_nullable
as int,clienteTipoDeDocumento: null == clienteTipoDeDocumento ? _self.clienteTipoDeDocumento : clienteTipoDeDocumento // ignore: cast_nullable_to_non_nullable
as String,clienteNumeroDeDocumento: null == clienteNumeroDeDocumento ? _self.clienteNumeroDeDocumento : clienteNumeroDeDocumento // ignore: cast_nullable_to_non_nullable
as String,clienteDenominacion: null == clienteDenominacion ? _self.clienteDenominacion : clienteDenominacion // ignore: cast_nullable_to_non_nullable
as String,clienteDireccion: null == clienteDireccion ? _self.clienteDireccion : clienteDireccion // ignore: cast_nullable_to_non_nullable
as String,clienteEmail: null == clienteEmail ? _self.clienteEmail : clienteEmail // ignore: cast_nullable_to_non_nullable
as String,clienteEmail1: null == clienteEmail1 ? _self.clienteEmail1 : clienteEmail1 // ignore: cast_nullable_to_non_nullable
as String,clienteEmail2: null == clienteEmail2 ? _self.clienteEmail2 : clienteEmail2 // ignore: cast_nullable_to_non_nullable
as String,fechaDeEmision: null == fechaDeEmision ? _self.fechaDeEmision : fechaDeEmision // ignore: cast_nullable_to_non_nullable
as String,fechaDeVencimiento: null == fechaDeVencimiento ? _self.fechaDeVencimiento : fechaDeVencimiento // ignore: cast_nullable_to_non_nullable
as String,moneda: null == moneda ? _self.moneda : moneda // ignore: cast_nullable_to_non_nullable
as String,tipoDeCambio: null == tipoDeCambio ? _self.tipoDeCambio : tipoDeCambio // ignore: cast_nullable_to_non_nullable
as String,porcentajeDeIgv: null == porcentajeDeIgv ? _self.porcentajeDeIgv : porcentajeDeIgv // ignore: cast_nullable_to_non_nullable
as String,descuentoGlobal: null == descuentoGlobal ? _self.descuentoGlobal : descuentoGlobal // ignore: cast_nullable_to_non_nullable
as String,totalDescuento: null == totalDescuento ? _self.totalDescuento : totalDescuento // ignore: cast_nullable_to_non_nullable
as String,totalAnticipo: null == totalAnticipo ? _self.totalAnticipo : totalAnticipo // ignore: cast_nullable_to_non_nullable
as String,totalGravada: null == totalGravada ? _self.totalGravada : totalGravada // ignore: cast_nullable_to_non_nullable
as String,totalInafecta: null == totalInafecta ? _self.totalInafecta : totalInafecta // ignore: cast_nullable_to_non_nullable
as String,totalExonerada: null == totalExonerada ? _self.totalExonerada : totalExonerada // ignore: cast_nullable_to_non_nullable
as String,totalIgv: null == totalIgv ? _self.totalIgv : totalIgv // ignore: cast_nullable_to_non_nullable
as String,totalGratuita: null == totalGratuita ? _self.totalGratuita : totalGratuita // ignore: cast_nullable_to_non_nullable
as String,totalOtrosCargos: null == totalOtrosCargos ? _self.totalOtrosCargos : totalOtrosCargos // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as String,percepcionTipo: null == percepcionTipo ? _self.percepcionTipo : percepcionTipo // ignore: cast_nullable_to_non_nullable
as String,percepcionBaseImponible: null == percepcionBaseImponible ? _self.percepcionBaseImponible : percepcionBaseImponible // ignore: cast_nullable_to_non_nullable
as String,totalPercepcion: null == totalPercepcion ? _self.totalPercepcion : totalPercepcion // ignore: cast_nullable_to_non_nullable
as String,totalIncluidoPercepcion: null == totalIncluidoPercepcion ? _self.totalIncluidoPercepcion : totalIncluidoPercepcion // ignore: cast_nullable_to_non_nullable
as String,detraccion: null == detraccion ? _self.detraccion : detraccion // ignore: cast_nullable_to_non_nullable
as String,observaciones: null == observaciones ? _self.observaciones : observaciones // ignore: cast_nullable_to_non_nullable
as String,documentoQueSeModificaTipo: null == documentoQueSeModificaTipo ? _self.documentoQueSeModificaTipo : documentoQueSeModificaTipo // ignore: cast_nullable_to_non_nullable
as String,documentoQueSeModificaSerie: null == documentoQueSeModificaSerie ? _self.documentoQueSeModificaSerie : documentoQueSeModificaSerie // ignore: cast_nullable_to_non_nullable
as String,documentoQueSeModificaNumero: null == documentoQueSeModificaNumero ? _self.documentoQueSeModificaNumero : documentoQueSeModificaNumero // ignore: cast_nullable_to_non_nullable
as String,tipoDeNotaDeCredito: null == tipoDeNotaDeCredito ? _self.tipoDeNotaDeCredito : tipoDeNotaDeCredito // ignore: cast_nullable_to_non_nullable
as String,tipoDeNotaDeDebito: null == tipoDeNotaDeDebito ? _self.tipoDeNotaDeDebito : tipoDeNotaDeDebito // ignore: cast_nullable_to_non_nullable
as String,enviarAutomaticamenteALaSunat: null == enviarAutomaticamenteALaSunat ? _self.enviarAutomaticamenteALaSunat : enviarAutomaticamenteALaSunat // ignore: cast_nullable_to_non_nullable
as String,enviarAutomaticamenteAlCliente: null == enviarAutomaticamenteAlCliente ? _self.enviarAutomaticamenteAlCliente : enviarAutomaticamenteAlCliente // ignore: cast_nullable_to_non_nullable
as String,codigoUnico: null == codigoUnico ? _self.codigoUnico : codigoUnico // ignore: cast_nullable_to_non_nullable
as String,condicionesDePago: null == condicionesDePago ? _self.condicionesDePago : condicionesDePago // ignore: cast_nullable_to_non_nullable
as String,medioDePago: null == medioDePago ? _self.medioDePago : medioDePago // ignore: cast_nullable_to_non_nullable
as String,placaVehiculo: null == placaVehiculo ? _self.placaVehiculo : placaVehiculo // ignore: cast_nullable_to_non_nullable
as String,ordenCompraServicio: null == ordenCompraServicio ? _self.ordenCompraServicio : ordenCompraServicio // ignore: cast_nullable_to_non_nullable
as String,tablaPersonalizadaCodigo: null == tablaPersonalizadaCodigo ? _self.tablaPersonalizadaCodigo : tablaPersonalizadaCodigo // ignore: cast_nullable_to_non_nullable
as String,formatoDePdf: null == formatoDePdf ? _self.formatoDePdf : formatoDePdf // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<InvoiceItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [ElectronicInvoiceRequest].
extension ElectronicInvoiceRequestPatterns on ElectronicInvoiceRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElectronicInvoiceRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElectronicInvoiceRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElectronicInvoiceRequest value)  $default,){
final _that = this;
switch (_that) {
case _ElectronicInvoiceRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElectronicInvoiceRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ElectronicInvoiceRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String operacion, @JsonKey(name: 'tipo_de_comprobante')  int tipoDeComprobante,  String serie,  String numero, @JsonKey(name: 'sunat_transaction')  int sunatTransaction, @JsonKey(name: 'cliente_tipo_de_documento')  String clienteTipoDeDocumento, @JsonKey(name: 'cliente_numero_de_documento')  String clienteNumeroDeDocumento, @JsonKey(name: 'cliente_denominacion')  String clienteDenominacion, @JsonKey(name: 'cliente_direccion')  String clienteDireccion, @JsonKey(name: 'cliente_email')  String clienteEmail, @JsonKey(name: 'cliente_email_1')  String clienteEmail1, @JsonKey(name: 'cliente_email_2')  String clienteEmail2, @JsonKey(name: 'fecha_de_emision')  String fechaDeEmision, @JsonKey(name: 'fecha_de_vencimiento')  String fechaDeVencimiento,  String moneda, @JsonKey(name: 'tipo_de_cambio')  String tipoDeCambio, @JsonKey(name: 'porcentaje_de_igv')  String porcentajeDeIgv, @JsonKey(name: 'descuento_global')  String descuentoGlobal, @JsonKey(name: 'total_descuento')  String totalDescuento, @JsonKey(name: 'total_anticipo')  String totalAnticipo, @JsonKey(name: 'total_gravada')  String totalGravada, @JsonKey(name: 'total_inafecta')  String totalInafecta, @JsonKey(name: 'total_exonerada')  String totalExonerada, @JsonKey(name: 'total_igv')  String totalIgv, @JsonKey(name: 'total_gratuita')  String totalGratuita, @JsonKey(name: 'total_otros_cargos')  String totalOtrosCargos,  String total, @JsonKey(name: 'percepcion_tipo')  String percepcionTipo, @JsonKey(name: 'percepcion_base_imponible')  String percepcionBaseImponible, @JsonKey(name: 'total_percepcion')  String totalPercepcion, @JsonKey(name: 'total_incluido_percepcion')  String totalIncluidoPercepcion,  String detraccion,  String observaciones, @JsonKey(name: 'documento_que_se_modifica_tipo')  String documentoQueSeModificaTipo, @JsonKey(name: 'documento_que_se_modifica_serie')  String documentoQueSeModificaSerie, @JsonKey(name: 'documento_que_se_modifica_numero')  String documentoQueSeModificaNumero, @JsonKey(name: 'tipo_de_nota_de_credito')  String tipoDeNotaDeCredito, @JsonKey(name: 'tipo_de_nota_de_debito')  String tipoDeNotaDeDebito, @JsonKey(name: 'enviar_automaticamente_a_la_sunat')  String enviarAutomaticamenteALaSunat, @JsonKey(name: 'enviar_automaticamente_al_cliente')  String enviarAutomaticamenteAlCliente, @JsonKey(name: 'codigo_unico')  String codigoUnico, @JsonKey(name: 'condiciones_de_pago')  String condicionesDePago, @JsonKey(name: 'medio_de_pago')  String medioDePago, @JsonKey(name: 'placa_vehiculo')  String placaVehiculo, @JsonKey(name: 'orden_compra_servicio')  String ordenCompraServicio, @JsonKey(name: 'tabla_personalizada_codigo')  String tablaPersonalizadaCodigo, @JsonKey(name: 'formato_de_pdf')  String formatoDePdf,  List<InvoiceItem> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElectronicInvoiceRequest() when $default != null:
return $default(_that.operacion,_that.tipoDeComprobante,_that.serie,_that.numero,_that.sunatTransaction,_that.clienteTipoDeDocumento,_that.clienteNumeroDeDocumento,_that.clienteDenominacion,_that.clienteDireccion,_that.clienteEmail,_that.clienteEmail1,_that.clienteEmail2,_that.fechaDeEmision,_that.fechaDeVencimiento,_that.moneda,_that.tipoDeCambio,_that.porcentajeDeIgv,_that.descuentoGlobal,_that.totalDescuento,_that.totalAnticipo,_that.totalGravada,_that.totalInafecta,_that.totalExonerada,_that.totalIgv,_that.totalGratuita,_that.totalOtrosCargos,_that.total,_that.percepcionTipo,_that.percepcionBaseImponible,_that.totalPercepcion,_that.totalIncluidoPercepcion,_that.detraccion,_that.observaciones,_that.documentoQueSeModificaTipo,_that.documentoQueSeModificaSerie,_that.documentoQueSeModificaNumero,_that.tipoDeNotaDeCredito,_that.tipoDeNotaDeDebito,_that.enviarAutomaticamenteALaSunat,_that.enviarAutomaticamenteAlCliente,_that.codigoUnico,_that.condicionesDePago,_that.medioDePago,_that.placaVehiculo,_that.ordenCompraServicio,_that.tablaPersonalizadaCodigo,_that.formatoDePdf,_that.items);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String operacion, @JsonKey(name: 'tipo_de_comprobante')  int tipoDeComprobante,  String serie,  String numero, @JsonKey(name: 'sunat_transaction')  int sunatTransaction, @JsonKey(name: 'cliente_tipo_de_documento')  String clienteTipoDeDocumento, @JsonKey(name: 'cliente_numero_de_documento')  String clienteNumeroDeDocumento, @JsonKey(name: 'cliente_denominacion')  String clienteDenominacion, @JsonKey(name: 'cliente_direccion')  String clienteDireccion, @JsonKey(name: 'cliente_email')  String clienteEmail, @JsonKey(name: 'cliente_email_1')  String clienteEmail1, @JsonKey(name: 'cliente_email_2')  String clienteEmail2, @JsonKey(name: 'fecha_de_emision')  String fechaDeEmision, @JsonKey(name: 'fecha_de_vencimiento')  String fechaDeVencimiento,  String moneda, @JsonKey(name: 'tipo_de_cambio')  String tipoDeCambio, @JsonKey(name: 'porcentaje_de_igv')  String porcentajeDeIgv, @JsonKey(name: 'descuento_global')  String descuentoGlobal, @JsonKey(name: 'total_descuento')  String totalDescuento, @JsonKey(name: 'total_anticipo')  String totalAnticipo, @JsonKey(name: 'total_gravada')  String totalGravada, @JsonKey(name: 'total_inafecta')  String totalInafecta, @JsonKey(name: 'total_exonerada')  String totalExonerada, @JsonKey(name: 'total_igv')  String totalIgv, @JsonKey(name: 'total_gratuita')  String totalGratuita, @JsonKey(name: 'total_otros_cargos')  String totalOtrosCargos,  String total, @JsonKey(name: 'percepcion_tipo')  String percepcionTipo, @JsonKey(name: 'percepcion_base_imponible')  String percepcionBaseImponible, @JsonKey(name: 'total_percepcion')  String totalPercepcion, @JsonKey(name: 'total_incluido_percepcion')  String totalIncluidoPercepcion,  String detraccion,  String observaciones, @JsonKey(name: 'documento_que_se_modifica_tipo')  String documentoQueSeModificaTipo, @JsonKey(name: 'documento_que_se_modifica_serie')  String documentoQueSeModificaSerie, @JsonKey(name: 'documento_que_se_modifica_numero')  String documentoQueSeModificaNumero, @JsonKey(name: 'tipo_de_nota_de_credito')  String tipoDeNotaDeCredito, @JsonKey(name: 'tipo_de_nota_de_debito')  String tipoDeNotaDeDebito, @JsonKey(name: 'enviar_automaticamente_a_la_sunat')  String enviarAutomaticamenteALaSunat, @JsonKey(name: 'enviar_automaticamente_al_cliente')  String enviarAutomaticamenteAlCliente, @JsonKey(name: 'codigo_unico')  String codigoUnico, @JsonKey(name: 'condiciones_de_pago')  String condicionesDePago, @JsonKey(name: 'medio_de_pago')  String medioDePago, @JsonKey(name: 'placa_vehiculo')  String placaVehiculo, @JsonKey(name: 'orden_compra_servicio')  String ordenCompraServicio, @JsonKey(name: 'tabla_personalizada_codigo')  String tablaPersonalizadaCodigo, @JsonKey(name: 'formato_de_pdf')  String formatoDePdf,  List<InvoiceItem> items)  $default,) {final _that = this;
switch (_that) {
case _ElectronicInvoiceRequest():
return $default(_that.operacion,_that.tipoDeComprobante,_that.serie,_that.numero,_that.sunatTransaction,_that.clienteTipoDeDocumento,_that.clienteNumeroDeDocumento,_that.clienteDenominacion,_that.clienteDireccion,_that.clienteEmail,_that.clienteEmail1,_that.clienteEmail2,_that.fechaDeEmision,_that.fechaDeVencimiento,_that.moneda,_that.tipoDeCambio,_that.porcentajeDeIgv,_that.descuentoGlobal,_that.totalDescuento,_that.totalAnticipo,_that.totalGravada,_that.totalInafecta,_that.totalExonerada,_that.totalIgv,_that.totalGratuita,_that.totalOtrosCargos,_that.total,_that.percepcionTipo,_that.percepcionBaseImponible,_that.totalPercepcion,_that.totalIncluidoPercepcion,_that.detraccion,_that.observaciones,_that.documentoQueSeModificaTipo,_that.documentoQueSeModificaSerie,_that.documentoQueSeModificaNumero,_that.tipoDeNotaDeCredito,_that.tipoDeNotaDeDebito,_that.enviarAutomaticamenteALaSunat,_that.enviarAutomaticamenteAlCliente,_that.codigoUnico,_that.condicionesDePago,_that.medioDePago,_that.placaVehiculo,_that.ordenCompraServicio,_that.tablaPersonalizadaCodigo,_that.formatoDePdf,_that.items);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String operacion, @JsonKey(name: 'tipo_de_comprobante')  int tipoDeComprobante,  String serie,  String numero, @JsonKey(name: 'sunat_transaction')  int sunatTransaction, @JsonKey(name: 'cliente_tipo_de_documento')  String clienteTipoDeDocumento, @JsonKey(name: 'cliente_numero_de_documento')  String clienteNumeroDeDocumento, @JsonKey(name: 'cliente_denominacion')  String clienteDenominacion, @JsonKey(name: 'cliente_direccion')  String clienteDireccion, @JsonKey(name: 'cliente_email')  String clienteEmail, @JsonKey(name: 'cliente_email_1')  String clienteEmail1, @JsonKey(name: 'cliente_email_2')  String clienteEmail2, @JsonKey(name: 'fecha_de_emision')  String fechaDeEmision, @JsonKey(name: 'fecha_de_vencimiento')  String fechaDeVencimiento,  String moneda, @JsonKey(name: 'tipo_de_cambio')  String tipoDeCambio, @JsonKey(name: 'porcentaje_de_igv')  String porcentajeDeIgv, @JsonKey(name: 'descuento_global')  String descuentoGlobal, @JsonKey(name: 'total_descuento')  String totalDescuento, @JsonKey(name: 'total_anticipo')  String totalAnticipo, @JsonKey(name: 'total_gravada')  String totalGravada, @JsonKey(name: 'total_inafecta')  String totalInafecta, @JsonKey(name: 'total_exonerada')  String totalExonerada, @JsonKey(name: 'total_igv')  String totalIgv, @JsonKey(name: 'total_gratuita')  String totalGratuita, @JsonKey(name: 'total_otros_cargos')  String totalOtrosCargos,  String total, @JsonKey(name: 'percepcion_tipo')  String percepcionTipo, @JsonKey(name: 'percepcion_base_imponible')  String percepcionBaseImponible, @JsonKey(name: 'total_percepcion')  String totalPercepcion, @JsonKey(name: 'total_incluido_percepcion')  String totalIncluidoPercepcion,  String detraccion,  String observaciones, @JsonKey(name: 'documento_que_se_modifica_tipo')  String documentoQueSeModificaTipo, @JsonKey(name: 'documento_que_se_modifica_serie')  String documentoQueSeModificaSerie, @JsonKey(name: 'documento_que_se_modifica_numero')  String documentoQueSeModificaNumero, @JsonKey(name: 'tipo_de_nota_de_credito')  String tipoDeNotaDeCredito, @JsonKey(name: 'tipo_de_nota_de_debito')  String tipoDeNotaDeDebito, @JsonKey(name: 'enviar_automaticamente_a_la_sunat')  String enviarAutomaticamenteALaSunat, @JsonKey(name: 'enviar_automaticamente_al_cliente')  String enviarAutomaticamenteAlCliente, @JsonKey(name: 'codigo_unico')  String codigoUnico, @JsonKey(name: 'condiciones_de_pago')  String condicionesDePago, @JsonKey(name: 'medio_de_pago')  String medioDePago, @JsonKey(name: 'placa_vehiculo')  String placaVehiculo, @JsonKey(name: 'orden_compra_servicio')  String ordenCompraServicio, @JsonKey(name: 'tabla_personalizada_codigo')  String tablaPersonalizadaCodigo, @JsonKey(name: 'formato_de_pdf')  String formatoDePdf,  List<InvoiceItem> items)?  $default,) {final _that = this;
switch (_that) {
case _ElectronicInvoiceRequest() when $default != null:
return $default(_that.operacion,_that.tipoDeComprobante,_that.serie,_that.numero,_that.sunatTransaction,_that.clienteTipoDeDocumento,_that.clienteNumeroDeDocumento,_that.clienteDenominacion,_that.clienteDireccion,_that.clienteEmail,_that.clienteEmail1,_that.clienteEmail2,_that.fechaDeEmision,_that.fechaDeVencimiento,_that.moneda,_that.tipoDeCambio,_that.porcentajeDeIgv,_that.descuentoGlobal,_that.totalDescuento,_that.totalAnticipo,_that.totalGravada,_that.totalInafecta,_that.totalExonerada,_that.totalIgv,_that.totalGratuita,_that.totalOtrosCargos,_that.total,_that.percepcionTipo,_that.percepcionBaseImponible,_that.totalPercepcion,_that.totalIncluidoPercepcion,_that.detraccion,_that.observaciones,_that.documentoQueSeModificaTipo,_that.documentoQueSeModificaSerie,_that.documentoQueSeModificaNumero,_that.tipoDeNotaDeCredito,_that.tipoDeNotaDeDebito,_that.enviarAutomaticamenteALaSunat,_that.enviarAutomaticamenteAlCliente,_that.codigoUnico,_that.condicionesDePago,_that.medioDePago,_that.placaVehiculo,_that.ordenCompraServicio,_that.tablaPersonalizadaCodigo,_that.formatoDePdf,_that.items);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ElectronicInvoiceRequest extends ElectronicInvoiceRequest {
  const _ElectronicInvoiceRequest({this.operacion = 'generar_comprobante', @JsonKey(name: 'tipo_de_comprobante') required this.tipoDeComprobante, required this.serie, required this.numero, @JsonKey(name: 'sunat_transaction') this.sunatTransaction = 1, @JsonKey(name: 'cliente_tipo_de_documento') required this.clienteTipoDeDocumento, @JsonKey(name: 'cliente_numero_de_documento') required this.clienteNumeroDeDocumento, @JsonKey(name: 'cliente_denominacion') required this.clienteDenominacion, @JsonKey(name: 'cliente_direccion') required this.clienteDireccion, @JsonKey(name: 'cliente_email') this.clienteEmail = '', @JsonKey(name: 'cliente_email_1') this.clienteEmail1 = '', @JsonKey(name: 'cliente_email_2') this.clienteEmail2 = '', @JsonKey(name: 'fecha_de_emision') required this.fechaDeEmision, @JsonKey(name: 'fecha_de_vencimiento') this.fechaDeVencimiento = '', this.moneda = '1', @JsonKey(name: 'tipo_de_cambio') this.tipoDeCambio = '', @JsonKey(name: 'porcentaje_de_igv') this.porcentajeDeIgv = '18.00', @JsonKey(name: 'descuento_global') this.descuentoGlobal = '', @JsonKey(name: 'total_descuento') this.totalDescuento = '', @JsonKey(name: 'total_anticipo') this.totalAnticipo = '', @JsonKey(name: 'total_gravada') required this.totalGravada, @JsonKey(name: 'total_inafecta') this.totalInafecta = '', @JsonKey(name: 'total_exonerada') this.totalExonerada = '', @JsonKey(name: 'total_igv') required this.totalIgv, @JsonKey(name: 'total_gratuita') this.totalGratuita = '', @JsonKey(name: 'total_otros_cargos') this.totalOtrosCargos = '', required this.total, @JsonKey(name: 'percepcion_tipo') this.percepcionTipo = '', @JsonKey(name: 'percepcion_base_imponible') this.percepcionBaseImponible = '', @JsonKey(name: 'total_percepcion') this.totalPercepcion = '', @JsonKey(name: 'total_incluido_percepcion') this.totalIncluidoPercepcion = '', this.detraccion = 'false', this.observaciones = '', @JsonKey(name: 'documento_que_se_modifica_tipo') this.documentoQueSeModificaTipo = '', @JsonKey(name: 'documento_que_se_modifica_serie') this.documentoQueSeModificaSerie = '', @JsonKey(name: 'documento_que_se_modifica_numero') this.documentoQueSeModificaNumero = '', @JsonKey(name: 'tipo_de_nota_de_credito') this.tipoDeNotaDeCredito = '', @JsonKey(name: 'tipo_de_nota_de_debito') this.tipoDeNotaDeDebito = '', @JsonKey(name: 'enviar_automaticamente_a_la_sunat') this.enviarAutomaticamenteALaSunat = 'true', @JsonKey(name: 'enviar_automaticamente_al_cliente') this.enviarAutomaticamenteAlCliente = 'false', @JsonKey(name: 'codigo_unico') this.codigoUnico = '', @JsonKey(name: 'condiciones_de_pago') this.condicionesDePago = '', @JsonKey(name: 'medio_de_pago') this.medioDePago = '', @JsonKey(name: 'placa_vehiculo') this.placaVehiculo = '', @JsonKey(name: 'orden_compra_servicio') this.ordenCompraServicio = '', @JsonKey(name: 'tabla_personalizada_codigo') this.tablaPersonalizadaCodigo = '', @JsonKey(name: 'formato_de_pdf') this.formatoDePdf = '', required final  List<InvoiceItem> items}): _items = items,super._();
  factory _ElectronicInvoiceRequest.fromJson(Map<String, dynamic> json) => _$ElectronicInvoiceRequestFromJson(json);

/// Operación a realizar (siempre "generar_comprobante")
@override@JsonKey() final  String operacion;
/// Tipo de comprobante: 1 = FACTURA, 2 = BOLETA, 3 = NOTA CRÉDITO, 4 = NOTA DÉBITO
@override@JsonKey(name: 'tipo_de_comprobante') final  int tipoDeComprobante;
/// Serie del comprobante (F para facturas, B para boletas)
@override final  String serie;
/// Número correlativo del documento
@override final  String numero;
/// Tipo de transacción SUNAT (1 = VENTA INTERNA)
@override@JsonKey(name: 'sunat_transaction') final  int sunatTransaction;
/// Tipo de documento del cliente: 6 = RUC, 1 = DNI, - = VARIOS
@override@JsonKey(name: 'cliente_tipo_de_documento') final  String clienteTipoDeDocumento;
/// Número de documento del cliente
@override@JsonKey(name: 'cliente_numero_de_documento') final  String clienteNumeroDeDocumento;
/// Razón social o nombre completo del cliente
@override@JsonKey(name: 'cliente_denominacion') final  String clienteDenominacion;
/// Dirección del cliente
@override@JsonKey(name: 'cliente_direccion') final  String clienteDireccion;
/// Email principal del cliente
@override@JsonKey(name: 'cliente_email') final  String clienteEmail;
/// Email secundario 1
@override@JsonKey(name: 'cliente_email_1') final  String clienteEmail1;
/// Email secundario 2
@override@JsonKey(name: 'cliente_email_2') final  String clienteEmail2;
/// Fecha de emisión (formato DD-MM-AAAA)
@override@JsonKey(name: 'fecha_de_emision') final  String fechaDeEmision;
/// Fecha de vencimiento (formato DD-MM-AAAA)
@override@JsonKey(name: 'fecha_de_vencimiento') final  String fechaDeVencimiento;
/// Moneda: 1 = SOLES, 2 = DÓLARES, 3 = EUROS
@override@JsonKey() final  String moneda;
/// Tipo de cambio (solo si moneda != soles)
@override@JsonKey(name: 'tipo_de_cambio') final  String tipoDeCambio;
/// Porcentaje de IGV (18.00 en Perú)
@override@JsonKey(name: 'porcentaje_de_igv') final  String porcentajeDeIgv;
/// Descuento global aplicado
@override@JsonKey(name: 'descuento_global') final  String descuentoGlobal;
/// Total de descuentos
@override@JsonKey(name: 'total_descuento') final  String totalDescuento;
/// Total de anticipos
@override@JsonKey(name: 'total_anticipo') final  String totalAnticipo;
/// Total gravado (base imponible)
@override@JsonKey(name: 'total_gravada') final  String totalGravada;
/// Total inafecto
@override@JsonKey(name: 'total_inafecta') final  String totalInafecta;
/// Total exonerado
@override@JsonKey(name: 'total_exonerada') final  String totalExonerada;
/// Total IGV
@override@JsonKey(name: 'total_igv') final  String totalIgv;
/// Total gratuito
@override@JsonKey(name: 'total_gratuita') final  String totalGratuita;
/// Total otros cargos
@override@JsonKey(name: 'total_otros_cargos') final  String totalOtrosCargos;
/// Total del comprobante
@override final  String total;
/// Tipo de percepción
@override@JsonKey(name: 'percepcion_tipo') final  String percepcionTipo;
/// Base imponible de percepción
@override@JsonKey(name: 'percepcion_base_imponible') final  String percepcionBaseImponible;
/// Total de percepción
@override@JsonKey(name: 'total_percepcion') final  String totalPercepcion;
/// Total incluido percepción
@override@JsonKey(name: 'total_incluido_percepcion') final  String totalIncluidoPercepcion;
/// Indica si tiene detracción
@override@JsonKey() final  String detraccion;
/// Observaciones del comprobante
@override@JsonKey() final  String observaciones;
/// Tipo de documento que se modifica (para notas)
@override@JsonKey(name: 'documento_que_se_modifica_tipo') final  String documentoQueSeModificaTipo;
/// Serie del documento que se modifica
@override@JsonKey(name: 'documento_que_se_modifica_serie') final  String documentoQueSeModificaSerie;
/// Número del documento que se modifica
@override@JsonKey(name: 'documento_que_se_modifica_numero') final  String documentoQueSeModificaNumero;
/// Tipo de nota de crédito
@override@JsonKey(name: 'tipo_de_nota_de_credito') final  String tipoDeNotaDeCredito;
/// Tipo de nota de débito
@override@JsonKey(name: 'tipo_de_nota_de_debito') final  String tipoDeNotaDeDebito;
/// Enviar automáticamente a SUNAT
@override@JsonKey(name: 'enviar_automaticamente_a_la_sunat') final  String enviarAutomaticamenteALaSunat;
/// Enviar automáticamente al cliente
@override@JsonKey(name: 'enviar_automaticamente_al_cliente') final  String enviarAutomaticamenteAlCliente;
/// Código único generado por el sistema
@override@JsonKey(name: 'codigo_unico') final  String codigoUnico;
/// Condiciones de pago
@override@JsonKey(name: 'condiciones_de_pago') final  String condicionesDePago;
/// Medio de pago
@override@JsonKey(name: 'medio_de_pago') final  String medioDePago;
/// Placa del vehículo
@override@JsonKey(name: 'placa_vehiculo') final  String placaVehiculo;
/// Orden de compra o servicio
@override@JsonKey(name: 'orden_compra_servicio') final  String ordenCompraServicio;
/// Código de tabla personalizada
@override@JsonKey(name: 'tabla_personalizada_codigo') final  String tablaPersonalizadaCodigo;
/// Formato de PDF (A4, A5, TICKET)
@override@JsonKey(name: 'formato_de_pdf') final  String formatoDePdf;
/// Items del comprobante
 final  List<InvoiceItem> _items;
/// Items del comprobante
@override List<InvoiceItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}


/// Create a copy of ElectronicInvoiceRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElectronicInvoiceRequestCopyWith<_ElectronicInvoiceRequest> get copyWith => __$ElectronicInvoiceRequestCopyWithImpl<_ElectronicInvoiceRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElectronicInvoiceRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElectronicInvoiceRequest&&(identical(other.operacion, operacion) || other.operacion == operacion)&&(identical(other.tipoDeComprobante, tipoDeComprobante) || other.tipoDeComprobante == tipoDeComprobante)&&(identical(other.serie, serie) || other.serie == serie)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.sunatTransaction, sunatTransaction) || other.sunatTransaction == sunatTransaction)&&(identical(other.clienteTipoDeDocumento, clienteTipoDeDocumento) || other.clienteTipoDeDocumento == clienteTipoDeDocumento)&&(identical(other.clienteNumeroDeDocumento, clienteNumeroDeDocumento) || other.clienteNumeroDeDocumento == clienteNumeroDeDocumento)&&(identical(other.clienteDenominacion, clienteDenominacion) || other.clienteDenominacion == clienteDenominacion)&&(identical(other.clienteDireccion, clienteDireccion) || other.clienteDireccion == clienteDireccion)&&(identical(other.clienteEmail, clienteEmail) || other.clienteEmail == clienteEmail)&&(identical(other.clienteEmail1, clienteEmail1) || other.clienteEmail1 == clienteEmail1)&&(identical(other.clienteEmail2, clienteEmail2) || other.clienteEmail2 == clienteEmail2)&&(identical(other.fechaDeEmision, fechaDeEmision) || other.fechaDeEmision == fechaDeEmision)&&(identical(other.fechaDeVencimiento, fechaDeVencimiento) || other.fechaDeVencimiento == fechaDeVencimiento)&&(identical(other.moneda, moneda) || other.moneda == moneda)&&(identical(other.tipoDeCambio, tipoDeCambio) || other.tipoDeCambio == tipoDeCambio)&&(identical(other.porcentajeDeIgv, porcentajeDeIgv) || other.porcentajeDeIgv == porcentajeDeIgv)&&(identical(other.descuentoGlobal, descuentoGlobal) || other.descuentoGlobal == descuentoGlobal)&&(identical(other.totalDescuento, totalDescuento) || other.totalDescuento == totalDescuento)&&(identical(other.totalAnticipo, totalAnticipo) || other.totalAnticipo == totalAnticipo)&&(identical(other.totalGravada, totalGravada) || other.totalGravada == totalGravada)&&(identical(other.totalInafecta, totalInafecta) || other.totalInafecta == totalInafecta)&&(identical(other.totalExonerada, totalExonerada) || other.totalExonerada == totalExonerada)&&(identical(other.totalIgv, totalIgv) || other.totalIgv == totalIgv)&&(identical(other.totalGratuita, totalGratuita) || other.totalGratuita == totalGratuita)&&(identical(other.totalOtrosCargos, totalOtrosCargos) || other.totalOtrosCargos == totalOtrosCargos)&&(identical(other.total, total) || other.total == total)&&(identical(other.percepcionTipo, percepcionTipo) || other.percepcionTipo == percepcionTipo)&&(identical(other.percepcionBaseImponible, percepcionBaseImponible) || other.percepcionBaseImponible == percepcionBaseImponible)&&(identical(other.totalPercepcion, totalPercepcion) || other.totalPercepcion == totalPercepcion)&&(identical(other.totalIncluidoPercepcion, totalIncluidoPercepcion) || other.totalIncluidoPercepcion == totalIncluidoPercepcion)&&(identical(other.detraccion, detraccion) || other.detraccion == detraccion)&&(identical(other.observaciones, observaciones) || other.observaciones == observaciones)&&(identical(other.documentoQueSeModificaTipo, documentoQueSeModificaTipo) || other.documentoQueSeModificaTipo == documentoQueSeModificaTipo)&&(identical(other.documentoQueSeModificaSerie, documentoQueSeModificaSerie) || other.documentoQueSeModificaSerie == documentoQueSeModificaSerie)&&(identical(other.documentoQueSeModificaNumero, documentoQueSeModificaNumero) || other.documentoQueSeModificaNumero == documentoQueSeModificaNumero)&&(identical(other.tipoDeNotaDeCredito, tipoDeNotaDeCredito) || other.tipoDeNotaDeCredito == tipoDeNotaDeCredito)&&(identical(other.tipoDeNotaDeDebito, tipoDeNotaDeDebito) || other.tipoDeNotaDeDebito == tipoDeNotaDeDebito)&&(identical(other.enviarAutomaticamenteALaSunat, enviarAutomaticamenteALaSunat) || other.enviarAutomaticamenteALaSunat == enviarAutomaticamenteALaSunat)&&(identical(other.enviarAutomaticamenteAlCliente, enviarAutomaticamenteAlCliente) || other.enviarAutomaticamenteAlCliente == enviarAutomaticamenteAlCliente)&&(identical(other.codigoUnico, codigoUnico) || other.codigoUnico == codigoUnico)&&(identical(other.condicionesDePago, condicionesDePago) || other.condicionesDePago == condicionesDePago)&&(identical(other.medioDePago, medioDePago) || other.medioDePago == medioDePago)&&(identical(other.placaVehiculo, placaVehiculo) || other.placaVehiculo == placaVehiculo)&&(identical(other.ordenCompraServicio, ordenCompraServicio) || other.ordenCompraServicio == ordenCompraServicio)&&(identical(other.tablaPersonalizadaCodigo, tablaPersonalizadaCodigo) || other.tablaPersonalizadaCodigo == tablaPersonalizadaCodigo)&&(identical(other.formatoDePdf, formatoDePdf) || other.formatoDePdf == formatoDePdf)&&const DeepCollectionEquality().equals(other._items, _items));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,operacion,tipoDeComprobante,serie,numero,sunatTransaction,clienteTipoDeDocumento,clienteNumeroDeDocumento,clienteDenominacion,clienteDireccion,clienteEmail,clienteEmail1,clienteEmail2,fechaDeEmision,fechaDeVencimiento,moneda,tipoDeCambio,porcentajeDeIgv,descuentoGlobal,totalDescuento,totalAnticipo,totalGravada,totalInafecta,totalExonerada,totalIgv,totalGratuita,totalOtrosCargos,total,percepcionTipo,percepcionBaseImponible,totalPercepcion,totalIncluidoPercepcion,detraccion,observaciones,documentoQueSeModificaTipo,documentoQueSeModificaSerie,documentoQueSeModificaNumero,tipoDeNotaDeCredito,tipoDeNotaDeDebito,enviarAutomaticamenteALaSunat,enviarAutomaticamenteAlCliente,codigoUnico,condicionesDePago,medioDePago,placaVehiculo,ordenCompraServicio,tablaPersonalizadaCodigo,formatoDePdf,const DeepCollectionEquality().hash(_items)]);

@override
String toString() {
  return 'ElectronicInvoiceRequest(operacion: $operacion, tipoDeComprobante: $tipoDeComprobante, serie: $serie, numero: $numero, sunatTransaction: $sunatTransaction, clienteTipoDeDocumento: $clienteTipoDeDocumento, clienteNumeroDeDocumento: $clienteNumeroDeDocumento, clienteDenominacion: $clienteDenominacion, clienteDireccion: $clienteDireccion, clienteEmail: $clienteEmail, clienteEmail1: $clienteEmail1, clienteEmail2: $clienteEmail2, fechaDeEmision: $fechaDeEmision, fechaDeVencimiento: $fechaDeVencimiento, moneda: $moneda, tipoDeCambio: $tipoDeCambio, porcentajeDeIgv: $porcentajeDeIgv, descuentoGlobal: $descuentoGlobal, totalDescuento: $totalDescuento, totalAnticipo: $totalAnticipo, totalGravada: $totalGravada, totalInafecta: $totalInafecta, totalExonerada: $totalExonerada, totalIgv: $totalIgv, totalGratuita: $totalGratuita, totalOtrosCargos: $totalOtrosCargos, total: $total, percepcionTipo: $percepcionTipo, percepcionBaseImponible: $percepcionBaseImponible, totalPercepcion: $totalPercepcion, totalIncluidoPercepcion: $totalIncluidoPercepcion, detraccion: $detraccion, observaciones: $observaciones, documentoQueSeModificaTipo: $documentoQueSeModificaTipo, documentoQueSeModificaSerie: $documentoQueSeModificaSerie, documentoQueSeModificaNumero: $documentoQueSeModificaNumero, tipoDeNotaDeCredito: $tipoDeNotaDeCredito, tipoDeNotaDeDebito: $tipoDeNotaDeDebito, enviarAutomaticamenteALaSunat: $enviarAutomaticamenteALaSunat, enviarAutomaticamenteAlCliente: $enviarAutomaticamenteAlCliente, codigoUnico: $codigoUnico, condicionesDePago: $condicionesDePago, medioDePago: $medioDePago, placaVehiculo: $placaVehiculo, ordenCompraServicio: $ordenCompraServicio, tablaPersonalizadaCodigo: $tablaPersonalizadaCodigo, formatoDePdf: $formatoDePdf, items: $items)';
}


}

/// @nodoc
abstract mixin class _$ElectronicInvoiceRequestCopyWith<$Res> implements $ElectronicInvoiceRequestCopyWith<$Res> {
  factory _$ElectronicInvoiceRequestCopyWith(_ElectronicInvoiceRequest value, $Res Function(_ElectronicInvoiceRequest) _then) = __$ElectronicInvoiceRequestCopyWithImpl;
@override @useResult
$Res call({
 String operacion,@JsonKey(name: 'tipo_de_comprobante') int tipoDeComprobante, String serie, String numero,@JsonKey(name: 'sunat_transaction') int sunatTransaction,@JsonKey(name: 'cliente_tipo_de_documento') String clienteTipoDeDocumento,@JsonKey(name: 'cliente_numero_de_documento') String clienteNumeroDeDocumento,@JsonKey(name: 'cliente_denominacion') String clienteDenominacion,@JsonKey(name: 'cliente_direccion') String clienteDireccion,@JsonKey(name: 'cliente_email') String clienteEmail,@JsonKey(name: 'cliente_email_1') String clienteEmail1,@JsonKey(name: 'cliente_email_2') String clienteEmail2,@JsonKey(name: 'fecha_de_emision') String fechaDeEmision,@JsonKey(name: 'fecha_de_vencimiento') String fechaDeVencimiento, String moneda,@JsonKey(name: 'tipo_de_cambio') String tipoDeCambio,@JsonKey(name: 'porcentaje_de_igv') String porcentajeDeIgv,@JsonKey(name: 'descuento_global') String descuentoGlobal,@JsonKey(name: 'total_descuento') String totalDescuento,@JsonKey(name: 'total_anticipo') String totalAnticipo,@JsonKey(name: 'total_gravada') String totalGravada,@JsonKey(name: 'total_inafecta') String totalInafecta,@JsonKey(name: 'total_exonerada') String totalExonerada,@JsonKey(name: 'total_igv') String totalIgv,@JsonKey(name: 'total_gratuita') String totalGratuita,@JsonKey(name: 'total_otros_cargos') String totalOtrosCargos, String total,@JsonKey(name: 'percepcion_tipo') String percepcionTipo,@JsonKey(name: 'percepcion_base_imponible') String percepcionBaseImponible,@JsonKey(name: 'total_percepcion') String totalPercepcion,@JsonKey(name: 'total_incluido_percepcion') String totalIncluidoPercepcion, String detraccion, String observaciones,@JsonKey(name: 'documento_que_se_modifica_tipo') String documentoQueSeModificaTipo,@JsonKey(name: 'documento_que_se_modifica_serie') String documentoQueSeModificaSerie,@JsonKey(name: 'documento_que_se_modifica_numero') String documentoQueSeModificaNumero,@JsonKey(name: 'tipo_de_nota_de_credito') String tipoDeNotaDeCredito,@JsonKey(name: 'tipo_de_nota_de_debito') String tipoDeNotaDeDebito,@JsonKey(name: 'enviar_automaticamente_a_la_sunat') String enviarAutomaticamenteALaSunat,@JsonKey(name: 'enviar_automaticamente_al_cliente') String enviarAutomaticamenteAlCliente,@JsonKey(name: 'codigo_unico') String codigoUnico,@JsonKey(name: 'condiciones_de_pago') String condicionesDePago,@JsonKey(name: 'medio_de_pago') String medioDePago,@JsonKey(name: 'placa_vehiculo') String placaVehiculo,@JsonKey(name: 'orden_compra_servicio') String ordenCompraServicio,@JsonKey(name: 'tabla_personalizada_codigo') String tablaPersonalizadaCodigo,@JsonKey(name: 'formato_de_pdf') String formatoDePdf, List<InvoiceItem> items
});




}
/// @nodoc
class __$ElectronicInvoiceRequestCopyWithImpl<$Res>
    implements _$ElectronicInvoiceRequestCopyWith<$Res> {
  __$ElectronicInvoiceRequestCopyWithImpl(this._self, this._then);

  final _ElectronicInvoiceRequest _self;
  final $Res Function(_ElectronicInvoiceRequest) _then;

/// Create a copy of ElectronicInvoiceRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? operacion = null,Object? tipoDeComprobante = null,Object? serie = null,Object? numero = null,Object? sunatTransaction = null,Object? clienteTipoDeDocumento = null,Object? clienteNumeroDeDocumento = null,Object? clienteDenominacion = null,Object? clienteDireccion = null,Object? clienteEmail = null,Object? clienteEmail1 = null,Object? clienteEmail2 = null,Object? fechaDeEmision = null,Object? fechaDeVencimiento = null,Object? moneda = null,Object? tipoDeCambio = null,Object? porcentajeDeIgv = null,Object? descuentoGlobal = null,Object? totalDescuento = null,Object? totalAnticipo = null,Object? totalGravada = null,Object? totalInafecta = null,Object? totalExonerada = null,Object? totalIgv = null,Object? totalGratuita = null,Object? totalOtrosCargos = null,Object? total = null,Object? percepcionTipo = null,Object? percepcionBaseImponible = null,Object? totalPercepcion = null,Object? totalIncluidoPercepcion = null,Object? detraccion = null,Object? observaciones = null,Object? documentoQueSeModificaTipo = null,Object? documentoQueSeModificaSerie = null,Object? documentoQueSeModificaNumero = null,Object? tipoDeNotaDeCredito = null,Object? tipoDeNotaDeDebito = null,Object? enviarAutomaticamenteALaSunat = null,Object? enviarAutomaticamenteAlCliente = null,Object? codigoUnico = null,Object? condicionesDePago = null,Object? medioDePago = null,Object? placaVehiculo = null,Object? ordenCompraServicio = null,Object? tablaPersonalizadaCodigo = null,Object? formatoDePdf = null,Object? items = null,}) {
  return _then(_ElectronicInvoiceRequest(
operacion: null == operacion ? _self.operacion : operacion // ignore: cast_nullable_to_non_nullable
as String,tipoDeComprobante: null == tipoDeComprobante ? _self.tipoDeComprobante : tipoDeComprobante // ignore: cast_nullable_to_non_nullable
as int,serie: null == serie ? _self.serie : serie // ignore: cast_nullable_to_non_nullable
as String,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as String,sunatTransaction: null == sunatTransaction ? _self.sunatTransaction : sunatTransaction // ignore: cast_nullable_to_non_nullable
as int,clienteTipoDeDocumento: null == clienteTipoDeDocumento ? _self.clienteTipoDeDocumento : clienteTipoDeDocumento // ignore: cast_nullable_to_non_nullable
as String,clienteNumeroDeDocumento: null == clienteNumeroDeDocumento ? _self.clienteNumeroDeDocumento : clienteNumeroDeDocumento // ignore: cast_nullable_to_non_nullable
as String,clienteDenominacion: null == clienteDenominacion ? _self.clienteDenominacion : clienteDenominacion // ignore: cast_nullable_to_non_nullable
as String,clienteDireccion: null == clienteDireccion ? _self.clienteDireccion : clienteDireccion // ignore: cast_nullable_to_non_nullable
as String,clienteEmail: null == clienteEmail ? _self.clienteEmail : clienteEmail // ignore: cast_nullable_to_non_nullable
as String,clienteEmail1: null == clienteEmail1 ? _self.clienteEmail1 : clienteEmail1 // ignore: cast_nullable_to_non_nullable
as String,clienteEmail2: null == clienteEmail2 ? _self.clienteEmail2 : clienteEmail2 // ignore: cast_nullable_to_non_nullable
as String,fechaDeEmision: null == fechaDeEmision ? _self.fechaDeEmision : fechaDeEmision // ignore: cast_nullable_to_non_nullable
as String,fechaDeVencimiento: null == fechaDeVencimiento ? _self.fechaDeVencimiento : fechaDeVencimiento // ignore: cast_nullable_to_non_nullable
as String,moneda: null == moneda ? _self.moneda : moneda // ignore: cast_nullable_to_non_nullable
as String,tipoDeCambio: null == tipoDeCambio ? _self.tipoDeCambio : tipoDeCambio // ignore: cast_nullable_to_non_nullable
as String,porcentajeDeIgv: null == porcentajeDeIgv ? _self.porcentajeDeIgv : porcentajeDeIgv // ignore: cast_nullable_to_non_nullable
as String,descuentoGlobal: null == descuentoGlobal ? _self.descuentoGlobal : descuentoGlobal // ignore: cast_nullable_to_non_nullable
as String,totalDescuento: null == totalDescuento ? _self.totalDescuento : totalDescuento // ignore: cast_nullable_to_non_nullable
as String,totalAnticipo: null == totalAnticipo ? _self.totalAnticipo : totalAnticipo // ignore: cast_nullable_to_non_nullable
as String,totalGravada: null == totalGravada ? _self.totalGravada : totalGravada // ignore: cast_nullable_to_non_nullable
as String,totalInafecta: null == totalInafecta ? _self.totalInafecta : totalInafecta // ignore: cast_nullable_to_non_nullable
as String,totalExonerada: null == totalExonerada ? _self.totalExonerada : totalExonerada // ignore: cast_nullable_to_non_nullable
as String,totalIgv: null == totalIgv ? _self.totalIgv : totalIgv // ignore: cast_nullable_to_non_nullable
as String,totalGratuita: null == totalGratuita ? _self.totalGratuita : totalGratuita // ignore: cast_nullable_to_non_nullable
as String,totalOtrosCargos: null == totalOtrosCargos ? _self.totalOtrosCargos : totalOtrosCargos // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as String,percepcionTipo: null == percepcionTipo ? _self.percepcionTipo : percepcionTipo // ignore: cast_nullable_to_non_nullable
as String,percepcionBaseImponible: null == percepcionBaseImponible ? _self.percepcionBaseImponible : percepcionBaseImponible // ignore: cast_nullable_to_non_nullable
as String,totalPercepcion: null == totalPercepcion ? _self.totalPercepcion : totalPercepcion // ignore: cast_nullable_to_non_nullable
as String,totalIncluidoPercepcion: null == totalIncluidoPercepcion ? _self.totalIncluidoPercepcion : totalIncluidoPercepcion // ignore: cast_nullable_to_non_nullable
as String,detraccion: null == detraccion ? _self.detraccion : detraccion // ignore: cast_nullable_to_non_nullable
as String,observaciones: null == observaciones ? _self.observaciones : observaciones // ignore: cast_nullable_to_non_nullable
as String,documentoQueSeModificaTipo: null == documentoQueSeModificaTipo ? _self.documentoQueSeModificaTipo : documentoQueSeModificaTipo // ignore: cast_nullable_to_non_nullable
as String,documentoQueSeModificaSerie: null == documentoQueSeModificaSerie ? _self.documentoQueSeModificaSerie : documentoQueSeModificaSerie // ignore: cast_nullable_to_non_nullable
as String,documentoQueSeModificaNumero: null == documentoQueSeModificaNumero ? _self.documentoQueSeModificaNumero : documentoQueSeModificaNumero // ignore: cast_nullable_to_non_nullable
as String,tipoDeNotaDeCredito: null == tipoDeNotaDeCredito ? _self.tipoDeNotaDeCredito : tipoDeNotaDeCredito // ignore: cast_nullable_to_non_nullable
as String,tipoDeNotaDeDebito: null == tipoDeNotaDeDebito ? _self.tipoDeNotaDeDebito : tipoDeNotaDeDebito // ignore: cast_nullable_to_non_nullable
as String,enviarAutomaticamenteALaSunat: null == enviarAutomaticamenteALaSunat ? _self.enviarAutomaticamenteALaSunat : enviarAutomaticamenteALaSunat // ignore: cast_nullable_to_non_nullable
as String,enviarAutomaticamenteAlCliente: null == enviarAutomaticamenteAlCliente ? _self.enviarAutomaticamenteAlCliente : enviarAutomaticamenteAlCliente // ignore: cast_nullable_to_non_nullable
as String,codigoUnico: null == codigoUnico ? _self.codigoUnico : codigoUnico // ignore: cast_nullable_to_non_nullable
as String,condicionesDePago: null == condicionesDePago ? _self.condicionesDePago : condicionesDePago // ignore: cast_nullable_to_non_nullable
as String,medioDePago: null == medioDePago ? _self.medioDePago : medioDePago // ignore: cast_nullable_to_non_nullable
as String,placaVehiculo: null == placaVehiculo ? _self.placaVehiculo : placaVehiculo // ignore: cast_nullable_to_non_nullable
as String,ordenCompraServicio: null == ordenCompraServicio ? _self.ordenCompraServicio : ordenCompraServicio // ignore: cast_nullable_to_non_nullable
as String,tablaPersonalizadaCodigo: null == tablaPersonalizadaCodigo ? _self.tablaPersonalizadaCodigo : tablaPersonalizadaCodigo // ignore: cast_nullable_to_non_nullable
as String,formatoDePdf: null == formatoDePdf ? _self.formatoDePdf : formatoDePdf // ignore: cast_nullable_to_non_nullable
as String,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<InvoiceItem>,
  ));
}


}

// dart format on
