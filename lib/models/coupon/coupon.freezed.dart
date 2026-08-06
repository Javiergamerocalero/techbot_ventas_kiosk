// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'coupon.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Coupon {

 int get id; String get code; String get description; String get type;// 'fixed' o 'percentage'
 String get value;// Valor como string del endpoint
 String? get minPurchaseAmount; int? get maxUses; int get uses; String? get expiresAt; bool get isActive;
/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CouponCopyWith<Coupon> get copyWith => _$CouponCopyWithImpl<Coupon>(this as Coupon, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Coupon&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value)&&(identical(other.minPurchaseAmount, minPurchaseAmount) || other.minPurchaseAmount == minPurchaseAmount)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.uses, uses) || other.uses == uses)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,description,type,value,minPurchaseAmount,maxUses,uses,expiresAt,isActive);

@override
String toString() {
  return 'Coupon(id: $id, code: $code, description: $description, type: $type, value: $value, minPurchaseAmount: $minPurchaseAmount, maxUses: $maxUses, uses: $uses, expiresAt: $expiresAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $CouponCopyWith<$Res>  {
  factory $CouponCopyWith(Coupon value, $Res Function(Coupon) _then) = _$CouponCopyWithImpl;
@useResult
$Res call({
 int id, String code, String description, String type, String value, String? minPurchaseAmount, int? maxUses, int uses, String? expiresAt, bool isActive
});




}
/// @nodoc
class _$CouponCopyWithImpl<$Res>
    implements $CouponCopyWith<$Res> {
  _$CouponCopyWithImpl(this._self, this._then);

  final Coupon _self;
  final $Res Function(Coupon) _then;

/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? code = null,Object? description = null,Object? type = null,Object? value = null,Object? minPurchaseAmount = freezed,Object? maxUses = freezed,Object? uses = null,Object? expiresAt = freezed,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,minPurchaseAmount: freezed == minPurchaseAmount ? _self.minPurchaseAmount : minPurchaseAmount // ignore: cast_nullable_to_non_nullable
as String?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,uses: null == uses ? _self.uses : uses // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Coupon].
extension CouponPatterns on Coupon {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Coupon value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Coupon() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Coupon value)  $default,){
final _that = this;
switch (_that) {
case _Coupon():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Coupon value)?  $default,){
final _that = this;
switch (_that) {
case _Coupon() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String code,  String description,  String type,  String value,  String? minPurchaseAmount,  int? maxUses,  int uses,  String? expiresAt,  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Coupon() when $default != null:
return $default(_that.id,_that.code,_that.description,_that.type,_that.value,_that.minPurchaseAmount,_that.maxUses,_that.uses,_that.expiresAt,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String code,  String description,  String type,  String value,  String? minPurchaseAmount,  int? maxUses,  int uses,  String? expiresAt,  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _Coupon():
return $default(_that.id,_that.code,_that.description,_that.type,_that.value,_that.minPurchaseAmount,_that.maxUses,_that.uses,_that.expiresAt,_that.isActive);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String code,  String description,  String type,  String value,  String? minPurchaseAmount,  int? maxUses,  int uses,  String? expiresAt,  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _Coupon() when $default != null:
return $default(_that.id,_that.code,_that.description,_that.type,_that.value,_that.minPurchaseAmount,_that.maxUses,_that.uses,_that.expiresAt,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc


class _Coupon implements Coupon {
  const _Coupon({required this.id, required this.code, required this.description, required this.type, required this.value, this.minPurchaseAmount, this.maxUses, required this.uses, this.expiresAt, required this.isActive});
  

@override final  int id;
@override final  String code;
@override final  String description;
@override final  String type;
// 'fixed' o 'percentage'
@override final  String value;
// Valor como string del endpoint
@override final  String? minPurchaseAmount;
@override final  int? maxUses;
@override final  int uses;
@override final  String? expiresAt;
@override final  bool isActive;

/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CouponCopyWith<_Coupon> get copyWith => __$CouponCopyWithImpl<_Coupon>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Coupon&&(identical(other.id, id) || other.id == id)&&(identical(other.code, code) || other.code == code)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.value, value) || other.value == value)&&(identical(other.minPurchaseAmount, minPurchaseAmount) || other.minPurchaseAmount == minPurchaseAmount)&&(identical(other.maxUses, maxUses) || other.maxUses == maxUses)&&(identical(other.uses, uses) || other.uses == uses)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}


@override
int get hashCode => Object.hash(runtimeType,id,code,description,type,value,minPurchaseAmount,maxUses,uses,expiresAt,isActive);

@override
String toString() {
  return 'Coupon(id: $id, code: $code, description: $description, type: $type, value: $value, minPurchaseAmount: $minPurchaseAmount, maxUses: $maxUses, uses: $uses, expiresAt: $expiresAt, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$CouponCopyWith<$Res> implements $CouponCopyWith<$Res> {
  factory _$CouponCopyWith(_Coupon value, $Res Function(_Coupon) _then) = __$CouponCopyWithImpl;
@override @useResult
$Res call({
 int id, String code, String description, String type, String value, String? minPurchaseAmount, int? maxUses, int uses, String? expiresAt, bool isActive
});




}
/// @nodoc
class __$CouponCopyWithImpl<$Res>
    implements _$CouponCopyWith<$Res> {
  __$CouponCopyWithImpl(this._self, this._then);

  final _Coupon _self;
  final $Res Function(_Coupon) _then;

/// Create a copy of Coupon
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? code = null,Object? description = null,Object? type = null,Object? value = null,Object? minPurchaseAmount = freezed,Object? maxUses = freezed,Object? uses = null,Object? expiresAt = freezed,Object? isActive = null,}) {
  return _then(_Coupon(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,minPurchaseAmount: freezed == minPurchaseAmount ? _self.minPurchaseAmount : minPurchaseAmount // ignore: cast_nullable_to_non_nullable
as String?,maxUses: freezed == maxUses ? _self.maxUses : maxUses // ignore: cast_nullable_to_non_nullable
as int?,uses: null == uses ? _self.uses : uses // ignore: cast_nullable_to_non_nullable
as int,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$CouponValidationResponse {

 bool get valid; Coupon get coupon; String? get message;
/// Create a copy of CouponValidationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CouponValidationResponseCopyWith<CouponValidationResponse> get copyWith => _$CouponValidationResponseCopyWithImpl<CouponValidationResponse>(this as CouponValidationResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CouponValidationResponse&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.coupon, coupon) || other.coupon == coupon)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,valid,coupon,message);

@override
String toString() {
  return 'CouponValidationResponse(valid: $valid, coupon: $coupon, message: $message)';
}


}

/// @nodoc
abstract mixin class $CouponValidationResponseCopyWith<$Res>  {
  factory $CouponValidationResponseCopyWith(CouponValidationResponse value, $Res Function(CouponValidationResponse) _then) = _$CouponValidationResponseCopyWithImpl;
@useResult
$Res call({
 bool valid, Coupon coupon, String? message
});


$CouponCopyWith<$Res> get coupon;

}
/// @nodoc
class _$CouponValidationResponseCopyWithImpl<$Res>
    implements $CouponValidationResponseCopyWith<$Res> {
  _$CouponValidationResponseCopyWithImpl(this._self, this._then);

  final CouponValidationResponse _self;
  final $Res Function(CouponValidationResponse) _then;

/// Create a copy of CouponValidationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? valid = null,Object? coupon = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,coupon: null == coupon ? _self.coupon : coupon // ignore: cast_nullable_to_non_nullable
as Coupon,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CouponValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CouponCopyWith<$Res> get coupon {
  
  return $CouponCopyWith<$Res>(_self.coupon, (value) {
    return _then(_self.copyWith(coupon: value));
  });
}
}


/// Adds pattern-matching-related methods to [CouponValidationResponse].
extension CouponValidationResponsePatterns on CouponValidationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CouponValidationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CouponValidationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CouponValidationResponse value)  $default,){
final _that = this;
switch (_that) {
case _CouponValidationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CouponValidationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CouponValidationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool valid,  Coupon coupon,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CouponValidationResponse() when $default != null:
return $default(_that.valid,_that.coupon,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool valid,  Coupon coupon,  String? message)  $default,) {final _that = this;
switch (_that) {
case _CouponValidationResponse():
return $default(_that.valid,_that.coupon,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool valid,  Coupon coupon,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _CouponValidationResponse() when $default != null:
return $default(_that.valid,_that.coupon,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _CouponValidationResponse implements CouponValidationResponse {
  const _CouponValidationResponse({required this.valid, required this.coupon, this.message});
  

@override final  bool valid;
@override final  Coupon coupon;
@override final  String? message;

/// Create a copy of CouponValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CouponValidationResponseCopyWith<_CouponValidationResponse> get copyWith => __$CouponValidationResponseCopyWithImpl<_CouponValidationResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CouponValidationResponse&&(identical(other.valid, valid) || other.valid == valid)&&(identical(other.coupon, coupon) || other.coupon == coupon)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,valid,coupon,message);

@override
String toString() {
  return 'CouponValidationResponse(valid: $valid, coupon: $coupon, message: $message)';
}


}

/// @nodoc
abstract mixin class _$CouponValidationResponseCopyWith<$Res> implements $CouponValidationResponseCopyWith<$Res> {
  factory _$CouponValidationResponseCopyWith(_CouponValidationResponse value, $Res Function(_CouponValidationResponse) _then) = __$CouponValidationResponseCopyWithImpl;
@override @useResult
$Res call({
 bool valid, Coupon coupon, String? message
});


@override $CouponCopyWith<$Res> get coupon;

}
/// @nodoc
class __$CouponValidationResponseCopyWithImpl<$Res>
    implements _$CouponValidationResponseCopyWith<$Res> {
  __$CouponValidationResponseCopyWithImpl(this._self, this._then);

  final _CouponValidationResponse _self;
  final $Res Function(_CouponValidationResponse) _then;

/// Create a copy of CouponValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? valid = null,Object? coupon = null,Object? message = freezed,}) {
  return _then(_CouponValidationResponse(
valid: null == valid ? _self.valid : valid // ignore: cast_nullable_to_non_nullable
as bool,coupon: null == coupon ? _self.coupon : coupon // ignore: cast_nullable_to_non_nullable
as Coupon,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CouponValidationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CouponCopyWith<$Res> get coupon {
  
  return $CouponCopyWith<$Res>(_self.coupon, (value) {
    return _then(_self.copyWith(coupon: value));
  });
}
}

// dart format on
