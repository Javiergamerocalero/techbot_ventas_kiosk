// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InvoiceItem {

/// Unidad de medida: NIU = PRODUCTO, ZZ = SERVICIO
@JsonKey(name: 'unidad_de_medida') String get unidadDeMedida;/// Código interno del producto
 String get codigo;/// Descripción del producto o servicio
 String get descripcion;/// Cantidad del producto
 String get cantidad;/// Valor unitario sin IGV
@JsonKey(name: 'valor_unitario') String get valorUnitario;/// Precio unitario con IGV
@JsonKey(name: 'precio_unitario') String get precioUnitario;/// Descuento aplicado al item
 String get descuento;/// Subtotal sin IGV (valor_unitario * cantidad - descuento)
 String get subtotal;/// Tipo de IGV: 1 = Gravado, 8 = Exonerado, 9 = Inafecto
@JsonKey(name: 'tipo_de_igv') int get tipoDeIgv;/// Monto del IGV
 String get igv;/// Total del item (subtotal + igv)
 String get total;/// Regularización de anticipo
@JsonKey(name: 'anticipo_regularizacion') String get anticipoRegularizacion;/// Serie del documento de anticipo
@JsonKey(name: 'anticipo_documento_serie') String get anticipoDocumentoSerie;/// Número del documento de anticipo
@JsonKey(name: 'anticipo_documento_numero') String get anticipoDocumentoNumero;/// Código del producto según catálogo SUNAT
@JsonKey(name: 'codigo_producto_sunat') String get codigoProductoSunat;
/// Create a copy of InvoiceItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceItemCopyWith<InvoiceItem> get copyWith => _$InvoiceItemCopyWithImpl<InvoiceItem>(this as InvoiceItem, _$identity);

  /// Serializes this InvoiceItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceItem&&(identical(other.unidadDeMedida, unidadDeMedida) || other.unidadDeMedida == unidadDeMedida)&&(identical(other.codigo, codigo) || other.codigo == codigo)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion)&&(identical(other.cantidad, cantidad) || other.cantidad == cantidad)&&(identical(other.valorUnitario, valorUnitario) || other.valorUnitario == valorUnitario)&&(identical(other.precioUnitario, precioUnitario) || other.precioUnitario == precioUnitario)&&(identical(other.descuento, descuento) || other.descuento == descuento)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.tipoDeIgv, tipoDeIgv) || other.tipoDeIgv == tipoDeIgv)&&(identical(other.igv, igv) || other.igv == igv)&&(identical(other.total, total) || other.total == total)&&(identical(other.anticipoRegularizacion, anticipoRegularizacion) || other.anticipoRegularizacion == anticipoRegularizacion)&&(identical(other.anticipoDocumentoSerie, anticipoDocumentoSerie) || other.anticipoDocumentoSerie == anticipoDocumentoSerie)&&(identical(other.anticipoDocumentoNumero, anticipoDocumentoNumero) || other.anticipoDocumentoNumero == anticipoDocumentoNumero)&&(identical(other.codigoProductoSunat, codigoProductoSunat) || other.codigoProductoSunat == codigoProductoSunat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unidadDeMedida,codigo,descripcion,cantidad,valorUnitario,precioUnitario,descuento,subtotal,tipoDeIgv,igv,total,anticipoRegularizacion,anticipoDocumentoSerie,anticipoDocumentoNumero,codigoProductoSunat);

@override
String toString() {
  return 'InvoiceItem(unidadDeMedida: $unidadDeMedida, codigo: $codigo, descripcion: $descripcion, cantidad: $cantidad, valorUnitario: $valorUnitario, precioUnitario: $precioUnitario, descuento: $descuento, subtotal: $subtotal, tipoDeIgv: $tipoDeIgv, igv: $igv, total: $total, anticipoRegularizacion: $anticipoRegularizacion, anticipoDocumentoSerie: $anticipoDocumentoSerie, anticipoDocumentoNumero: $anticipoDocumentoNumero, codigoProductoSunat: $codigoProductoSunat)';
}


}

