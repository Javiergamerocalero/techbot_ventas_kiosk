// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'icon_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
AppIconData _$AppIconDataFromJson(
  Map<String, dynamic> json
) {
        switch (json['runtimeType']) {
                  case 'material':
          return MaterialIconData.fromJson(
            json
          );
                case 'asset':
          return AssetIconData.fromJson(
            json
          );
        
          default:
            throw CheckedFromJsonException(
  json,
  'runtimeType',
  'AppIconData',
  'Invalid union type "${json['runtimeType']}"!'
);
        }
      
}

/// @nodoc
mixin _$AppIconData {

 int get codePoint; String get fontFamily; bool get isMaterialIcon; String? get iconName; String? get assetPath;
/// Create a copy of AppIconData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppIconDataCopyWith<AppIconData> get copyWith => _$AppIconDataCopyWithImpl<AppIconData>(this as AppIconData, _$identity);

  /// Serializes this AppIconData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppIconData&&(identical(other.codePoint, codePoint) || other.codePoint == codePoint)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.isMaterialIcon, isMaterialIcon) || other.isMaterialIcon == isMaterialIcon)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,codePoint,fontFamily,isMaterialIcon,iconName,assetPath);

@override
String toString() {
  return 'AppIconData(codePoint: $codePoint, fontFamily: $fontFamily, isMaterialIcon: $isMaterialIcon, iconName: $iconName, assetPath: $assetPath)';
}


}

/// @nodoc
abstract mixin class $AppIconDataCopyWith<$Res>  {
  factory $AppIconDataCopyWith(AppIconData value, $Res Function(AppIconData) _then) = _$AppIconDataCopyWithImpl;
@useResult
$Res call({
 int codePoint, String fontFamily, bool isMaterialIcon, String? iconName, String? assetPath
});




}
/// @nodoc
class _$AppIconDataCopyWithImpl<$Res>
    implements $AppIconDataCopyWith<$Res> {
  _$AppIconDataCopyWithImpl(this._self, this._then);

  final AppIconData _self;
  final $Res Function(AppIconData) _then;

/// Create a copy of AppIconData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? codePoint = null,Object? fontFamily = null,Object? isMaterialIcon = null,Object? iconName = freezed,Object? assetPath = freezed,}) {
  return _then(_self.copyWith(
codePoint: null == codePoint ? _self.codePoint : codePoint // ignore: cast_nullable_to_non_nullable
as int,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,isMaterialIcon: null == isMaterialIcon ? _self.isMaterialIcon : isMaterialIcon // ignore: cast_nullable_to_non_nullable
as bool,iconName: freezed == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String?,assetPath: freezed == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppIconData].
extension AppIconDataPatterns on AppIconData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( MaterialIconData value)?  material,TResult Function( AssetIconData value)?  asset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case MaterialIconData() when material != null:
return material(_that);case AssetIconData() when asset != null:
return asset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( MaterialIconData value)  material,required TResult Function( AssetIconData value)  asset,}){
final _that = this;
switch (_that) {
case MaterialIconData():
return material(_that);case AssetIconData():
return asset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( MaterialIconData value)?  material,TResult? Function( AssetIconData value)?  asset,}){
final _that = this;
switch (_that) {
case MaterialIconData() when material != null:
return material(_that);case AssetIconData() when asset != null:
return asset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int codePoint,  String fontFamily,  bool isMaterialIcon,  String? iconName,  String? assetPath)?  material,TResult Function( int codePoint,  String fontFamily,  bool isMaterialIcon,  String? iconName,  String? assetPath)?  asset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case MaterialIconData() when material != null:
return material(_that.codePoint,_that.fontFamily,_that.isMaterialIcon,_that.iconName,_that.assetPath);case AssetIconData() when asset != null:
return asset(_that.codePoint,_that.fontFamily,_that.isMaterialIcon,_that.iconName,_that.assetPath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int codePoint,  String fontFamily,  bool isMaterialIcon,  String? iconName,  String? assetPath)  material,required TResult Function( int codePoint,  String fontFamily,  bool isMaterialIcon,  String? iconName,  String? assetPath)  asset,}) {final _that = this;
switch (_that) {
case MaterialIconData():
return material(_that.codePoint,_that.fontFamily,_that.isMaterialIcon,_that.iconName,_that.assetPath);case AssetIconData():
return asset(_that.codePoint,_that.fontFamily,_that.isMaterialIcon,_that.iconName,_that.assetPath);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int codePoint,  String fontFamily,  bool isMaterialIcon,  String? iconName,  String? assetPath)?  material,TResult? Function( int codePoint,  String fontFamily,  bool isMaterialIcon,  String? iconName,  String? assetPath)?  asset,}) {final _that = this;
switch (_that) {
case MaterialIconData() when material != null:
return material(_that.codePoint,_that.fontFamily,_that.isMaterialIcon,_that.iconName,_that.assetPath);case AssetIconData() when asset != null:
return asset(_that.codePoint,_that.fontFamily,_that.isMaterialIcon,_that.iconName,_that.assetPath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class MaterialIconData implements AppIconData {
  const MaterialIconData({required this.codePoint, required this.fontFamily, required this.isMaterialIcon, this.iconName, this.assetPath, final  String? $type}): $type = $type ?? 'material';
  factory MaterialIconData.fromJson(Map<String, dynamic> json) => _$MaterialIconDataFromJson(json);

@override final  int codePoint;
@override final  String fontFamily;
@override final  bool isMaterialIcon;
@override final  String? iconName;
@override final  String? assetPath;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AppIconData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaterialIconDataCopyWith<MaterialIconData> get copyWith => _$MaterialIconDataCopyWithImpl<MaterialIconData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaterialIconDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaterialIconData&&(identical(other.codePoint, codePoint) || other.codePoint == codePoint)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.isMaterialIcon, isMaterialIcon) || other.isMaterialIcon == isMaterialIcon)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,codePoint,fontFamily,isMaterialIcon,iconName,assetPath);

@override
String toString() {
  return 'AppIconData.material(codePoint: $codePoint, fontFamily: $fontFamily, isMaterialIcon: $isMaterialIcon, iconName: $iconName, assetPath: $assetPath)';
}


}

