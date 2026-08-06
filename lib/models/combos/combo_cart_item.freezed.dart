// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'combo_cart_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ComboCartItem {

 Combo get combo; int get quantity; DateTime? get addedAt;
/// Create a copy of ComboCartItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComboCartItemCopyWith<ComboCartItem> get copyWith => _$ComboCartItemCopyWithImpl<ComboCartItem>(this as ComboCartItem, _$identity);

  /// Serializes this ComboCartItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComboCartItem&&(identical(other.combo, combo) || other.combo == combo)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,combo,quantity,addedAt);

@override
String toString() {
  return 'ComboCartItem(combo: $combo, quantity: $quantity, addedAt: $addedAt)';
}


}

/// @nodoc
abstract mixin class $ComboCartItemCopyWith<$Res>  {
  factory $ComboCartItemCopyWith(ComboCartItem value, $Res Function(ComboCartItem) _then) = _$ComboCartItemCopyWithImpl;
@useResult
$Res call({
 Combo combo, int quantity, DateTime? addedAt
});


$ComboCopyWith<$Res> get combo;

}
/// @nodoc
class _$ComboCartItemCopyWithImpl<$Res>
    implements $ComboCartItemCopyWith<$Res> {
  _$ComboCartItemCopyWithImpl(this._self, this._then);

  final ComboCartItem _self;
  final $Res Function(ComboCartItem) _then;

/// Create a copy of ComboCartItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? combo = null,Object? quantity = null,Object? addedAt = freezed,}) {
  return _then(_self.copyWith(
combo: null == combo ? _self.combo : combo // ignore: cast_nullable_to_non_nullable
as Combo,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,addedAt: freezed == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of ComboCartItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComboCopyWith<$Res> get combo {
  
  return $ComboCopyWith<$Res>(_self.combo, (value) {
    return _then(_self.copyWith(combo: value));
  });
}
}


/// Adds pattern-matching-related methods to [ComboCartItem].
extension ComboCartItemPatterns on ComboCartItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ComboCartItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ComboCartItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ComboCartItem value)  $default,){
final _that = this;
switch (_that) {
case _ComboCartItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ComboCartItem value)?  $default,){
final _that = this;
switch (_that) {
case _ComboCartItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Combo combo,  int quantity,  DateTime? addedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ComboCartItem() when $default != null:
return $default(_that.combo,_that.quantity,_that.addedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Combo combo,  int quantity,  DateTime? addedAt)  $default,) {final _that = this;
switch (_that) {
case _ComboCartItem():
return $default(_that.combo,_that.quantity,_that.addedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Combo combo,  int quantity,  DateTime? addedAt)?  $default,) {final _that = this;
switch (_that) {
case _ComboCartItem() when $default != null:
return $default(_that.combo,_that.quantity,_that.addedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ComboCartItem implements ComboCartItem {
  const _ComboCartItem({required this.combo, this.quantity = 1, this.addedAt});
  factory _ComboCartItem.fromJson(Map<String, dynamic> json) => _$ComboCartItemFromJson(json);

@override final  Combo combo;
@override@JsonKey() final  int quantity;
@override final  DateTime? addedAt;

/// Create a copy of ComboCartItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComboCartItemCopyWith<_ComboCartItem> get copyWith => __$ComboCartItemCopyWithImpl<_ComboCartItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComboCartItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComboCartItem&&(identical(other.combo, combo) || other.combo == combo)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.addedAt, addedAt) || other.addedAt == addedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,combo,quantity,addedAt);

@override
String toString() {
  return 'ComboCartItem(combo: $combo, quantity: $quantity, addedAt: $addedAt)';
}


}

/// @nodoc
abstract mixin class _$ComboCartItemCopyWith<$Res> implements $ComboCartItemCopyWith<$Res> {
  factory _$ComboCartItemCopyWith(_ComboCartItem value, $Res Function(_ComboCartItem) _then) = __$ComboCartItemCopyWithImpl;
@override @useResult
$Res call({
 Combo combo, int quantity, DateTime? addedAt
});


@override $ComboCopyWith<$Res> get combo;

}
/// @nodoc
class __$ComboCartItemCopyWithImpl<$Res>
    implements _$ComboCartItemCopyWith<$Res> {
  __$ComboCartItemCopyWithImpl(this._self, this._then);

  final _ComboCartItem _self;
  final $Res Function(_ComboCartItem) _then;

/// Create a copy of ComboCartItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? combo = null,Object? quantity = null,Object? addedAt = freezed,}) {
  return _then(_ComboCartItem(
combo: null == combo ? _self.combo : combo // ignore: cast_nullable_to_non_nullable
as Combo,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,addedAt: freezed == addedAt ? _self.addedAt : addedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of ComboCartItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ComboCopyWith<$Res> get combo {
  
  return $ComboCopyWith<$Res>(_self.combo, (value) {
    return _then(_self.copyWith(combo: value));
  });
}
}

// dart format on
