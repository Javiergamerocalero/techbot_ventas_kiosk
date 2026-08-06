// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'configuration_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ConfigurationData {

@JsonKey(name: 'apis_net_pe_key') String? get apisNetPeKey;@JsonKey(name: 'config_password') String? get configPassword;
/// Create a copy of ConfigurationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConfigurationDataCopyWith<ConfigurationData> get copyWith => _$ConfigurationDataCopyWithImpl<ConfigurationData>(this as ConfigurationData, _$identity);

  /// Serializes this ConfigurationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConfigurationData&&(identical(other.apisNetPeKey, apisNetPeKey) || other.apisNetPeKey == apisNetPeKey)&&(identical(other.configPassword, configPassword) || other.configPassword == configPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apisNetPeKey,configPassword);

@override
String toString() {
  return 'ConfigurationData(apisNetPeKey: $apisNetPeKey, configPassword: $configPassword)';
}


}

/// @nodoc
abstract mixin class $ConfigurationDataCopyWith<$Res>  {
  factory $ConfigurationDataCopyWith(ConfigurationData value, $Res Function(ConfigurationData) _then) = _$ConfigurationDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'apis_net_pe_key') String? apisNetPeKey,@JsonKey(name: 'config_password') String? configPassword
});




}
/// @nodoc
class _$ConfigurationDataCopyWithImpl<$Res>
    implements $ConfigurationDataCopyWith<$Res> {
  _$ConfigurationDataCopyWithImpl(this._self, this._then);

  final ConfigurationData _self;
  final $Res Function(ConfigurationData) _then;

/// Create a copy of ConfigurationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? apisNetPeKey = freezed,Object? configPassword = freezed,}) {
  return _then(_self.copyWith(
apisNetPeKey: freezed == apisNetPeKey ? _self.apisNetPeKey : apisNetPeKey // ignore: cast_nullable_to_non_nullable
as String?,configPassword: freezed == configPassword ? _self.configPassword : configPassword // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConfigurationData].
extension ConfigurationDataPatterns on ConfigurationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConfigurationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConfigurationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConfigurationData value)  $default,){
final _that = this;
switch (_that) {
case _ConfigurationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConfigurationData value)?  $default,){
final _that = this;
switch (_that) {
case _ConfigurationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'apis_net_pe_key')  String? apisNetPeKey, @JsonKey(name: 'config_password')  String? configPassword)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConfigurationData() when $default != null:
return $default(_that.apisNetPeKey,_that.configPassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'apis_net_pe_key')  String? apisNetPeKey, @JsonKey(name: 'config_password')  String? configPassword)  $default,) {final _that = this;
switch (_that) {
case _ConfigurationData():
return $default(_that.apisNetPeKey,_that.configPassword);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'apis_net_pe_key')  String? apisNetPeKey, @JsonKey(name: 'config_password')  String? configPassword)?  $default,) {final _that = this;
switch (_that) {
case _ConfigurationData() when $default != null:
return $default(_that.apisNetPeKey,_that.configPassword);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConfigurationData implements ConfigurationData {
  const _ConfigurationData({@JsonKey(name: 'apis_net_pe_key') this.apisNetPeKey, @JsonKey(name: 'config_password') this.configPassword});
  factory _ConfigurationData.fromJson(Map<String, dynamic> json) => _$ConfigurationDataFromJson(json);

@override@JsonKey(name: 'apis_net_pe_key') final  String? apisNetPeKey;
@override@JsonKey(name: 'config_password') final  String? configPassword;

/// Create a copy of ConfigurationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConfigurationDataCopyWith<_ConfigurationData> get copyWith => __$ConfigurationDataCopyWithImpl<_ConfigurationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConfigurationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConfigurationData&&(identical(other.apisNetPeKey, apisNetPeKey) || other.apisNetPeKey == apisNetPeKey)&&(identical(other.configPassword, configPassword) || other.configPassword == configPassword));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,apisNetPeKey,configPassword);

@override
String toString() {
  return 'ConfigurationData(apisNetPeKey: $apisNetPeKey, configPassword: $configPassword)';
}


}

/// @nodoc
abstract mixin class _$ConfigurationDataCopyWith<$Res> implements $ConfigurationDataCopyWith<$Res> {
  factory _$ConfigurationDataCopyWith(_ConfigurationData value, $Res Function(_ConfigurationData) _then) = __$ConfigurationDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'apis_net_pe_key') String? apisNetPeKey,@JsonKey(name: 'config_password') String? configPassword
});




}
/// @nodoc
class __$ConfigurationDataCopyWithImpl<$Res>
    implements _$ConfigurationDataCopyWith<$Res> {
  __$ConfigurationDataCopyWithImpl(this._self, this._then);

  final _ConfigurationData _self;
  final $Res Function(_ConfigurationData) _then;

/// Create a copy of ConfigurationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? apisNetPeKey = freezed,Object? configPassword = freezed,}) {
  return _then(_ConfigurationData(
apisNetPeKey: freezed == apisNetPeKey ? _self.apisNetPeKey : apisNetPeKey // ignore: cast_nullable_to_non_nullable
as String?,configPassword: freezed == configPassword ? _self.configPassword : configPassword // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
