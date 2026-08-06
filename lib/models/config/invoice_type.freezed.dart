// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invoice_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InvoiceData {

 InvoiceType get type; String get dni; String get dniFullName; String get ruc; String get razonSocial; String get direccion; bool get isValidated;
/// Create a copy of InvoiceData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvoiceDataCopyWith<InvoiceData> get copyWith => _$InvoiceDataCopyWithImpl<InvoiceData>(this as InvoiceData, _$identity);

  /// Serializes this InvoiceData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvoiceData&&(identical(other.type, type) || other.type == type)&&(identical(other.dni, dni) || other.dni == dni)&&(identical(other.dniFullName, dniFullName) || other.dniFullName == dniFullName)&&(identical(other.ruc, ruc) || other.ruc == ruc)&&(identical(other.razonSocial, razonSocial) || other.razonSocial == razonSocial)&&(identical(other.direccion, direccion) || other.direccion == direccion)&&(identical(other.isValidated, isValidated) || other.isValidated == isValidated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,dni,dniFullName,ruc,razonSocial,direccion,isValidated);

@override
String toString() {
  return 'InvoiceData(type: $type, dni: $dni, dniFullName: $dniFullName, ruc: $ruc, razonSocial: $razonSocial, direccion: $direccion, isValidated: $isValidated)';
}


}

/// @nodoc
abstract mixin class $InvoiceDataCopyWith<$Res>  {
  factory $InvoiceDataCopyWith(InvoiceData value, $Res Function(InvoiceData) _then) = _$InvoiceDataCopyWithImpl;
@useResult
$Res call({
 InvoiceType type, String dni, String dniFullName, String ruc, String razonSocial, String direccion, bool isValidated
});




}
/// @nodoc
class _$InvoiceDataCopyWithImpl<$Res>
    implements $InvoiceDataCopyWith<$Res> {
  _$InvoiceDataCopyWithImpl(this._self, this._then);

  final InvoiceData _self;
  final $Res Function(InvoiceData) _then;

/// Create a copy of InvoiceData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? dni = null,Object? dniFullName = null,Object? ruc = null,Object? razonSocial = null,Object? direccion = null,Object? isValidated = null,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InvoiceType,dni: null == dni ? _self.dni : dni // ignore: cast_nullable_to_non_nullable
as String,dniFullName: null == dniFullName ? _self.dniFullName : dniFullName // ignore: cast_nullable_to_non_nullable
as String,ruc: null == ruc ? _self.ruc : ruc // ignore: cast_nullable_to_non_nullable
as String,razonSocial: null == razonSocial ? _self.razonSocial : razonSocial // ignore: cast_nullable_to_non_nullable
as String,direccion: null == direccion ? _self.direccion : direccion // ignore: cast_nullable_to_non_nullable
as String,isValidated: null == isValidated ? _self.isValidated : isValidated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [InvoiceData].
extension InvoiceDataPatterns on InvoiceData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvoiceData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvoiceData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvoiceData value)  $default,){
final _that = this;
switch (_that) {
case _InvoiceData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvoiceData value)?  $default,){
final _that = this;
switch (_that) {
case _InvoiceData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( InvoiceType type,  String dni,  String dniFullName,  String ruc,  String razonSocial,  String direccion,  bool isValidated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvoiceData() when $default != null:
return $default(_that.type,_that.dni,_that.dniFullName,_that.ruc,_that.razonSocial,_that.direccion,_that.isValidated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( InvoiceType type,  String dni,  String dniFullName,  String ruc,  String razonSocial,  String direccion,  bool isValidated)  $default,) {final _that = this;
switch (_that) {
case _InvoiceData():
return $default(_that.type,_that.dni,_that.dniFullName,_that.ruc,_that.razonSocial,_that.direccion,_that.isValidated);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( InvoiceType type,  String dni,  String dniFullName,  String ruc,  String razonSocial,  String direccion,  bool isValidated)?  $default,) {final _that = this;
switch (_that) {
case _InvoiceData() when $default != null:
return $default(_that.type,_that.dni,_that.dniFullName,_that.ruc,_that.razonSocial,_that.direccion,_that.isValidated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvoiceData implements InvoiceData {
  const _InvoiceData({required this.type, this.dni = '', this.dniFullName = '', this.ruc = '', this.razonSocial = '', this.direccion = '', this.isValidated = false});
  factory _InvoiceData.fromJson(Map<String, dynamic> json) => _$InvoiceDataFromJson(json);

@override final  InvoiceType type;
@override@JsonKey() final  String dni;
@override@JsonKey() final  String dniFullName;
@override@JsonKey() final  String ruc;
@override@JsonKey() final  String razonSocial;
@override@JsonKey() final  String direccion;
@override@JsonKey() final  bool isValidated;

/// Create a copy of InvoiceData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvoiceDataCopyWith<_InvoiceData> get copyWith => __$InvoiceDataCopyWithImpl<_InvoiceData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvoiceDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvoiceData&&(identical(other.type, type) || other.type == type)&&(identical(other.dni, dni) || other.dni == dni)&&(identical(other.dniFullName, dniFullName) || other.dniFullName == dniFullName)&&(identical(other.ruc, ruc) || other.ruc == ruc)&&(identical(other.razonSocial, razonSocial) || other.razonSocial == razonSocial)&&(identical(other.direccion, direccion) || other.direccion == direccion)&&(identical(other.isValidated, isValidated) || other.isValidated == isValidated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,dni,dniFullName,ruc,razonSocial,direccion,isValidated);

@override
String toString() {
  return 'InvoiceData(type: $type, dni: $dni, dniFullName: $dniFullName, ruc: $ruc, razonSocial: $razonSocial, direccion: $direccion, isValidated: $isValidated)';
}


}

/// @nodoc
abstract mixin class _$InvoiceDataCopyWith<$Res> implements $InvoiceDataCopyWith<$Res> {
  factory _$InvoiceDataCopyWith(_InvoiceData value, $Res Function(_InvoiceData) _then) = __$InvoiceDataCopyWithImpl;
@override @useResult
$Res call({
 InvoiceType type, String dni, String dniFullName, String ruc, String razonSocial, String direccion, bool isValidated
});




}
/// @nodoc
class __$InvoiceDataCopyWithImpl<$Res>
    implements _$InvoiceDataCopyWith<$Res> {
  __$InvoiceDataCopyWithImpl(this._self, this._then);

  final _InvoiceData _self;
  final $Res Function(_InvoiceData) _then;

/// Create a copy of InvoiceData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? dni = null,Object? dniFullName = null,Object? ruc = null,Object? razonSocial = null,Object? direccion = null,Object? isValidated = null,}) {
  return _then(_InvoiceData(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InvoiceType,dni: null == dni ? _self.dni : dni // ignore: cast_nullable_to_non_nullable
as String,dniFullName: null == dniFullName ? _self.dniFullName : dniFullName // ignore: cast_nullable_to_non_nullable
as String,ruc: null == ruc ? _self.ruc : ruc // ignore: cast_nullable_to_non_nullable
as String,razonSocial: null == razonSocial ? _self.razonSocial : razonSocial // ignore: cast_nullable_to_non_nullable
as String,direccion: null == direccion ? _self.direccion : direccion // ignore: cast_nullable_to_non_nullable
as String,isValidated: null == isValidated ? _self.isValidated : isValidated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
