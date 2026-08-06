// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppConfig {

 Map<String, dynamic> get styles; Map<String, dynamic> get layout; String? get logoUrl; Map<String, dynamic>? get extras;
/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppConfigCopyWith<AppConfig> get copyWith => _$AppConfigCopyWithImpl<AppConfig>(this as AppConfig, _$identity);

  /// Serializes this AppConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppConfig&&const DeepCollectionEquality().equals(other.styles, styles)&&const DeepCollectionEquality().equals(other.layout, layout)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&const DeepCollectionEquality().equals(other.extras, extras));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(styles),const DeepCollectionEquality().hash(layout),logoUrl,const DeepCollectionEquality().hash(extras));

@override
String toString() {
  return 'AppConfig(styles: $styles, layout: $layout, logoUrl: $logoUrl, extras: $extras)';
}


}

/// @nodoc
abstract mixin class $AppConfigCopyWith<$Res>  {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) _then) = _$AppConfigCopyWithImpl;
@useResult
$Res call({
 Map<String, dynamic> styles, Map<String, dynamic> layout, String? logoUrl, Map<String, dynamic>? extras
});




}
/// @nodoc
class _$AppConfigCopyWithImpl<$Res>
    implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._self, this._then);

  final AppConfig _self;
  final $Res Function(AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? styles = null,Object? layout = null,Object? logoUrl = freezed,Object? extras = freezed,}) {
  return _then(_self.copyWith(
styles: null == styles ? _self.styles : styles // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,layout: null == layout ? _self.layout : layout // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,extras: freezed == extras ? _self.extras : extras // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppConfig].
extension AppConfigPatterns on AppConfig {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppConfig value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppConfig value)  $default,){
final _that = this;
switch (_that) {
case _AppConfig():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppConfig value)?  $default,){
final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<String, dynamic> styles,  Map<String, dynamic> layout,  String? logoUrl,  Map<String, dynamic>? extras)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that.styles,_that.layout,_that.logoUrl,_that.extras);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<String, dynamic> styles,  Map<String, dynamic> layout,  String? logoUrl,  Map<String, dynamic>? extras)  $default,) {final _that = this;
switch (_that) {
case _AppConfig():
return $default(_that.styles,_that.layout,_that.logoUrl,_that.extras);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<String, dynamic> styles,  Map<String, dynamic> layout,  String? logoUrl,  Map<String, dynamic>? extras)?  $default,) {final _that = this;
switch (_that) {
case _AppConfig() when $default != null:
return $default(_that.styles,_that.layout,_that.logoUrl,_that.extras);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppConfig implements AppConfig {
  const _AppConfig({required final  Map<String, dynamic> styles, required final  Map<String, dynamic> layout, this.logoUrl, final  Map<String, dynamic>? extras}): _styles = styles,_layout = layout,_extras = extras;
  factory _AppConfig.fromJson(Map<String, dynamic> json) => _$AppConfigFromJson(json);

 final  Map<String, dynamic> _styles;
@override Map<String, dynamic> get styles {
  if (_styles is EqualUnmodifiableMapView) return _styles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_styles);
}

 final  Map<String, dynamic> _layout;
@override Map<String, dynamic> get layout {
  if (_layout is EqualUnmodifiableMapView) return _layout;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_layout);
}

@override final  String? logoUrl;
 final  Map<String, dynamic>? _extras;
@override Map<String, dynamic>? get extras {
  final value = _extras;
  if (value == null) return null;
  if (_extras is EqualUnmodifiableMapView) return _extras;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppConfigCopyWith<_AppConfig> get copyWith => __$AppConfigCopyWithImpl<_AppConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppConfig&&const DeepCollectionEquality().equals(other._styles, _styles)&&const DeepCollectionEquality().equals(other._layout, _layout)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&const DeepCollectionEquality().equals(other._extras, _extras));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_styles),const DeepCollectionEquality().hash(_layout),logoUrl,const DeepCollectionEquality().hash(_extras));

@override
String toString() {
  return 'AppConfig(styles: $styles, layout: $layout, logoUrl: $logoUrl, extras: $extras)';
}


}

/// @nodoc
abstract mixin class _$AppConfigCopyWith<$Res> implements $AppConfigCopyWith<$Res> {
  factory _$AppConfigCopyWith(_AppConfig value, $Res Function(_AppConfig) _then) = __$AppConfigCopyWithImpl;
@override @useResult
$Res call({
 Map<String, dynamic> styles, Map<String, dynamic> layout, String? logoUrl, Map<String, dynamic>? extras
});




}
/// @nodoc
class __$AppConfigCopyWithImpl<$Res>
    implements _$AppConfigCopyWith<$Res> {
  __$AppConfigCopyWithImpl(this._self, this._then);

  final _AppConfig _self;
  final $Res Function(_AppConfig) _then;

/// Create a copy of AppConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? styles = null,Object? layout = null,Object? logoUrl = freezed,Object? extras = freezed,}) {
  return _then(_AppConfig(
styles: null == styles ? _self._styles : styles // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,layout: null == layout ? _self._layout : layout // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,extras: freezed == extras ? _self._extras : extras // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
