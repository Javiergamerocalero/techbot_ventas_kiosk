// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ThemeConfig {

 String get primary; String get secondary; String get tertiary; String get background; String get surface; String get onPrimary; String get onSecondary; String get onBackground; String get onSurface; String get error; String get onError;
/// Create a copy of ThemeConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeConfigCopyWith<ThemeConfig> get copyWith => _$ThemeConfigCopyWithImpl<ThemeConfig>(this as ThemeConfig, _$identity);

  /// Serializes this ThemeConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeConfig&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.secondary, secondary) || other.secondary == secondary)&&(identical(other.tertiary, tertiary) || other.tertiary == tertiary)&&(identical(other.background, background) || other.background == background)&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.onPrimary, onPrimary) || other.onPrimary == onPrimary)&&(identical(other.onSecondary, onSecondary) || other.onSecondary == onSecondary)&&(identical(other.onBackground, onBackground) || other.onBackground == onBackground)&&(identical(other.onSurface, onSurface) || other.onSurface == onSurface)&&(identical(other.error, error) || other.error == error)&&(identical(other.onError, onError) || other.onError == onError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,primary,secondary,tertiary,background,surface,onPrimary,onSecondary,onBackground,onSurface,error,onError);

@override
String toString() {
  return 'ThemeConfig(primary: $primary, secondary: $secondary, tertiary: $tertiary, background: $background, surface: $surface, onPrimary: $onPrimary, onSecondary: $onSecondary, onBackground: $onBackground, onSurface: $onSurface, error: $error, onError: $onError)';
}


}

