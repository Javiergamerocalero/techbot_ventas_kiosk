// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'electronic_invoice_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ElectronicInvoiceResponse {

/// Tipo de comprobante generado
@JsonKey(name: 'tipo_de_comprobante') int get tipoDeComprobante;/// Serie del comprobante
 String get serie;/// Número del comprobante
 int get numero;/// Enlace al comprobante en la plataforma
 String get enlace;/// Enlace al PDF del comprobante
@JsonKey(name: 'enlace_del_pdf') String get enlaceDelPdf;/// Enlace al XML del comprobante
@JsonKey(name: 'enlace_del_xml') String get enlaceDelXml;/// Enlace al CDR (Constancia de Recepción)
@JsonKey(name: 'enlace_del_cdr') String get enlaceDelCdr;/// Indica si fue aceptada por SUNAT
@JsonKey(name: 'aceptada_por_sunat') bool get aceptadaPorSunat;/// Descripción de SUNAT
@JsonKey(name: 'sunat_description') String get sunatDescription;/// Nota de SUNAT (puede ser null)
@JsonKey(name: 'sunat_note') String? get sunatNote;/// Código de respuesta de SUNAT
@JsonKey(name: 'sunat_responsecode') String get sunatResponsecode;/// Error SOAP de SUNAT (vacío si no hay error)
@JsonKey(name: 'sunat_soap_error') String get sunatSoapError;/// Cadena para generar código QR
@JsonKey(name: 'cadena_para_codigo_qr') String get cadenaParaCodigoQr;/// Hash del comprobante
@JsonKey(name: 'codigo_hash') String get codigoHash;
/// Create a copy of ElectronicInvoiceResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ElectronicInvoiceResponseCopyWith<ElectronicInvoiceResponse> get copyWith => _$ElectronicInvoiceResponseCopyWithImpl<ElectronicInvoiceResponse>(this as ElectronicInvoiceResponse, _$identity);

  /// Serializes this ElectronicInvoiceResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ElectronicInvoiceResponse&&(identical(other.tipoDeComprobante, tipoDeComprobante) || other.tipoDeComprobante == tipoDeComprobante)&&(identical(other.serie, serie) || other.serie == serie)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.enlace, enlace) || other.enlace == enlace)&&(identical(other.enlaceDelPdf, enlaceDelPdf) || other.enlaceDelPdf == enlaceDelPdf)&&(identical(other.enlaceDelXml, enlaceDelXml) || other.enlaceDelXml == enlaceDelXml)&&(identical(other.enlaceDelCdr, enlaceDelCdr) || other.enlaceDelCdr == enlaceDelCdr)&&(identical(other.aceptadaPorSunat, aceptadaPorSunat) || other.aceptadaPorSunat == aceptadaPorSunat)&&(identical(other.sunatDescription, sunatDescription) || other.sunatDescription == sunatDescription)&&(identical(other.sunatNote, sunatNote) || other.sunatNote == sunatNote)&&(identical(other.sunatResponsecode, sunatResponsecode) || other.sunatResponsecode == sunatResponsecode)&&(identical(other.sunatSoapError, sunatSoapError) || other.sunatSoapError == sunatSoapError)&&(identical(other.cadenaParaCodigoQr, cadenaParaCodigoQr) || other.cadenaParaCodigoQr == cadenaParaCodigoQr)&&(identical(other.codigoHash, codigoHash) || other.codigoHash == codigoHash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tipoDeComprobante,serie,numero,enlace,enlaceDelPdf,enlaceDelXml,enlaceDelCdr,aceptadaPorSunat,sunatDescription,sunatNote,sunatResponsecode,sunatSoapError,cadenaParaCodigoQr,codigoHash);

@override
String toString() {
  return 'ElectronicInvoiceResponse(tipoDeComprobante: $tipoDeComprobante, serie: $serie, numero: $numero, enlace: $enlace, enlaceDelPdf: $enlaceDelPdf, enlaceDelXml: $enlaceDelXml, enlaceDelCdr: $enlaceDelCdr, aceptadaPorSunat: $aceptadaPorSunat, sunatDescription: $sunatDescription, sunatNote: $sunatNote, sunatResponsecode: $sunatResponsecode, sunatSoapError: $sunatSoapError, cadenaParaCodigoQr: $cadenaParaCodigoQr, codigoHash: $codigoHash)';
}


}

