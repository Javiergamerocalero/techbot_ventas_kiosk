// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'license_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LicenseData implements DiagnosticableTreeMixin {

 int get id;@JsonKey(name: 'tenant_id') int get tenantId; String get type; String get duration; String get key;@JsonKey(name: 'expiration_date') String get expirationDate;@JsonKey(name: 'activation_status') bool get activationStatus;@JsonKey(name: 'device_id') String get deviceId;@JsonKey(name: 'device_name') String get deviceName;@JsonKey(name: 'app_version') String get appVersion;@JsonKey(name: 'latest_version') String get latestVersion;@JsonKey(name: 'download_link') String get downloadLink;@JsonKey(name: 'business_info') BusinessInfo? get businessInfo;
/// Create a copy of LicenseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LicenseDataCopyWith<LicenseData> get copyWith => _$LicenseDataCopyWithImpl<LicenseData>(this as LicenseData, _$identity);

  /// Serializes this LicenseData to a JSON map.
  Map<String, dynamic> toJson();

@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LicenseData'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('tenantId', tenantId))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('duration', duration))..add(DiagnosticsProperty('key', key))..add(DiagnosticsProperty('expirationDate', expirationDate))..add(DiagnosticsProperty('activationStatus', activationStatus))..add(DiagnosticsProperty('deviceId', deviceId))..add(DiagnosticsProperty('deviceName', deviceName))..add(DiagnosticsProperty('appVersion', appVersion))..add(DiagnosticsProperty('latestVersion', latestVersion))..add(DiagnosticsProperty('downloadLink', downloadLink))..add(DiagnosticsProperty('businessInfo', businessInfo));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LicenseData&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.type, type) || other.type == type)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.key, key) || other.key == key)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.activationStatus, activationStatus) || other.activationStatus == activationStatus)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.latestVersion, latestVersion) || other.latestVersion == latestVersion)&&(identical(other.downloadLink, downloadLink) || other.downloadLink == downloadLink)&&(identical(other.businessInfo, businessInfo) || other.businessInfo == businessInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,type,duration,key,expirationDate,activationStatus,deviceId,deviceName,appVersion,latestVersion,downloadLink,businessInfo);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LicenseData(id: $id, tenantId: $tenantId, type: $type, duration: $duration, key: $key, expirationDate: $expirationDate, activationStatus: $activationStatus, deviceId: $deviceId, deviceName: $deviceName, appVersion: $appVersion, latestVersion: $latestVersion, downloadLink: $downloadLink, businessInfo: $businessInfo)';
}


}

/// @nodoc
abstract mixin class $LicenseDataCopyWith<$Res>  {
  factory $LicenseDataCopyWith(LicenseData value, $Res Function(LicenseData) _then) = _$LicenseDataCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'tenant_id') int tenantId, String type, String duration, String key,@JsonKey(name: 'expiration_date') String expirationDate,@JsonKey(name: 'activation_status') bool activationStatus,@JsonKey(name: 'device_id') String deviceId,@JsonKey(name: 'device_name') String deviceName,@JsonKey(name: 'app_version') String appVersion,@JsonKey(name: 'latest_version') String latestVersion,@JsonKey(name: 'download_link') String downloadLink,@JsonKey(name: 'business_info') BusinessInfo? businessInfo
});


