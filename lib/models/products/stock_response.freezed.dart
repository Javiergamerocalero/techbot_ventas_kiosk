// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stock_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StockResponse {

 bool get isAvailable; int get availableStock; String get message; Map<String, dynamic>? get additionalData;
/// Create a copy of StockResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StockResponseCopyWith<StockResponse> get copyWith => _$StockResponseCopyWithImpl<StockResponse>(this as StockResponse, _$identity);

  /// Serializes this StockResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StockResponse&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.availableStock, availableStock) || other.availableStock == availableStock)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.additionalData, additionalData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAvailable,availableStock,message,const DeepCollectionEquality().hash(additionalData));

@override
String toString() {
  return 'StockResponse(isAvailable: $isAvailable, availableStock: $availableStock, message: $message, additionalData: $additionalData)';
}


}

/// @nodoc
abstract mixin class $StockResponseCopyWith<$Res>  {
  factory $StockResponseCopyWith(StockResponse value, $Res Function(StockResponse) _then) = _$StockResponseCopyWithImpl;
@useResult
$Res call({
 bool isAvailable, int availableStock, String message, Map<String, dynamic>? additionalData
});




}
/// @nodoc
class _$StockResponseCopyWithImpl<$Res>
    implements $StockResponseCopyWith<$Res> {
  _$StockResponseCopyWithImpl(this._self, this._then);

  final StockResponse _self;
  final $Res Function(StockResponse) _then;

/// Create a copy of StockResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isAvailable = null,Object? availableStock = null,Object? message = null,Object? additionalData = freezed,}) {
  return _then(_self.copyWith(
isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,availableStock: null == availableStock ? _self.availableStock : availableStock // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,additionalData: freezed == additionalData ? _self.additionalData : additionalData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [StockResponse].
extension StockResponsePatterns on StockResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StockResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StockResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StockResponse value)  $default,){
final _that = this;
switch (_that) {
case _StockResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StockResponse value)?  $default,){
final _that = this;
switch (_that) {
case _StockResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isAvailable,  int availableStock,  String message,  Map<String, dynamic>? additionalData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StockResponse() when $default != null:
return $default(_that.isAvailable,_that.availableStock,_that.message,_that.additionalData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isAvailable,  int availableStock,  String message,  Map<String, dynamic>? additionalData)  $default,) {final _that = this;
switch (_that) {
case _StockResponse():
return $default(_that.isAvailable,_that.availableStock,_that.message,_that.additionalData);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isAvailable,  int availableStock,  String message,  Map<String, dynamic>? additionalData)?  $default,) {final _that = this;
switch (_that) {
case _StockResponse() when $default != null:
return $default(_that.isAvailable,_that.availableStock,_that.message,_that.additionalData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StockResponse implements StockResponse {
  const _StockResponse({required this.isAvailable, required this.availableStock, required this.message, final  Map<String, dynamic>? additionalData}): _additionalData = additionalData;
  factory _StockResponse.fromJson(Map<String, dynamic> json) => _$StockResponseFromJson(json);

@override final  bool isAvailable;
@override final  int availableStock;
@override final  String message;
 final  Map<String, dynamic>? _additionalData;
@override Map<String, dynamic>? get additionalData {
  final value = _additionalData;
  if (value == null) return null;
  if (_additionalData is EqualUnmodifiableMapView) return _additionalData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of StockResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StockResponseCopyWith<_StockResponse> get copyWith => __$StockResponseCopyWithImpl<_StockResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StockResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StockResponse&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.availableStock, availableStock) || other.availableStock == availableStock)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._additionalData, _additionalData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isAvailable,availableStock,message,const DeepCollectionEquality().hash(_additionalData));

@override
String toString() {
  return 'StockResponse(isAvailable: $isAvailable, availableStock: $availableStock, message: $message, additionalData: $additionalData)';
}


}

/// @nodoc
abstract mixin class _$StockResponseCopyWith<$Res> implements $StockResponseCopyWith<$Res> {
  factory _$StockResponseCopyWith(_StockResponse value, $Res Function(_StockResponse) _then) = __$StockResponseCopyWithImpl;
@override @useResult
$Res call({
 bool isAvailable, int availableStock, String message, Map<String, dynamic>? additionalData
});




}
/// @nodoc
class __$StockResponseCopyWithImpl<$Res>
    implements _$StockResponseCopyWith<$Res> {
  __$StockResponseCopyWithImpl(this._self, this._then);

  final _StockResponse _self;
  final $Res Function(_StockResponse) _then;

/// Create a copy of StockResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isAvailable = null,Object? availableStock = null,Object? message = null,Object? additionalData = freezed,}) {
  return _then(_StockResponse(
isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,availableStock: null == availableStock ? _self.availableStock : availableStock // ignore: cast_nullable_to_non_nullable
as int,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,additionalData: freezed == additionalData ? _self._additionalData : additionalData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
