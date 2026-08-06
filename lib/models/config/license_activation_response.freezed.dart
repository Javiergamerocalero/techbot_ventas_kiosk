// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'license_activation_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LicenseActivationResponse implements DiagnosticableTreeMixin {

 bool get success; LicenseData? get licenseData; ThemeConfig? get themeConfig;// ← Campo para el tema
 ConfigurationData? get configurationData;// ← Nuevo campo para la configuración
 String? get errorMessage; Map<String, dynamic>? get errorDetails; int? get statusCode;
/// Create a copy of LicenseActivationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LicenseActivationResponseCopyWith<LicenseActivationResponse> get copyWith => _$LicenseActivationResponseCopyWithImpl<LicenseActivationResponse>(this as LicenseActivationResponse, _$identity);

  /// Serializes this LicenseActivationResponse to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LicenseActivationResponse'))
    ..add(DiagnosticsProperty('success', success))..add(DiagnosticsProperty('licenseData', licenseData))..add(DiagnosticsProperty('themeConfig', themeConfig))..add(DiagnosticsProperty('configurationData', configurationData))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('errorDetails', errorDetails))..add(DiagnosticsProperty('statusCode', statusCode));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LicenseActivationResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.licenseData, licenseData) || other.licenseData == licenseData)&&(identical(other.themeConfig, themeConfig) || other.themeConfig == themeConfig)&&(identical(other.configurationData, configurationData) || other.configurationData == configurationData)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other.errorDetails, errorDetails)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,licenseData,themeConfig,configurationData,errorMessage,const DeepCollectionEquality().hash(errorDetails),statusCode);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LicenseActivationResponse(success: $success, licenseData: $licenseData, themeConfig: $themeConfig, configurationData: $configurationData, errorMessage: $errorMessage, errorDetails: $errorDetails, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class $LicenseActivationResponseCopyWith<$Res>  {
  factory $LicenseActivationResponseCopyWith(LicenseActivationResponse value, $Res Function(LicenseActivationResponse) _then) = _$LicenseActivationResponseCopyWithImpl;
@useResult
$Res call({
 bool success, LicenseData? licenseData, ThemeConfig? themeConfig, ConfigurationData? configurationData, String? errorMessage, Map<String, dynamic>? errorDetails, int? statusCode
});


$LicenseDataCopyWith<$Res>? get licenseData;$ThemeConfigCopyWith<$Res>? get themeConfig;$ConfigurationDataCopyWith<$Res>? get configurationData;

}
/// @nodoc
class _$LicenseActivationResponseCopyWithImpl<$Res>
    implements $LicenseActivationResponseCopyWith<$Res> {
  _$LicenseActivationResponseCopyWithImpl(this._self, this._then);

  final LicenseActivationResponse _self;
  final $Res Function(LicenseActivationResponse) _then;

/// Create a copy of LicenseActivationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? licenseData = freezed,Object? themeConfig = freezed,Object? configurationData = freezed,Object? errorMessage = freezed,Object? errorDetails = freezed,Object? statusCode = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,licenseData: freezed == licenseData ? _self.licenseData : licenseData // ignore: cast_nullable_to_non_nullable
as LicenseData?,themeConfig: freezed == themeConfig ? _self.themeConfig : themeConfig // ignore: cast_nullable_to_non_nullable
as ThemeConfig?,configurationData: freezed == configurationData ? _self.configurationData : configurationData // ignore: cast_nullable_to_non_nullable
as ConfigurationData?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorDetails: freezed == errorDetails ? _self.errorDetails : errorDetails // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of LicenseActivationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LicenseDataCopyWith<$Res>? get licenseData {
    if (_self.licenseData == null) {
    return null;
  }

  return $LicenseDataCopyWith<$Res>(_self.licenseData!, (value) {
    return _then(_self.copyWith(licenseData: value));
  });
}/// Create a copy of LicenseActivationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemeConfigCopyWith<$Res>? get themeConfig {
    if (_self.themeConfig == null) {
    return null;
  }

  return $ThemeConfigCopyWith<$Res>(_self.themeConfig!, (value) {
    return _then(_self.copyWith(themeConfig: value));
  });
}/// Create a copy of LicenseActivationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfigurationDataCopyWith<$Res>? get configurationData {
    if (_self.configurationData == null) {
    return null;
  }

  return $ConfigurationDataCopyWith<$Res>(_self.configurationData!, (value) {
    return _then(_self.copyWith(configurationData: value));
  });
}
}