$BusinessInfoCopyWith<$Res>? get businessInfo;

}
/// @nodoc
class _$LicenseDataCopyWithImpl<$Res>
    implements $LicenseDataCopyWith<$Res> {
  _$LicenseDataCopyWithImpl(this._self, this._then);

  final LicenseData _self;
  final $Res Function(LicenseData) _then;

/// Create a copy of LicenseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? tenantId = null,Object? type = null,Object? duration = null,Object? key = null,Object? expirationDate = null,Object? activationStatus = null,Object? deviceId = null,Object? deviceName = null,Object? appVersion = null,Object? latestVersion = null,Object? downloadLink = null,Object? businessInfo = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,expirationDate: null == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as String,activationStatus: null == activationStatus ? _self.activationStatus : activationStatus // ignore: cast_nullable_to_non_nullable
as bool,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,latestVersion: null == latestVersion ? _self.latestVersion : latestVersion // ignore: cast_nullable_to_non_nullable
as String,downloadLink: null == downloadLink ? _self.downloadLink : downloadLink // ignore: cast_nullable_to_non_nullable
as String,businessInfo: freezed == businessInfo ? _self.businessInfo : businessInfo // ignore: cast_nullable_to_non_nullable
as BusinessInfo?,
  ));
}
/// Create a copy of LicenseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessInfoCopyWith<$Res>? get businessInfo {
    if (_self.businessInfo == null) {
    return null;
  }

  return $BusinessInfoCopyWith<$Res>(_self.businessInfo!, (value) {
    return _then(_self.copyWith(businessInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [LicenseData].
extension LicenseDataPatterns on LicenseData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LicenseData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LicenseData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LicenseData value)  $default,){
final _that = this;
switch (_that) {
case _LicenseData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LicenseData value)?  $default,){
final _that = this;
switch (_that) {
case _LicenseData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'tenant_id')  int tenantId,  String type,  String duration,  String key, @JsonKey(name: 'expiration_date')  String expirationDate, @JsonKey(name: 'activation_status')  bool activationStatus, @JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'device_name')  String deviceName, @JsonKey(name: 'app_version')  String appVersion, @JsonKey(name: 'latest_version')  String latestVersion, @JsonKey(name: 'download_link')  String downloadLink, @JsonKey(name: 'business_info')  BusinessInfo? businessInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LicenseData() when $default != null:
return $default(_that.id,_that.tenantId,_that.type,_that.duration,_that.key,_that.expirationDate,_that.activationStatus,_that.deviceId,_that.deviceName,_that.appVersion,_that.latestVersion,_that.downloadLink,_that.businessInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'tenant_id')  int tenantId,  String type,  String duration,  String key, @JsonKey(name: 'expiration_date')  String expirationDate, @JsonKey(name: 'activation_status')  bool activationStatus, @JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'device_name')  String deviceName, @JsonKey(name: 'app_version')  String appVersion, @JsonKey(name: 'latest_version')  String latestVersion, @JsonKey(name: 'download_link')  String downloadLink, @JsonKey(name: 'business_info')  BusinessInfo? businessInfo)  $default,) {final _that = this;
switch (_that) {
case _LicenseData():
return $default(_that.id,_that.tenantId,_that.type,_that.duration,_that.key,_that.expirationDate,_that.activationStatus,_that.deviceId,_that.deviceName,_that.appVersion,_that.latestVersion,_that.downloadLink,_that.businessInfo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'tenant_id')  int tenantId,  String type,  String duration,  String key, @JsonKey(name: 'expiration_date')  String expirationDate, @JsonKey(name: 'activation_status')  bool activationStatus, @JsonKey(name: 'device_id')  String deviceId, @JsonKey(name: 'device_name')  String deviceName, @JsonKey(name: 'app_version')  String appVersion, @JsonKey(name: 'latest_version')  String latestVersion, @JsonKey(name: 'download_link')  String downloadLink, @JsonKey(name: 'business_info')  BusinessInfo? businessInfo)?  $default,) {final _that = this;
switch (_that) {
case _LicenseData() when $default != null:
return $default(_that.id,_that.tenantId,_that.type,_that.duration,_that.key,_that.expirationDate,_that.activationStatus,_that.deviceId,_that.deviceName,_that.appVersion,_that.latestVersion,_that.downloadLink,_that.businessInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LicenseData with DiagnosticableTreeMixin implements LicenseData {
  const _LicenseData({this.id = -1, @JsonKey(name: 'tenant_id') this.tenantId = -1, this.type = '', this.duration = '', this.key = '', @JsonKey(name: 'expiration_date') this.expirationDate = '', @JsonKey(name: 'activation_status') this.activationStatus = false, @JsonKey(name: 'device_id') this.deviceId = '', @JsonKey(name: 'device_name') this.deviceName = '', @JsonKey(name: 'app_version') this.appVersion = '', @JsonKey(name: 'latest_version') this.latestVersion = '', @JsonKey(name: 'download_link') this.downloadLink = '', @JsonKey(name: 'business_info') this.businessInfo});
  factory _LicenseData.fromJson(Map<String, dynamic> json) => _$LicenseDataFromJson(json);

@override@JsonKey() final  int id;
@override@JsonKey(name: 'tenant_id') final  int tenantId;
@override@JsonKey() final  String type;
@override@JsonKey() final  String duration;
@override@JsonKey() final  String key;
@override@JsonKey(name: 'expiration_date') final  String expirationDate;
@override@JsonKey(name: 'activation_status') final  bool activationStatus;
@override@JsonKey(name: 'device_id') final  String deviceId;
@override@JsonKey(name: 'device_name') final  String deviceName;
@override@JsonKey(name: 'app_version') final  String appVersion;
@override@JsonKey(name: 'latest_version') final  String latestVersion;
@override@JsonKey(name: 'download_link') final  String downloadLink;
@override@JsonKey(name: 'business_info') final  BusinessInfo? businessInfo;

/// Create a copy of LicenseData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LicenseDataCopyWith<_LicenseData> get copyWith => __$LicenseDataCopyWithImpl<_LicenseData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LicenseDataToJson(this, );
}
@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'LicenseData'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('tenantId', tenantId))..add(DiagnosticsProperty('type', type))..add(DiagnosticsProperty('duration', duration))..add(DiagnosticsProperty('key', key))..add(DiagnosticsProperty('expirationDate', expirationDate))..add(DiagnosticsProperty('activationStatus', activationStatus))..add(DiagnosticsProperty('deviceId', deviceId))..add(DiagnosticsProperty('deviceName', deviceName))..add(DiagnosticsProperty('appVersion', appVersion))..add(DiagnosticsProperty('latestVersion', latestVersion))..add(DiagnosticsProperty('downloadLink', downloadLink))..add(DiagnosticsProperty('businessInfo', businessInfo));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LicenseData&&(identical(other.id, id) || other.id == id)&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.type, type) || other.type == type)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.key, key) || other.key == key)&&(identical(other.expirationDate, expirationDate) || other.expirationDate == expirationDate)&&(identical(other.activationStatus, activationStatus) || other.activationStatus == activationStatus)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.latestVersion, latestVersion) || other.latestVersion == latestVersion)&&(identical(other.downloadLink, downloadLink) || other.downloadLink == downloadLink)&&(identical(other.businessInfo, businessInfo) || other.businessInfo == businessInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,tenantId,type,duration,key,expirationDate,activationStatus,deviceId,deviceName,appVersion,latestVersion,downloadLink,businessInfo);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'LicenseData(id: $id, tenantId: $tenantId, type: $type, duration: $duration, key: $key, expirationDate: $expirationDate, activationStatus: $activationStatus, deviceId: $deviceId, deviceName: $deviceName, appVersion: $appVersion, latestVersion: $latestVersion, downloadLink: $downloadLink, businessInfo: $businessInfo)';
}


}