/// @nodoc
abstract mixin class $ElectronicInvoiceResponseCopyWith<$Res>  {
  factory $ElectronicInvoiceResponseCopyWith(ElectronicInvoiceResponse value, $Res Function(ElectronicInvoiceResponse) _then) = _$ElectronicInvoiceResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'tipo_de_comprobante') int tipoDeComprobante, String serie, int numero, String enlace,@JsonKey(name: 'enlace_del_pdf') String enlaceDelPdf,@JsonKey(name: 'enlace_del_xml') String enlaceDelXml,@JsonKey(name: 'enlace_del_cdr') String enlaceDelCdr,@JsonKey(name: 'aceptada_por_sunat') bool aceptadaPorSunat,@JsonKey(name: 'sunat_description') String sunatDescription,@JsonKey(name: 'sunat_note') String? sunatNote,@JsonKey(name: 'sunat_responsecode') String sunatResponsecode,@JsonKey(name: 'sunat_soap_error') String sunatSoapError,@JsonKey(name: 'cadena_para_codigo_qr') String cadenaParaCodigoQr,@JsonKey(name: 'codigo_hash') String codigoHash
});




}
/// @nodoc
class _$ElectronicInvoiceResponseCopyWithImpl<$Res>
    implements $ElectronicInvoiceResponseCopyWith<$Res> {
  _$ElectronicInvoiceResponseCopyWithImpl(this._self, this._then);

  final ElectronicInvoiceResponse _self;
  final $Res Function(ElectronicInvoiceResponse) _then;

/// Create a copy of ElectronicInvoiceResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tipoDeComprobante = null,Object? serie = null,Object? numero = null,Object? enlace = null,Object? enlaceDelPdf = null,Object? enlaceDelXml = null,Object? enlaceDelCdr = null,Object? aceptadaPorSunat = null,Object? sunatDescription = null,Object? sunatNote = freezed,Object? sunatResponsecode = null,Object? sunatSoapError = null,Object? cadenaParaCodigoQr = null,Object? codigoHash = null,}) {
  return _then(_self.copyWith(
tipoDeComprobante: null == tipoDeComprobante ? _self.tipoDeComprobante : tipoDeComprobante // ignore: cast_nullable_to_non_nullable
as int,serie: null == serie ? _self.serie : serie // ignore: cast_nullable_to_non_nullable
as String,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as int,enlace: null == enlace ? _self.enlace : enlace // ignore: cast_nullable_to_non_nullable
as String,enlaceDelPdf: null == enlaceDelPdf ? _self.enlaceDelPdf : enlaceDelPdf // ignore: cast_nullable_to_non_nullable
as String,enlaceDelXml: null == enlaceDelXml ? _self.enlaceDelXml : enlaceDelXml // ignore: cast_nullable_to_non_nullable
as String,enlaceDelCdr: null == enlaceDelCdr ? _self.enlaceDelCdr : enlaceDelCdr // ignore: cast_nullable_to_non_nullable
as String,aceptadaPorSunat: null == aceptadaPorSunat ? _self.aceptadaPorSunat : aceptadaPorSunat // ignore: cast_nullable_to_non_nullable
as bool,sunatDescription: null == sunatDescription ? _self.sunatDescription : sunatDescription // ignore: cast_nullable_to_non_nullable
as String,sunatNote: freezed == sunatNote ? _self.sunatNote : sunatNote // ignore: cast_nullable_to_non_nullable
as String?,sunatResponsecode: null == sunatResponsecode ? _self.sunatResponsecode : sunatResponsecode // ignore: cast_nullable_to_non_nullable
as String,sunatSoapError: null == sunatSoapError ? _self.sunatSoapError : sunatSoapError // ignore: cast_nullable_to_non_nullable
as String,cadenaParaCodigoQr: null == cadenaParaCodigoQr ? _self.cadenaParaCodigoQr : cadenaParaCodigoQr // ignore: cast_nullable_to_non_nullable
as String,codigoHash: null == codigoHash ? _self.codigoHash : codigoHash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ElectronicInvoiceResponse].
extension ElectronicInvoiceResponsePatterns on ElectronicInvoiceResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ElectronicInvoiceResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ElectronicInvoiceResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ElectronicInvoiceResponse value)  $default,){
final _that = this;
switch (_that) {
case _ElectronicInvoiceResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ElectronicInvoiceResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ElectronicInvoiceResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'tipo_de_comprobante')  int tipoDeComprobante,  String serie,  int numero,  String enlace, @JsonKey(name: 'enlace_del_pdf')  String enlaceDelPdf, @JsonKey(name: 'enlace_del_xml')  String enlaceDelXml, @JsonKey(name: 'enlace_del_cdr')  String enlaceDelCdr, @JsonKey(name: 'aceptada_por_sunat')  bool aceptadaPorSunat, @JsonKey(name: 'sunat_description')  String sunatDescription, @JsonKey(name: 'sunat_note')  String? sunatNote, @JsonKey(name: 'sunat_responsecode')  String sunatResponsecode, @JsonKey(name: 'sunat_soap_error')  String sunatSoapError, @JsonKey(name: 'cadena_para_codigo_qr')  String cadenaParaCodigoQr, @JsonKey(name: 'codigo_hash')  String codigoHash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ElectronicInvoiceResponse() when $default != null:
return $default(_that.tipoDeComprobante,_that.serie,_that.numero,_that.enlace,_that.enlaceDelPdf,_that.enlaceDelXml,_that.enlaceDelCdr,_that.aceptadaPorSunat,_that.sunatDescription,_that.sunatNote,_that.sunatResponsecode,_that.sunatSoapError,_that.cadenaParaCodigoQr,_that.codigoHash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'tipo_de_comprobante')  int tipoDeComprobante,  String serie,  int numero,  String enlace, @JsonKey(name: 'enlace_del_pdf')  String enlaceDelPdf, @JsonKey(name: 'enlace_del_xml')  String enlaceDelXml, @JsonKey(name: 'enlace_del_cdr')  String enlaceDelCdr, @JsonKey(name: 'aceptada_por_sunat')  bool aceptadaPorSunat, @JsonKey(name: 'sunat_description')  String sunatDescription, @JsonKey(name: 'sunat_note')  String? sunatNote, @JsonKey(name: 'sunat_responsecode')  String sunatResponsecode, @JsonKey(name: 'sunat_soap_error')  String sunatSoapError, @JsonKey(name: 'cadena_para_codigo_qr')  String cadenaParaCodigoQr, @JsonKey(name: 'codigo_hash')  String codigoHash)  $default,) {final _that = this;
switch (_that) {
case _ElectronicInvoiceResponse():
return $default(_that.tipoDeComprobante,_that.serie,_that.numero,_that.enlace,_that.enlaceDelPdf,_that.enlaceDelXml,_that.enlaceDelCdr,_that.aceptadaPorSunat,_that.sunatDescription,_that.sunatNote,_that.sunatResponsecode,_that.sunatSoapError,_that.cadenaParaCodigoQr,_that.codigoHash);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'tipo_de_comprobante')  int tipoDeComprobante,  String serie,  int numero,  String enlace, @JsonKey(name: 'enlace_del_pdf')  String enlaceDelPdf, @JsonKey(name: 'enlace_del_xml')  String enlaceDelXml, @JsonKey(name: 'enlace_del_cdr')  String enlaceDelCdr, @JsonKey(name: 'aceptada_por_sunat')  bool aceptadaPorSunat, @JsonKey(name: 'sunat_description')  String sunatDescription, @JsonKey(name: 'sunat_note')  String? sunatNote, @JsonKey(name: 'sunat_responsecode')  String sunatResponsecode, @JsonKey(name: 'sunat_soap_error')  String sunatSoapError, @JsonKey(name: 'cadena_para_codigo_qr')  String cadenaParaCodigoQr, @JsonKey(name: 'codigo_hash')  String codigoHash)?  $default,) {final _that = this;
switch (_that) {
case _ElectronicInvoiceResponse() when $default != null:
return $default(_that.tipoDeComprobante,_that.serie,_that.numero,_that.enlace,_that.enlaceDelPdf,_that.enlaceDelXml,_that.enlaceDelCdr,_that.aceptadaPorSunat,_that.sunatDescription,_that.sunatNote,_that.sunatResponsecode,_that.sunatSoapError,_that.cadenaParaCodigoQr,_that.codigoHash);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ElectronicInvoiceResponse extends ElectronicInvoiceResponse {
  const _ElectronicInvoiceResponse({@JsonKey(name: 'tipo_de_comprobante') required this.tipoDeComprobante, required this.serie, required this.numero, this.enlace = '', @JsonKey(name: 'enlace_del_pdf') this.enlaceDelPdf = '', @JsonKey(name: 'enlace_del_xml') this.enlaceDelXml = '', @JsonKey(name: 'enlace_del_cdr') this.enlaceDelCdr = '', @JsonKey(name: 'aceptada_por_sunat') required this.aceptadaPorSunat, @JsonKey(name: 'sunat_description') this.sunatDescription = '', @JsonKey(name: 'sunat_note') this.sunatNote, @JsonKey(name: 'sunat_responsecode') this.sunatResponsecode = '', @JsonKey(name: 'sunat_soap_error') this.sunatSoapError = '', @JsonKey(name: 'cadena_para_codigo_qr') this.cadenaParaCodigoQr = '', @JsonKey(name: 'codigo_hash') this.codigoHash = ''}): super._();
  factory _ElectronicInvoiceResponse.fromJson(Map<String, dynamic> json) => _$ElectronicInvoiceResponseFromJson(json);

/// Tipo de comprobante generado
@override@JsonKey(name: 'tipo_de_comprobante') final  int tipoDeComprobante;
/// Serie del comprobante
@override final  String serie;
/// Número del comprobante
@override final  int numero;
/// Enlace al comprobante en la plataforma
@override@JsonKey() final  String enlace;
/// Enlace al PDF del comprobante
@override@JsonKey(name: 'enlace_del_pdf') final  String enlaceDelPdf;
/// Enlace al XML del comprobante
@override@JsonKey(name: 'enlace_del_xml') final  String enlaceDelXml;
/// Enlace al CDR (Constancia de Recepción)
@override@JsonKey(name: 'enlace_del_cdr') final  String enlaceDelCdr;
/// Indica si fue aceptada por SUNAT
@override@JsonKey(name: 'aceptada_por_sunat') final  bool aceptadaPorSunat;
/// Descripción de SUNAT
@override@JsonKey(name: 'sunat_description') final  String sunatDescription;
/// Nota de SUNAT (puede ser null)
@override@JsonKey(name: 'sunat_note') final  String? sunatNote;
/// Código de respuesta de SUNAT
@override@JsonKey(name: 'sunat_responsecode') final  String sunatResponsecode;
/// Error SOAP de SUNAT (vacío si no hay error)
@override@JsonKey(name: 'sunat_soap_error') final  String sunatSoapError;
/// Cadena para generar código QR
@override@JsonKey(name: 'cadena_para_codigo_qr') final  String cadenaParaCodigoQr;
/// Hash del comprobante
@override@JsonKey(name: 'codigo_hash') final  String codigoHash;

/// Create a copy of ElectronicInvoiceResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ElectronicInvoiceResponseCopyWith<_ElectronicInvoiceResponse> get copyWith => __$ElectronicInvoiceResponseCopyWithImpl<_ElectronicInvoiceResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ElectronicInvoiceResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ElectronicInvoiceResponse&&(identical(other.tipoDeComprobante, tipoDeComprobante) || other.tipoDeComprobante == tipoDeComprobante)&&(identical(other.serie, serie) || other.serie == serie)&&(identical(other.numero, numero) || other.numero == numero)&&(identical(other.enlace, enlace) || other.enlace == enlace)&&(identical(other.enlaceDelPdf, enlaceDelPdf) || other.enlaceDelPdf == enlaceDelPdf)&&(identical(other.enlaceDelXml, enlaceDelXml) || other.enlaceDelXml == enlaceDelXml)&&(identical(other.enlaceDelCdr, enlaceDelCdr) || other.enlaceDelCdr == enlaceDelCdr)&&(identical(other.aceptadaPorSunat, aceptadaPorSunat) || other.aceptadaPorSunat == aceptadaPorSunat)&&(identical(other.sunatDescription, sunatDescription) || other.sunatDescription == sunatDescription)&&(identical(other.sunatNote, sunatNote) || other.sunatNote == sunatNote)&&(identical(other.sunatResponsecode, sunatResponsecode) || other.sunatResponsecode == sunatResponsecode)&&(identical(other.sunatSoapError, sunatSoapError) || other.sunatSoapError == sunatSoapError)&&(identical(other.cadenaParaCodigoQr, cadenaParaCodigoQr) || other.cadenaParaCodigoQr == cadenaParaCodigoQr)&&(identical(other.codigoHash, codigoHash) || other.codigoHash == codigoHash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tipoDeComprobante,serie,numero,enlace,enlaceDelPdf,enlaceDelXml,enlaceDelCdr,aceptadaPorSunat,sunatDescription,sunatNote,sunatResponsecode,sunatSoapError,cadenaParaCodigoQr,codigoHash);

@override
String toString() {
  return 'ElectronicInvoiceResponse(tipoDeComprobante: $tipoDeComprobante, serie: $serie, numero: $numero, enlace: $enlace, enlaceDelPdf: $enlaceDelPdf, enlaceDelXml: $enlaceDelXml, enlaceDelCdr: $enlaceDelCdr, aceptadaPorSunat: $aceptadaPorSunat, sunatDescription: $sunatDescription, sunatNote: $sunatNote, sunatResponsecode: $sunatResponsecode, sunatSoapError: $sunatSoapError, cadenaParaCodigoQr: $cadenaParaCodigoQr, codigoHash: $codigoHash)';
}


}

/// @nodoc
abstract mixin class _$ElectronicInvoiceResponseCopyWith<$Res> implements $ElectronicInvoiceResponseCopyWith<$Res> {
  factory _$ElectronicInvoiceResponseCopyWith(_ElectronicInvoiceResponse value, $Res Function(_ElectronicInvoiceResponse) _then) = __$ElectronicInvoiceResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'tipo_de_comprobante') int tipoDeComprobante, String serie, int numero, String enlace,@JsonKey(name: 'enlace_del_pdf') String enlaceDelPdf,@JsonKey(name: 'enlace_del_xml') String enlaceDelXml,@JsonKey(name: 'enlace_del_cdr') String enlaceDelCdr,@JsonKey(name: 'aceptada_por_sunat') bool aceptadaPorSunat,@JsonKey(name: 'sunat_description') String sunatDescription,@JsonKey(name: 'sunat_note') String? sunatNote,@JsonKey(name: 'sunat_responsecode') String sunatResponsecode,@JsonKey(name: 'sunat_soap_error') String sunatSoapError,@JsonKey(name: 'cadena_para_codigo_qr') String cadenaParaCodigoQr,@JsonKey(name: 'codigo_hash') String codigoHash
});




}
/// @nodoc
class __$ElectronicInvoiceResponseCopyWithImpl<$Res>
    implements _$ElectronicInvoiceResponseCopyWith<$Res> {
  __$ElectronicInvoiceResponseCopyWithImpl(this._self, this._then);

  final _ElectronicInvoiceResponse _self;
  final $Res Function(_ElectronicInvoiceResponse) _then;

/// Create a copy of ElectronicInvoiceResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tipoDeComprobante = null,Object? serie = null,Object? numero = null,Object? enlace = null,Object? enlaceDelPdf = null,Object? enlaceDelXml = null,Object? enlaceDelCdr = null,Object? aceptadaPorSunat = null,Object? sunatDescription = null,Object? sunatNote = freezed,Object? sunatResponsecode = null,Object? sunatSoapError = null,Object? cadenaParaCodigoQr = null,Object? codigoHash = null,}) {
  return _then(_ElectronicInvoiceResponse(
tipoDeComprobante: null == tipoDeComprobante ? _self.tipoDeComprobante : tipoDeComprobante // ignore: cast_nullable_to_non_nullable
as int,serie: null == serie ? _self.serie : serie // ignore: cast_nullable_to_non_nullable
as String,numero: null == numero ? _self.numero : numero // ignore: cast_nullable_to_non_nullable
as int,enlace: null == enlace ? _self.enlace : enlace // ignore: cast_nullable_to_non_nullable
as String,enlaceDelPdf: null == enlaceDelPdf ? _self.enlaceDelPdf : enlaceDelPdf // ignore: cast_nullable_to_non_nullable
as String,enlaceDelXml: null == enlaceDelXml ? _self.enlaceDelXml : enlaceDelXml // ignore: cast_nullable_to_non_nullable
as String,enlaceDelCdr: null == enlaceDelCdr ? _self.enlaceDelCdr : enlaceDelCdr // ignore: cast_nullable_to_non_nullable
as String,aceptadaPorSunat: null == aceptadaPorSunat ? _self.aceptadaPorSunat : aceptadaPorSunat // ignore: cast_nullable_to_non_nullable
as bool,sunatDescription: null == sunatDescription ? _self.sunatDescription : sunatDescription // ignore: cast_nullable_to_non_nullable
as String,sunatNote: freezed == sunatNote ? _self.sunatNote : sunatNote // ignore: cast_nullable_to_non_nullable
as String?,sunatResponsecode: null == sunatResponsecode ? _self.sunatResponsecode : sunatResponsecode // ignore: cast_nullable_to_non_nullable
as String,sunatSoapError: null == sunatSoapError ? _self.sunatSoapError : sunatSoapError // ignore: cast_nullable_to_non_nullable
as String,cadenaParaCodigoQr: null == cadenaParaCodigoQr ? _self.cadenaParaCodigoQr : cadenaParaCodigoQr // ignore: cast_nullable_to_non_nullable
as String,codigoHash: null == codigoHash ? _self.codigoHash : codigoHash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