/// @nodoc
abstract mixin class $MaterialIconDataCopyWith<$Res> implements $AppIconDataCopyWith<$Res> {
  factory $MaterialIconDataCopyWith(MaterialIconData value, $Res Function(MaterialIconData) _then) = _$MaterialIconDataCopyWithImpl;
@override @useResult
$Res call({
 int codePoint, String fontFamily, bool isMaterialIcon, String? iconName, String? assetPath
});




}
/// @nodoc
class _$MaterialIconDataCopyWithImpl<$Res>
    implements $MaterialIconDataCopyWith<$Res> {
  _$MaterialIconDataCopyWithImpl(this._self, this._then);

  final MaterialIconData _self;
  final $Res Function(MaterialIconData) _then;

/// Create a copy of AppIconData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? codePoint = null,Object? fontFamily = null,Object? isMaterialIcon = null,Object? iconName = freezed,Object? assetPath = freezed,}) {
  return _then(MaterialIconData(
codePoint: null == codePoint ? _self.codePoint : codePoint // ignore: cast_nullable_to_non_nullable
as int,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,isMaterialIcon: null == isMaterialIcon ? _self.isMaterialIcon : isMaterialIcon // ignore: cast_nullable_to_non_nullable
as bool,iconName: freezed == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String?,assetPath: freezed == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
@JsonSerializable()

class AssetIconData implements AppIconData {
  const AssetIconData({required this.codePoint, required this.fontFamily, required this.isMaterialIcon, this.iconName, this.assetPath, final  String? $type}): $type = $type ?? 'asset';
  factory AssetIconData.fromJson(Map<String, dynamic> json) => _$AssetIconDataFromJson(json);

@override final  int codePoint;
@override final  String fontFamily;
@override final  bool isMaterialIcon;
@override final  String? iconName;
@override final  String? assetPath;

@JsonKey(name: 'runtimeType')
final String $type;


/// Create a copy of AppIconData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssetIconDataCopyWith<AssetIconData> get copyWith => _$AssetIconDataCopyWithImpl<AssetIconData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssetIconDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssetIconData&&(identical(other.codePoint, codePoint) || other.codePoint == codePoint)&&(identical(other.fontFamily, fontFamily) || other.fontFamily == fontFamily)&&(identical(other.isMaterialIcon, isMaterialIcon) || other.isMaterialIcon == isMaterialIcon)&&(identical(other.iconName, iconName) || other.iconName == iconName)&&(identical(other.assetPath, assetPath) || other.assetPath == assetPath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,codePoint,fontFamily,isMaterialIcon,iconName,assetPath);

@override
String toString() {
  return 'AppIconData.asset(codePoint: $codePoint, fontFamily: $fontFamily, isMaterialIcon: $isMaterialIcon, iconName: $iconName, assetPath: $assetPath)';
}


}

/// @nodoc
abstract mixin class $AssetIconDataCopyWith<$Res> implements $AppIconDataCopyWith<$Res> {
  factory $AssetIconDataCopyWith(AssetIconData value, $Res Function(AssetIconData) _then) = _$AssetIconDataCopyWithImpl;
@override @useResult
$Res call({
 int codePoint, String fontFamily, bool isMaterialIcon, String? iconName, String? assetPath
});




}
/// @nodoc
class _$AssetIconDataCopyWithImpl<$Res>
    implements $AssetIconDataCopyWith<$Res> {
  _$AssetIconDataCopyWithImpl(this._self, this._then);

  final AssetIconData _self;
  final $Res Function(AssetIconData) _then;

/// Create a copy of AppIconData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? codePoint = null,Object? fontFamily = null,Object? isMaterialIcon = null,Object? iconName = freezed,Object? assetPath = freezed,}) {
  return _then(AssetIconData(
codePoint: null == codePoint ? _self.codePoint : codePoint // ignore: cast_nullable_to_non_nullable
as int,fontFamily: null == fontFamily ? _self.fontFamily : fontFamily // ignore: cast_nullable_to_non_nullable
as String,isMaterialIcon: null == isMaterialIcon ? _self.isMaterialIcon : isMaterialIcon // ignore: cast_nullable_to_non_nullable
as bool,iconName: freezed == iconName ? _self.iconName : iconName // ignore: cast_nullable_to_non_nullable
as String?,assetPath: freezed == assetPath ? _self.assetPath : assetPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
