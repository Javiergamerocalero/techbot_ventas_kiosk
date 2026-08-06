// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentMethod {

 PaymentMethodType get type; bool get isActive; Map<String, dynamic>? get configuration;
/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentMethodCopyWith<PaymentMethod> get copyWith => _$PaymentMethodCopyWithImpl<PaymentMethod>(this as PaymentMethod, _$identity);

  /// Serializes this PaymentMethod to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethod&&(identical(other.type, type) || other.type == type)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.configuration, configuration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,isActive,const DeepCollectionEquality().hash(configuration));

@override
String toString() {
  return 'PaymentMethod(type: $type, isActive: $isActive, configuration: $configuration)';
}


}

/// @nodoc
abstract mixin class $PaymentMethodCopyWith<$Res>  {
  factory $PaymentMethodCopyWith(PaymentMethod value, $Res Function(PaymentMethod) _then) = _$PaymentMethodCopyWithImpl;
@useResult
$Res call({
 PaymentMethodType type, bool isActive, Map<String, dynamic>? configuration
});




}
/// @nodoc
class _$PaymentMethodCopyWithImpl<$Res>
    implements $PaymentMethodCopyWith<$Res> {
  _$PaymentMethodCopyWithImpl(this._self, this._then);

  final PaymentMethod _self;
  final $Res Function(PaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? isActive = null,Object? configuration = freezed,}) {
  return _then(_self.copyWith(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PaymentMethodType,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,configuration: freezed == configuration ? _self.configuration : configuration // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentMethod].
extension PaymentMethodPatterns on PaymentMethod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentMethod value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentMethod value)  $default,){
final _that = this;
switch (_that) {
case _PaymentMethod():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentMethod value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PaymentMethodType type,  bool isActive,  Map<String, dynamic>? configuration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
return $default(_that.type,_that.isActive,_that.configuration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PaymentMethodType type,  bool isActive,  Map<String, dynamic>? configuration)  $default,) {final _that = this;
switch (_that) {
case _PaymentMethod():
return $default(_that.type,_that.isActive,_that.configuration);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PaymentMethodType type,  bool isActive,  Map<String, dynamic>? configuration)?  $default,) {final _that = this;
switch (_that) {
case _PaymentMethod() when $default != null:
return $default(_that.type,_that.isActive,_that.configuration);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentMethod implements PaymentMethod {
  const _PaymentMethod({required this.type, this.isActive = false, final  Map<String, dynamic>? configuration}): _configuration = configuration;
  factory _PaymentMethod.fromJson(Map<String, dynamic> json) => _$PaymentMethodFromJson(json);

@override final  PaymentMethodType type;
@override@JsonKey() final  bool isActive;
 final  Map<String, dynamic>? _configuration;
@override Map<String, dynamic>? get configuration {
  final value = _configuration;
  if (value == null) return null;
  if (_configuration is EqualUnmodifiableMapView) return _configuration;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentMethodCopyWith<_PaymentMethod> get copyWith => __$PaymentMethodCopyWithImpl<_PaymentMethod>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentMethodToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentMethod&&(identical(other.type, type) || other.type == type)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._configuration, _configuration));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,type,isActive,const DeepCollectionEquality().hash(_configuration));

@override
String toString() {
  return 'PaymentMethod(type: $type, isActive: $isActive, configuration: $configuration)';
}


}

/// @nodoc
abstract mixin class _$PaymentMethodCopyWith<$Res> implements $PaymentMethodCopyWith<$Res> {
  factory _$PaymentMethodCopyWith(_PaymentMethod value, $Res Function(_PaymentMethod) _then) = __$PaymentMethodCopyWithImpl;
@override @useResult
$Res call({
 PaymentMethodType type, bool isActive, Map<String, dynamic>? configuration
});




}
/// @nodoc
class __$PaymentMethodCopyWithImpl<$Res>
    implements _$PaymentMethodCopyWith<$Res> {
  __$PaymentMethodCopyWithImpl(this._self, this._then);

  final _PaymentMethod _self;
  final $Res Function(_PaymentMethod) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? isActive = null,Object? configuration = freezed,}) {
  return _then(_PaymentMethod(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PaymentMethodType,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,configuration: freezed == configuration ? _self._configuration : configuration // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$PaymentMethodsConfig {

 List<PaymentMethod> get methods;
/// Create a copy of PaymentMethodsConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentMethodsConfigCopyWith<PaymentMethodsConfig> get copyWith => _$PaymentMethodsConfigCopyWithImpl<PaymentMethodsConfig>(this as PaymentMethodsConfig, _$identity);

  /// Serializes this PaymentMethodsConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethodsConfig&&const DeepCollectionEquality().equals(other.methods, methods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(methods));

@override
String toString() {
  return 'PaymentMethodsConfig(methods: $methods)';
}


}

/// @nodoc
abstract mixin class $PaymentMethodsConfigCopyWith<$Res>  {
  factory $PaymentMethodsConfigCopyWith(PaymentMethodsConfig value, $Res Function(PaymentMethodsConfig) _then) = _$PaymentMethodsConfigCopyWithImpl;
@useResult
$Res call({
 List<PaymentMethod> methods
});




}
/// @nodoc
class _$PaymentMethodsConfigCopyWithImpl<$Res>
    implements $PaymentMethodsConfigCopyWith<$Res> {
  _$PaymentMethodsConfigCopyWithImpl(this._self, this._then);

  final PaymentMethodsConfig _self;
  final $Res Function(PaymentMethodsConfig) _then;

/// Create a copy of PaymentMethodsConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? methods = null,}) {
  return _then(_self.copyWith(
methods: null == methods ? _self.methods : methods // ignore: cast_nullable_to_non_nullable
as List<PaymentMethod>,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentMethodsConfig].
extension PaymentMethodsConfigPatterns on PaymentMethodsConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentMethodsConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentMethodsConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentMethodsConfig value)  $default,){
final _that = this;
switch (_that) {
case _PaymentMethodsConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentMethodsConfig value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentMethodsConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<PaymentMethod> methods)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentMethodsConfig() when $default != null:
return $default(_that.methods);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<PaymentMethod> methods)  $default,) {final _that = this;
switch (_that) {
case _PaymentMethodsConfig():
return $default(_that.methods);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<PaymentMethod> methods)?  $default,) {final _that = this;
switch (_that) {
case _PaymentMethodsConfig() when $default != null:
return $default(_that.methods);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentMethodsConfig implements PaymentMethodsConfig {
  const _PaymentMethodsConfig({final  List<PaymentMethod> methods = const []}): _methods = methods;
  factory _PaymentMethodsConfig.fromJson(Map<String, dynamic> json) => _$PaymentMethodsConfigFromJson(json);

 final  List<PaymentMethod> _methods;
@override@JsonKey() List<PaymentMethod> get methods {
  if (_methods is EqualUnmodifiableListView) return _methods;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_methods);
}


/// Create a copy of PaymentMethodsConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentMethodsConfigCopyWith<_PaymentMethodsConfig> get copyWith => __$PaymentMethodsConfigCopyWithImpl<_PaymentMethodsConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentMethodsConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentMethodsConfig&&const DeepCollectionEquality().equals(other._methods, _methods));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_methods));

@override
String toString() {
  return 'PaymentMethodsConfig(methods: $methods)';
}


}

/// @nodoc
abstract mixin class _$PaymentMethodsConfigCopyWith<$Res> implements $PaymentMethodsConfigCopyWith<$Res> {
  factory _$PaymentMethodsConfigCopyWith(_PaymentMethodsConfig value, $Res Function(_PaymentMethodsConfig) _then) = __$PaymentMethodsConfigCopyWithImpl;
@override @useResult
$Res call({
 List<PaymentMethod> methods
});




}
/// @nodoc
class __$PaymentMethodsConfigCopyWithImpl<$Res>
    implements _$PaymentMethodsConfigCopyWith<$Res> {
  __$PaymentMethodsConfigCopyWithImpl(this._self, this._then);

  final _PaymentMethodsConfig _self;
  final $Res Function(_PaymentMethodsConfig) _then;

/// Create a copy of PaymentMethodsConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? methods = null,}) {
  return _then(_PaymentMethodsConfig(
methods: null == methods ? _self._methods : methods // ignore: cast_nullable_to_non_nullable
as List<PaymentMethod>,
  ));
}


}

// dart format on