/// @nodoc
abstract mixin class $InvoiceItemCopyWith<$Res>  {
  factory $InvoiceItemCopyWith(InvoiceItem value, $Res Function(InvoiceItem) _then) = _$InvoiceItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'unidad_de_medida') String unidadDeMedida, String codigo, String descripcion, String cantidad,@JsonKey(name: 'valor_unitario') String valorUnitario,@JsonKey(name: 'precio_unitario') String precioUnitario, String descuento, String subtotal,@JsonKey(name: 'tipo_de_igv') int tipoDeIgv, String igv, String total,@JsonKey(name: 'anticipo_regularizacion') String anticipoRegularizacion,@JsonKey(name: 'anticipo_documento_serie') String anticipoDocumentoSerie,@JsonKey(name: 'anticipo_documento_numero') String anticipoDocumentoNumero,@JsonKey(name: 'codigo_producto_sunat') String codigoProductoSunat
});




}
/// @nodoc
class _$InvoiceItemCopyWithImpl<$Res>
    implements $InvoiceItemCopyWith<$Res> {
  _$InvoiceItemCopyWithImpl(this._self, this._then);

  final InvoiceItem _self;
  final $Res Function(InvoiceItem) _then;

/// Create a copy of InvoiceItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? unidadDeMedida = null,Object? codigo = null,Object? descripcion = null,Object? cantidad = null,Object? valorUnitario = null,Object? precioUnitario = null,Object? descuento = null,Object? subtotal = null,Object? tipoDeIgv = null,Object? igv = null,Object? total = null,Object? anticipoRegularizacion = null,Object? anticipoDocumentoSerie = null,Object? anticipoDocumentoNumero = null,Object? codigoProductoSunat = null,}) {
  return _then(_self.copyWith(
unidadDeMedida: null == unidadDeMedida ? _self.unidadDeMedida : unidadDeMedida // ignore: cast_nullable_to_non_nullable
as String,codigo: null == codigo ? _self.codigo : codigo // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,cantidad: null == cantidad ? _self.cantidad : cantidad // ignore: cast_nullable_to_non_nullable
as String,valorUnitario: null == valorUnitario ? _self.valorUnitario : valorUnitario // ignore: cast_nullable_to_non_nullable
as String,precioUnitario: null == precioUnitario ? _self.precioUnitario : precioUnitario // ignore: cast_nullable_to_non_nullable
as String,descuento: null == descuento ? _self.descuento : descuento // ignore: cast_nullable_to_non_nullable
as String,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as String,tipoDeIgv: null == tipoDeIgv ? _self.tipoDeIgv : tipoDeIgv // ignore: cast_nullable_to_non_nullable
as int,igv: null == igv ? _self.igv : igv // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as String,anticipoRegularizacion: null == anticipoRegularizacion ? _self.anticipoRegularizacion : anticipoRegularizacion // ignore: cast_nullable_to_non_nullable
as String,anticipoDocumentoSerie: null == anticipoDocumentoSerie ? _self.anticipoDocumentoSerie : anticipoDocumentoSerie // ignore: cast_nullable_to_non_nullable
as String,anticipoDocumentoNumero: null == anticipoDocumentoNumero ? _self.anticipoDocumentoNumero : anticipoDocumentoNumero // ignore: cast_nullable_to_non_nullable
as String,codigoProductoSunat: null == codigoProductoSunat ? _self.codigoProductoSunat : codigoProductoSunat // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InvoiceItem].
extension InvoiceItemPatterns on InvoiceItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvoiceItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvoiceItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvoiceItem value)  $default,){
final _that = this;
switch (_that) {
case _InvoiceItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvoiceItem value)?  $default,){
final _that = this;
switch (_that) {
case _InvoiceItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'unidad_de_medida')  String unidadDeMedida,  String codigo,  String descripcion,  String cantidad, @JsonKey(name: 'valor_unitario')  String valorUnitario, @JsonKey(name: 'precio_unitario')  String precioUnitario,  String descuento,  String subtotal, @JsonKey(name: 'tipo_de_igv')  int tipoDeIgv,  String igv,  String total, @JsonKey(name: 'anticipo_regularizacion')  String anticipoRegularizacion, @JsonKey(name: 'anticipo_documento_serie')  String anticipoDocumentoSerie, @JsonKey(name: 'anticipo_documento_numero')  String anticipoDocumentoNumero, @JsonKey(name: 'codigo_producto_sunat')  String codigoProductoSunat)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvoiceItem() when $default != null:
return $default(_that.unidadDeMedida,_that.codigo,_that.descripcion,_that.cantidad,_that.valorUnitario,_that.precioUnitario,_that.descuento,_that.subtotal,_that.tipoDeIgv,_that.igv,_that.total,_that.anticipoRegularizacion,_that.anticipoDocumentoSerie,_that.anticipoDocumentoNumero,_that.codigoProductoSunat);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'unidad_de_medida')  String unidadDeMedida,  String codigo,  String descripcion,  String cantidad, @JsonKey(name: 'valor_unitario')  String valorUnitario, @JsonKey(name: 'precio_unitario')  String precioUnitario,  String descuento,  String subtotal, @JsonKey(name: 'tipo_de_igv')  int tipoDeIgv,  String igv,  String total, @JsonKey(name: 'anticipo_regularizacion')  String anticipoRegularizacion, @JsonKey(name: 'anticipo_documento_serie')  String anticipoDocumentoSerie, @JsonKey(name: 'anticipo_documento_numero')  String anticipoDocumentoNumero, @JsonKey(name: 'codigo_producto_sunat')  String codigoProductoSunat)  $default,) {final _that = this;
switch (_that) {
case _InvoiceItem():
return $default(_that.unidadDeMedida,_that.codigo,_that.descripcion,_that.cantidad,_that.valorUnitario,_that.precioUnitario,_that.descuento,_that.subtotal,_that.tipoDeIgv,_that.igv,_that.total,_that.anticipoRegularizacion,_that.anticipoDocumentoSerie,_that.anticipoDocumentoNumero,_that.codigoProductoSunat);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'unidad_de_medida')  String unidadDeMedida,  String codigo,  String descripcion,  String cantidad, @JsonKey(name: 'valor_unitario')  String valorUnitario, @JsonKey(name: 'precio_unitario')  String precioUnitario,  String descuento,  String subtotal, @JsonKey(name: 'tipo_de_igv')  int tipoDeIgv,  String igv,  String total, @JsonKey(name: 'anticipo_regularizacion')  String anticipoRegularizacion, @JsonKey(name: 'anticipo_documento_serie')  String anticipoDocumentoSerie, @JsonKey(name: 'anticipo_documento_numero')  String anticipoDocumentoNumero, @JsonKey(name: 'codigo_producto_sunat')  String codigoProductoSunat)?  $default,) {final _that = this;
switch (_that) {
case _InvoiceItem() when $default != null:
return $default(_that.unidadDeMedida,_that.codigo,_that.descripcion,_that.cantidad,_that.valorUnitario,_that.precioUnitario,_that.descuento,_that.subtotal,_that.tipoDeIgv,_that.igv,_that.total,_that.anticipoRegularizacion,_that.anticipoDocumentoSerie,_that.anticipoDocumentoNumero,_that.codigoProductoSunat);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvoiceItem extends InvoiceItem {
  const _InvoiceItem({@JsonKey(name: 'unidad_de_medida') required this.unidadDeMedida, required this.codigo, required this.descripcion, required this.cantidad, @JsonKey(name: 'valor_unitario') required this.valorUnitario, @JsonKey(name: 'precio_unitario') required this.precioUnitario, this.descuento = '', required this.subtotal, @JsonKey(name: 'tipo_de_igv') required this.tipoDeIgv, required this.igv, required this.total, @JsonKey(name: 'anticipo_regularizacion') this.anticipoRegularizacion = 'false', @JsonKey(name: 'anticipo_documento_serie') this.anticipoDocumentoSerie = '', @JsonKey(name: 'anticipo_documento_numero') this.anticipoDocumentoNumero = '', @JsonKey(name: 'codigo_producto_sunat') this.codigoProductoSunat = '10000000'}): super._();
  factory _InvoiceItem.fromJson(Map<String, dynamic> json) => _$InvoiceItemFromJson(json);

/// Unidad de medida: NIU = PRODUCTO, ZZ = SERVICIO
@override@JsonKey(name: 'unidad_de_medida') final  String unidadDeMedida;
/// Código interno del producto
@override final  String codigo;
/// Descripción del producto o servicio
@override final  String descripcion;
/// Cantidad del producto
@override final  String cantidad;
/// Valor unitario sin IGV
@override@JsonKey(name: 'valor_unitario') final  String valorUnitario;
/// Precio unitario con IGV
@override@JsonKey(name: 'precio_unitario') final  String precioUnitario;
/// Descuento aplicado al item
@override@JsonKey() final  String descuento;
/// Subtotal sin IGV (valor_unitario * cantidad - descuento)
@override final  String subtotal;
/// Tipo de IGV: 1 = Gravado, 8 = Exonerado, 9 = Inafecto
@override@JsonKey(name: 'tipo_de_igv') final  int tipoDeIgv;
/// Monto del IGV
@override final  String igv;
/// Total del item (subtotal + igv)
@override final  String total;
/// Regularización de anticipo
@override@JsonKey(name: 'anticipo_regularizacion') final  String anticipoRegularizacion;
/// Serie del documento de anticipo
@override@JsonKey(name: 'anticipo_documento_serie') final  String anticipoDocumentoSerie;
/// Número del documento de anticipo
@override@JsonKey(name: 'anticipo_documento_numero') final  String anticipoDocumentoNumero;
/// Código del producto según catálogo SUNAT
@override@JsonKey(name: 'codigo_producto_sunat') final  String codigoProductoSunat;

/// Create a copy of InvoiceItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceItemCopyWith<_InvoiceItem> get copyWith => __$InvoiceItemCopyWithImpl<_InvoiceItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvoiceItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvoiceItem&&(identical(other.unidadDeMedida, unidadDeMedida) || other.unidadDeMedida == unidadDeMedida)&&(identical(other.codigo, codigo) || other.codigo == codigo)&&(identical(other.descripcion, descripcion) || other.descripcion == descripcion)&&(identical(other.cantidad, cantidad) || other.cantidad == cantidad)&&(identical(other.valorUnitario, valorUnitario) || other.valorUnitario == valorUnitario)&&(identical(other.precioUnitario, precioUnitario) || other.precioUnitario == precioUnitario)&&(identical(other.descuento, descuento) || other.descuento == descuento)&&(identical(other.subtotal, subtotal) || other.subtotal == subtotal)&&(identical(other.tipoDeIgv, tipoDeIgv) || other.tipoDeIgv == tipoDeIgv)&&(identical(other.igv, igv) || other.igv == igv)&&(identical(other.total, total) || other.total == total)&&(identical(other.anticipoRegularizacion, anticipoRegularizacion) || other.anticipoRegularizacion == anticipoRegularizacion)&&(identical(other.anticipoDocumentoSerie, anticipoDocumentoSerie) || other.anticipoDocumentoSerie == anticipoDocumentoSerie)&&(identical(other.anticipoDocumentoNumero, anticipoDocumentoNumero) || other.anticipoDocumentoNumero == anticipoDocumentoNumero)&&(identical(other.codigoProductoSunat, codigoProductoSunat) || other.codigoProductoSunat == codigoProductoSunat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,unidadDeMedida,codigo,descripcion,cantidad,valorUnitario,precioUnitario,descuento,subtotal,tipoDeIgv,igv,total,anticipoRegularizacion,anticipoDocumentoSerie,anticipoDocumentoNumero,codigoProductoSunat);

@override
String toString() {
  return 'InvoiceItem(unidadDeMedida: $unidadDeMedida, codigo: $codigo, descripcion: $descripcion, cantidad: $cantidad, valorUnitario: $valorUnitario, precioUnitario: $precioUnitario, descuento: $descuento, subtotal: $subtotal, tipoDeIgv: $tipoDeIgv, igv: $igv, total: $total, anticipoRegularizacion: $anticipoRegularizacion, anticipoDocumentoSerie: $anticipoDocumentoSerie, anticipoDocumentoNumero: $anticipoDocumentoNumero, codigoProductoSunat: $codigoProductoSunat)';
}


}

/// @nodoc
abstract mixin class _$InvoiceItemCopyWith<$Res> implements $InvoiceItemCopyWith<$Res> {
  factory _$InvoiceItemCopyWith(_InvoiceItem value, $Res Function(_InvoiceItem) _then) = __$InvoiceItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'unidad_de_medida') String unidadDeMedida, String codigo, String descripcion, String cantidad,@JsonKey(name: 'valor_unitario') String valorUnitario,@JsonKey(name: 'precio_unitario') String precioUnitario, String descuento, String subtotal,@JsonKey(name: 'tipo_de_igv') int tipoDeIgv, String igv, String total,@JsonKey(name: 'anticipo_regularizacion') String anticipoRegularizacion,@JsonKey(name: 'anticipo_documento_serie') String anticipoDocumentoSerie,@JsonKey(name: 'anticipo_documento_numero') String anticipoDocumentoNumero,@JsonKey(name: 'codigo_producto_sunat') String codigoProductoSunat
});




}
/// @nodoc
class __$InvoiceItemCopyWithImpl<$Res>
    implements _$InvoiceItemCopyWith<$Res> {
  __$InvoiceItemCopyWithImpl(this._self, this._then);

  final _InvoiceItem _self;
  final $Res Function(_InvoiceItem) _then;

/// Create a copy of InvoiceItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? unidadDeMedida = null,Object? codigo = null,Object? descripcion = null,Object? cantidad = null,Object? valorUnitario = null,Object? precioUnitario = null,Object? descuento = null,Object? subtotal = null,Object? tipoDeIgv = null,Object? igv = null,Object? total = null,Object? anticipoRegularizacion = null,Object? anticipoDocumentoSerie = null,Object? anticipoDocumentoNumero = null,Object? codigoProductoSunat = null,}) {
  return _then(_InvoiceItem(
unidadDeMedida: null == unidadDeMedida ? _self.unidadDeMedida : unidadDeMedida // ignore: cast_nullable_to_non_nullable
as String,codigo: null == codigo ? _self.codigo : codigo // ignore: cast_nullable_to_non_nullable
as String,descripcion: null == descripcion ? _self.descripcion : descripcion // ignore: cast_nullable_to_non_nullable
as String,cantidad: null == cantidad ? _self.cantidad : cantidad // ignore: cast_nullable_to_non_nullable
as String,valorUnitario: null == valorUnitario ? _self.valorUnitario : valorUnitario // ignore: cast_nullable_to_non_nullable
as String,precioUnitario: null == precioUnitario ? _self.precioUnitario : precioUnitario // ignore: cast_nullable_to_non_nullable
as String,descuento: null == descuento ? _self.descuento : descuento // ignore: cast_nullable_to_non_nullable
as String,subtotal: null == subtotal ? _self.subtotal : subtotal // ignore: cast_nullable_to_non_nullable
as String,tipoDeIgv: null == tipoDeIgv ? _self.tipoDeIgv : tipoDeIgv // ignore: cast_nullable_to_non_nullable
as int,igv: null == igv ? _self.igv : igv // ignore: cast_nullable_to_non_nullable
as String,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as String,anticipoRegularizacion: null == anticipoRegularizacion ? _self.anticipoRegularizacion : anticipoRegularizacion // ignore: cast_nullable_to_non_nullable
as String,anticipoDocumentoSerie: null == anticipoDocumentoSerie ? _self.anticipoDocumentoSerie : anticipoDocumentoSerie // ignore: cast_nullable_to_non_nullable
as String,anticipoDocumentoNumero: null == anticipoDocumentoNumero ? _self.anticipoDocumentoNumero : anticipoDocumentoNumero // ignore: cast_nullable_to_non_nullable
as String,codigoProductoSunat: null == codigoProductoSunat ? _self.codigoProductoSunat : codigoProductoSunat // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