/// Adds pattern-matching-related methods to [LicenseActivationResponse].
extension LicenseActivationResponsePatterns on LicenseActivationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LicenseActivationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LicenseActivationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LicenseActivationResponse value)  $default,){
final _that = this;
switch (_that) {
case _LicenseActivationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LicenseActivationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _LicenseActivationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  LicenseData? licenseData,  ThemeConfig? themeConfig,  ConfigurationData? configurationData,  String? errorMessage,  Map<String, dynamic>? errorDetails,  int? statusCode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LicenseActivationResponse() when $default != null:
return $default(_that.success,_that.licenseData,_that.themeConfig,_that.configurationData,_that.errorMessage,_that.errorDetails,_that.statusCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  LicenseData? licenseData,  ThemeConfig? themeConfig,  ConfigurationData? configurationData,  String? errorMessage,  Map<String, dynamic>? errorDetails,  int? statusCode)  $default,) {final _that = this;
switch (_that) {
case _LicenseActivationResponse():
return $default(_that.success,_that.licenseData,_that.themeConfig,_that.configurationData,_that.errorMessage,_that.errorDetails,_that.statusCode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  LicenseData? licenseData,  ThemeConfig? themeConfig,  ConfigurationData? configurationData,  String? errorMessage,  Map<String, dynamic>? errorDetails,  int? statusCode)?  $default,) {final _that = this;
switch (_that) {
case _LicenseActivationResponse() when $default != null:
return $default(_that.success,_that.licenseData,_that.themeConfig,_that.configurationData,_that.errorMessage,_that.errorDetails,_that.statusCode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LicenseActivationResponse extends LicenseActivationResponse with DiagnosticableTreeMixin {
  const _LicenseActivationResponse({required this.success, this.licenseData, this.themeConfig, this.configurationData, this.errorMessage, final  Map<String, dynamic>? errorDetails, this.statusCode}): _errorDetails = errorDetails,super._();
  factory _LicenseActivationResponse.fromJson(Map<String, dynamic> json) => _$LicenseActivationResponseFromJson(json);

@override final  bool success;
@override final  LicenseData? licenseData;
@override final  ThemeConfig? themeConfig;
// ← Campo para el tema
@override final  ConfigurationData? configurationData;
// ← Nuevo campo para la configuración
@override final  String? errorMessage;
 final  Map<String, dynamic>? _errorDetails;
@override Map<String, dynamic>? get errorDetails {
  final value = _errorDetails;
  if (value == null) return null;
  if (_errorDetails is EqualUnmodifiableMapView) return _errorDetails;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  int? statusCode;

/// Create a copy of LicenseActivationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LicenseActivationResponseCopyWith<_LicenseActivationResponse> get copyWith => __$LicenseActivationResponseCopyWithImpl<_LicenseActivationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LicenseActivationResponseToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LicenseActivationResponse'))
    ..add(DiagnosticsProperty('success', success))..add(DiagnosticsProperty('licenseData', licenseData))..add(DiagnosticsProperty('themeConfig', themeConfig))..add(DiagnosticsProperty('configurationData', configurationData))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('errorDetails', errorDetails))..add(DiagnosticsProperty('statusCode', statusCode));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LicenseActivationResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.licenseData, licenseData) || other.licenseData == licenseData)&&(identical(other.themeConfig, themeConfig) || other.themeConfig == themeConfig)&&(identical(other.configurationData, configurationData) || other.configurationData == configurationData)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&const DeepCollectionEquality().equals(other._errorDetails, _errorDetails)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,licenseData,themeConfig,configurationData,errorMessage,const DeepCollectionEquality().hash(_errorDetails),statusCode);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LicenseActivationResponse(success: $success, licenseData: $licenseData, themeConfig: $themeConfig, configurationData: $configurationData, errorMessage: $errorMessage, errorDetails: $errorDetails, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class _$LicenseActivationResponseCopyWith<$Res> implements $LicenseActivationResponseCopyWith<$Res> {
  factory _$LicenseActivationResponseCopyWith(_LicenseActivationResponse value, $Res Function(_LicenseActivationResponse) _then) = __$LicenseActivationResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, LicenseData? licenseData, ThemeConfig? themeConfig, ConfigurationData? configurationData, String? errorMessage, Map<String, dynamic>? errorDetails, int? statusCode
});


@override $LicenseDataCopyWith<$Res>? get licenseData;@override $ThemeConfigCopyWith<$Res>? get themeConfig;@override $ConfigurationDataCopyWith<$Res>? get configurationData;

}
/// @nodoc
class __$LicenseActivationResponseCopyWithImpl<$Res>
    implements _$LicenseActivationResponseCopyWith<$Res> {
  __$LicenseActivationResponseCopyWithImpl(this._self, this._then);

  final _LicenseActivationResponse _self;
  final $Res Function(_LicenseActivationResponse) _then;

/// Create a copy of LicenseActivationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? licenseData = freezed,Object? themeConfig = freezed,Object? configurationData = freezed,Object? errorMessage = freezed,Object? errorDetails = freezed,Object? statusCode = freezed,}) {
  return _then(_LicenseActivationResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,licenseData: freezed == licenseData ? _self.licenseData : licenseData // ignore: cast_nullable_to_non_nullable
as LicenseData?,themeConfig: freezed == themeConfig ? _self.themeConfig : themeConfig // ignore: cast_nullable_to_non_nullable
as ThemeConfig?,configurationData: freezed == configurationData ? _self.configurationData : configurationData // ignore: cast_nullable_to_non_nullable
as ConfigurationData?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorDetails: freezed == errorDetails ? _self._errorDetails : errorDetails // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of LicenseActivationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LicenseDataCopyWith<$Res>? get licenseData {
    if (_self.licenseData == null) {
    return null;
  }

  return $LicenseDataCopyWith<$Res>(_self.licenseData!, (value) {
    return _then(_self.copyWith(licenseData: value));
  });
}/// Create a copy of LicenseActivationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ThemeConfigCopyWith<$Res>? get themeConfig {
    if (_self.themeConfig == null) {
    return null;
  }

  return $ThemeConfigCopyWith<$Res>(_self.themeConfig!, (value) {
    return _then(_self.copyWith(themeConfig: value));
  });
}/// Create a copy of LicenseActivationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfigurationDataCopyWith<$Res>? get configurationData {
    if (_self.configurationData == null) {
    return null;
  }

  return $ConfigurationDataCopyWith<$Res>(_self.configurationData!, (value) {
    return _then(_self.copyWith(configurationData: value));
  });
}
}

// dart format on