/// @nodoc
abstract mixin class _$LicenseDataCopyWith<$Res> implements $LicenseDataCopyWith<$Res> {
  factory _$LicenseDataCopyWith(_LicenseData value, $Res Function(_LicenseData) _then) = __$LicenseDataCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'tenant_id') int tenantId, String type, String duration, String key,@JsonKey(name: 'expiration_date') String expirationDate,@JsonKey(name: 'activation_status') bool activationStatus,@JsonKey(name: 'device_id') String deviceId,@JsonKey(name: 'device_name') String deviceName,@JsonKey(name: 'app_version') String appVersion,@JsonKey(name: 'latest_version') String latestVersion,@JsonKey(name: 'download_link') String downloadLink,@JsonKey(name: 'business_info') BusinessInfo? businessInfo
});


@override $BusinessInfoCopyWith<$Res>? get businessInfo;

}
/// @nodoc
class __$LicenseDataCopyWithImpl<$Res>
    implements _$LicenseDataCopyWith<$Res> {
  __$LicenseDataCopyWithImpl(this._self, this._then);

  final _LicenseData _self;
  final $Res Function(_LicenseData) _then;

/// Create a copy of LicenseData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? tenantId = null,Object? type = null,Object? duration = null,Object? key = null,Object? expirationDate = null,Object? activationStatus = null,Object? deviceId = null,Object? deviceName = null,Object? appVersion = null,Object? latestVersion = null,Object? downloadLink = null,Object? businessInfo = freezed,}) {
  return _then(_LicenseData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String,key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,expirationDate: null == expirationDate ? _self.expirationDate : expirationDate // ignore: cast_nullable_to_non_nullable
as String,activationStatus: null == activationStatus ? _self.activationStatus : activationStatus // ignore: cast_nullable_to_non_nullable
as bool,deviceId: null == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String,deviceName: null == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,latestVersion: null == latestVersion ? _self.latestVersion : latestVersion // ignore: cast_nullable_to_non_nullable
as String,downloadLink: null == downloadLink ? _self.downloadLink : downloadLink // ignore: cast_nullable_to_non_nullable
as String,businessInfo: freezed == businessInfo ? _self.businessInfo : businessInfo // ignore: cast_nullable_to_non_nullable
as BusinessInfo?,
  ));
}

/// Create a copy of LicenseData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessInfoCopyWith<$Res>? get businessInfo {
    if (_self.businessInfo == null) {
    return null;
  }

  return $BusinessInfoCopyWith<$Res>(_self.businessInfo!, (value) {
    return _then(_self.copyWith(businessInfo: value));
  });
}
}

// dart format on
