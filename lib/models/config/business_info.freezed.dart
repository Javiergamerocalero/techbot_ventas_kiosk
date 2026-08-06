// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusinessInfo {

@JsonKey(name: 'business_name') String get businessName;@JsonKey(name: 'trade_name') String get tradeName;@JsonKey(name: 'tax_id') String get taxId; String get address;@JsonKey(name: 'branch_name') String? get branchName;@JsonKey(name: 'branch_address') String? get branchAddress;
/// Create a copy of BusinessInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessInfoCopyWith<BusinessInfo> get copyWith => _$BusinessInfoCopyWithImpl<BusinessInfo>(this as BusinessInfo, _$identity);

  /// Serializes this BusinessInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessInfo&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.tradeName, tradeName) || other.tradeName == tradeName)&&(identical(other.taxId, taxId) || other.taxId == taxId)&&(identical(other.address, address) || other.address == address)&&(identical(other.branchName, branchName) || other.branchName == branchName)&&(identical(other.branchAddress, branchAddress) || other.branchAddress == branchAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,businessName,tradeName,taxId,address,branchName,branchAddress);

@override
String toString() {
  return 'BusinessInfo(businessName: $businessName, tradeName: $tradeName, taxId: $taxId, address: $address, branchName: $branchName, branchAddress: $branchAddress)';
}


}

/// @nodoc
abstract mixin class $BusinessInfoCopyWith<$Res>  {
  factory $BusinessInfoCopyWith(BusinessInfo value, $Res Function(BusinessInfo) _then) = _$BusinessInfoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'business_name') String businessName,@JsonKey(name: 'trade_name') String tradeName,@JsonKey(name: 'tax_id') String taxId, String address,@JsonKey(name: 'branch_name') String? branchName,@JsonKey(name: 'branch_address') String? branchAddress
});




}
/// @nodoc
class _$BusinessInfoCopyWithImpl<$Res>
    implements $BusinessInfoCopyWith<$Res> {
  _$BusinessInfoCopyWithImpl(this._self, this._then);

  final BusinessInfo _self;
  final $Res Function(BusinessInfo) _then;

/// Create a copy of BusinessInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? businessName = null,Object? tradeName = null,Object? taxId = null,Object? address = null,Object? branchName = freezed,Object? branchAddress = freezed,}) {
  return _then(_self.copyWith(
businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,tradeName: null == tradeName ? _self.tradeName : tradeName // ignore: cast_nullable_to_non_nullable
as String,taxId: null == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,branchName: freezed == branchName ? _self.branchName : branchName // ignore: cast_nullable_to_non_nullable
as String?,branchAddress: freezed == branchAddress ? _self.branchAddress : branchAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessInfo].
extension BusinessInfoPatterns on BusinessInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessInfo value)  $default,){
final _that = this;
switch (_that) {
case _BusinessInfo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessInfo value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'business_name')  String businessName, @JsonKey(name: 'trade_name')  String tradeName, @JsonKey(name: 'tax_id')  String taxId,  String address, @JsonKey(name: 'branch_name')  String? branchName, @JsonKey(name: 'branch_address')  String? branchAddress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessInfo() when $default != null:
return $default(_that.businessName,_that.tradeName,_that.taxId,_that.address,_that.branchName,_that.branchAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'business_name')  String businessName, @JsonKey(name: 'trade_name')  String tradeName, @JsonKey(name: 'tax_id')  String taxId,  String address, @JsonKey(name: 'branch_name')  String? branchName, @JsonKey(name: 'branch_address')  String? branchAddress)  $default,) {final _that = this;
switch (_that) {
case _BusinessInfo():
return $default(_that.businessName,_that.tradeName,_that.taxId,_that.address,_that.branchName,_that.branchAddress);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'business_name')  String businessName, @JsonKey(name: 'trade_name')  String tradeName, @JsonKey(name: 'tax_id')  String taxId,  String address, @JsonKey(name: 'branch_name')  String? branchName, @JsonKey(name: 'branch_address')  String? branchAddress)?  $default,) {final _that = this;
switch (_that) {
case _BusinessInfo() when $default != null:
return $default(_that.businessName,_that.tradeName,_that.taxId,_that.address,_that.branchName,_that.branchAddress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessInfo implements BusinessInfo {
  const _BusinessInfo({@JsonKey(name: 'business_name') this.businessName = '', @JsonKey(name: 'trade_name') this.tradeName = '', @JsonKey(name: 'tax_id') this.taxId = '', this.address = '', @JsonKey(name: 'branch_name') this.branchName, @JsonKey(name: 'branch_address') this.branchAddress});
  factory _BusinessInfo.fromJson(Map<String, dynamic> json) => _$BusinessInfoFromJson(json);

@override@JsonKey(name: 'business_name') final  String businessName;
@override@JsonKey(name: 'trade_name') final  String tradeName;
@override@JsonKey(name: 'tax_id') final  String taxId;
@override@JsonKey() final  String address;
@override@JsonKey(name: 'branch_name') final  String? branchName;
@override@JsonKey(name: 'branch_address') final  String? branchAddress;

/// Create a copy of BusinessInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessInfoCopyWith<_BusinessInfo> get copyWith => __$BusinessInfoCopyWithImpl<_BusinessInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessInfo&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.tradeName, tradeName) || other.tradeName == tradeName)&&(identical(other.taxId, taxId) || other.taxId == taxId)&&(identical(other.address, address) || other.address == address)&&(identical(other.branchName, branchName) || other.branchName == branchName)&&(identical(other.branchAddress, branchAddress) || other.branchAddress == branchAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,businessName,tradeName,taxId,address,branchName,branchAddress);

@override
String toString() {
  return 'BusinessInfo(businessName: $businessName, tradeName: $tradeName, taxId: $taxId, address: $address, branchName: $branchName, branchAddress: $branchAddress)';
}


}

/// @nodoc
abstract mixin class _$BusinessInfoCopyWith<$Res> implements $BusinessInfoCopyWith<$Res> {
  factory _$BusinessInfoCopyWith(_BusinessInfo value, $Res Function(_BusinessInfo) _then) = __$BusinessInfoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'business_name') String businessName,@JsonKey(name: 'trade_name') String tradeName,@JsonKey(name: 'tax_id') String taxId, String address,@JsonKey(name: 'branch_name') String? branchName,@JsonKey(name: 'branch_address') String? branchAddress
});




}
/// @nodoc
class __$BusinessInfoCopyWithImpl<$Res>
    implements _$BusinessInfoCopyWith<$Res> {
  __$BusinessInfoCopyWithImpl(this._self, this._then);

  final _BusinessInfo _self;
  final $Res Function(_BusinessInfo) _then;

/// Create a copy of BusinessInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? businessName = null,Object? tradeName = null,Object? taxId = null,Object? address = null,Object? branchName = freezed,Object? branchAddress = freezed,}) {
  return _then(_BusinessInfo(
businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,tradeName: null == tradeName ? _self.tradeName : tradeName // ignore: cast_nullable_to_non_nullable
as String,taxId: null == taxId ? _self.taxId : taxId // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,branchName: freezed == branchName ? _self.branchName : branchName // ignore: cast_nullable_to_non_nullable
as String?,branchAddress: freezed == branchAddress ? _self.branchAddress : branchAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