/// @nodoc
abstract mixin class $ThemeConfigCopyWith<$Res>  {
  factory $ThemeConfigCopyWith(ThemeConfig value, $Res Function(ThemeConfig) _then) = _$ThemeConfigCopyWithImpl;
@useResult
$Res call({
 String primary, String secondary, String tertiary, String background, String surface, String onPrimary, String onSecondary, String onBackground, String onSurface, String error, String onError
});




}
/// @nodoc
class _$ThemeConfigCopyWithImpl<$Res>
    implements $ThemeConfigCopyWith<$Res> {
  _$ThemeConfigCopyWithImpl(this._self, this._then);

  final ThemeConfig _self;
  final $Res Function(ThemeConfig) _then;

/// Create a copy of ThemeConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? primary = null,Object? secondary = null,Object? tertiary = null,Object? background = null,Object? surface = null,Object? onPrimary = null,Object? onSecondary = null,Object? onBackground = null,Object? onSurface = null,Object? error = null,Object? onError = null,}) {
  return _then(_self.copyWith(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as String,secondary: null == secondary ? _self.secondary : secondary // ignore: cast_nullable_to_non_nullable
as String,tertiary: null == tertiary ? _self.tertiary : tertiary // ignore: cast_nullable_to_non_nullable
as String,background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as String,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as String,onPrimary: null == onPrimary ? _self.onPrimary : onPrimary // ignore: cast_nullable_to_non_nullable
as String,onSecondary: null == onSecondary ? _self.onSecondary : onSecondary // ignore: cast_nullable_to_non_nullable
as String,onBackground: null == onBackground ? _self.onBackground : onBackground // ignore: cast_nullable_to_non_nullable
as String,onSurface: null == onSurface ? _self.onSurface : onSurface // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ThemeConfig].
extension ThemeConfigPatterns on ThemeConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThemeConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThemeConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThemeConfig value)  $default,){
final _that = this;
switch (_that) {
case _ThemeConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThemeConfig value)?  $default,){
final _that = this;
switch (_that) {
case _ThemeConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String primary,  String secondary,  String tertiary,  String background,  String surface,  String onPrimary,  String onSecondary,  String onBackground,  String onSurface,  String error,  String onError)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThemeConfig() when $default != null:
return $default(_that.primary,_that.secondary,_that.tertiary,_that.background,_that.surface,_that.onPrimary,_that.onSecondary,_that.onBackground,_that.onSurface,_that.error,_that.onError);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String primary,  String secondary,  String tertiary,  String background,  String surface,  String onPrimary,  String onSecondary,  String onBackground,  String onSurface,  String error,  String onError)  $default,) {final _that = this;
switch (_that) {
case _ThemeConfig():
return $default(_that.primary,_that.secondary,_that.tertiary,_that.background,_that.surface,_that.onPrimary,_that.onSecondary,_that.onBackground,_that.onSurface,_that.error,_that.onError);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String primary,  String secondary,  String tertiary,  String background,  String surface,  String onPrimary,  String onSecondary,  String onBackground,  String onSurface,  String error,  String onError)?  $default,) {final _that = this;
switch (_that) {
case _ThemeConfig() when $default != null:
return $default(_that.primary,_that.secondary,_that.tertiary,_that.background,_that.surface,_that.onPrimary,_that.onSecondary,_that.onBackground,_that.onSurface,_that.error,_that.onError);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ThemeConfig implements ThemeConfig {
  const _ThemeConfig({required this.primary, required this.secondary, this.tertiary = '', this.background = '', this.surface = '', this.onPrimary = '', this.onSecondary = '', this.onBackground = '', this.onSurface = '', this.error = '', this.onError = ''});
  factory _ThemeConfig.fromJson(Map<String, dynamic> json) => _$ThemeConfigFromJson(json);

@override final  String primary;
@override final  String secondary;
@override@JsonKey() final  String tertiary;
@override@JsonKey() final  String background;
@override@JsonKey() final  String surface;
@override@JsonKey() final  String onPrimary;
@override@JsonKey() final  String onSecondary;
@override@JsonKey() final  String onBackground;
@override@JsonKey() final  String onSurface;
@override@JsonKey() final  String error;
@override@JsonKey() final  String onError;

/// Create a copy of ThemeConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemeConfigCopyWith<_ThemeConfig> get copyWith => __$ThemeConfigCopyWithImpl<_ThemeConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ThemeConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemeConfig&&(identical(other.primary, primary) || other.primary == primary)&&(identical(other.secondary, secondary) || other.secondary == secondary)&&(identical(other.tertiary, tertiary) || other.tertiary == tertiary)&&(identical(other.background, background) || other.background == background)&&(identical(other.surface, surface) || other.surface == surface)&&(identical(other.onPrimary, onPrimary) || other.onPrimary == onPrimary)&&(identical(other.onSecondary, onSecondary) || other.onSecondary == onSecondary)&&(identical(other.onBackground, onBackground) || other.onBackground == onBackground)&&(identical(other.onSurface, onSurface) || other.onSurface == onSurface)&&(identical(other.error, error) || other.error == error)&&(identical(other.onError, onError) || other.onError == onError));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,primary,secondary,tertiary,background,surface,onPrimary,onSecondary,onBackground,onSurface,error,onError);

@override
String toString() {
  return 'ThemeConfig(primary: $primary, secondary: $secondary, tertiary: $tertiary, background: $background, surface: $surface, onPrimary: $onPrimary, onSecondary: $onSecondary, onBackground: $onBackground, onSurface: $onSurface, error: $error, onError: $onError)';
}


}

/// @nodoc
abstract mixin class _$ThemeConfigCopyWith<$Res> implements $ThemeConfigCopyWith<$Res> {
  factory _$ThemeConfigCopyWith(_ThemeConfig value, $Res Function(_ThemeConfig) _then) = __$ThemeConfigCopyWithImpl;
@override @useResult
$Res call({
 String primary, String secondary, String tertiary, String background, String surface, String onPrimary, String onSecondary, String onBackground, String onSurface, String error, String onError
});




}
/// @nodoc
class __$ThemeConfigCopyWithImpl<$Res>
    implements _$ThemeConfigCopyWith<$Res> {
  __$ThemeConfigCopyWithImpl(this._self, this._then);

  final _ThemeConfig _self;
  final $Res Function(_ThemeConfig) _then;

/// Create a copy of ThemeConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? primary = null,Object? secondary = null,Object? tertiary = null,Object? background = null,Object? surface = null,Object? onPrimary = null,Object? onSecondary = null,Object? onBackground = null,Object? onSurface = null,Object? error = null,Object? onError = null,}) {
  return _then(_ThemeConfig(
primary: null == primary ? _self.primary : primary // ignore: cast_nullable_to_non_nullable
as String,secondary: null == secondary ? _self.secondary : secondary // ignore: cast_nullable_to_non_nullable
as String,tertiary: null == tertiary ? _self.tertiary : tertiary // ignore: cast_nullable_to_non_nullable
as String,background: null == background ? _self.background : background // ignore: cast_nullable_to_non_nullable
as String,surface: null == surface ? _self.surface : surface // ignore: cast_nullable_to_non_nullable
as String,onPrimary: null == onPrimary ? _self.onPrimary : onPrimary // ignore: cast_nullable_to_non_nullable
as String,onSecondary: null == onSecondary ? _self.onSecondary : onSecondary // ignore: cast_nullable_to_non_nullable
as String,onBackground: null == onBackground ? _self.onBackground : onBackground // ignore: cast_nullable_to_non_nullable
as String,onSurface: null == onSurface ? _self.onSurface : onSurface // ignore: cast_nullable_to_non_nullable
as String,error: null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,onError: null == onError ? _self.onError : onError // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
