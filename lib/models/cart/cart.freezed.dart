// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Cart {

 List<CartItem> get items; List<ComboCartItem> get comboItems; double get cartDiscountPercentage;@CouponConverter() Coupon? get appliedCoupon; DateTime? get updatedAt;
/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartCopyWith<Cart> get copyWith => _$CartCopyWithImpl<Cart>(this as Cart, _$identity);

  /// Serializes this Cart to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cart&&const DeepCollectionEquality().equals(other.items, items)&&const DeepCollectionEquality().equals(other.comboItems, comboItems)&&(identical(other.cartDiscountPercentage, cartDiscountPercentage) || other.cartDiscountPercentage == cartDiscountPercentage)&&(identical(other.appliedCoupon, appliedCoupon) || other.appliedCoupon == appliedCoupon)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),const DeepCollectionEquality().hash(comboItems),cartDiscountPercentage,appliedCoupon,updatedAt);

@override
String toString() {
  return 'Cart(items: $items, comboItems: $comboItems, cartDiscountPercentage: $cartDiscountPercentage, appliedCoupon: $appliedCoupon, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CartCopyWith<$Res>  {
  factory $CartCopyWith(Cart value, $Res Function(Cart) _then) = _$CartCopyWithImpl;
@useResult
$Res call({
 List<CartItem> items, List<ComboCartItem> comboItems, double cartDiscountPercentage,@CouponConverter() Coupon? appliedCoupon, DateTime? updatedAt
});


$CouponCopyWith<$Res>? get appliedCoupon;

}
/// @nodoc
class _$CartCopyWithImpl<$Res>
    implements $CartCopyWith<$Res> {
  _$CartCopyWithImpl(this._self, this._then);

  final Cart _self;
  final $Res Function(Cart) _then;

/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? comboItems = null,Object? cartDiscountPercentage = null,Object? appliedCoupon = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,comboItems: null == comboItems ? _self.comboItems : comboItems // ignore: cast_nullable_to_non_nullable
as List<ComboCartItem>,cartDiscountPercentage: null == cartDiscountPercentage ? _self.cartDiscountPercentage : cartDiscountPercentage // ignore: cast_nullable_to_non_nullable
as double,appliedCoupon: freezed == appliedCoupon ? _self.appliedCoupon : appliedCoupon // ignore: cast_nullable_to_non_nullable
as Coupon?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CouponCopyWith<$Res>? get appliedCoupon {
    if (_self.appliedCoupon == null) {
    return null;
  }

  return $CouponCopyWith<$Res>(_self.appliedCoupon!, (value) {
    return _then(_self.copyWith(appliedCoupon: value));
  });
}
}


/// Adds pattern-matching-related methods to [Cart].
extension CartPatterns on Cart {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Cart value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Cart() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Cart value)  $default,){
final _that = this;
switch (_that) {
case _Cart():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Cart value)?  $default,){
final _that = this;
switch (_that) {
case _Cart() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CartItem> items,  List<ComboCartItem> comboItems,  double cartDiscountPercentage, @CouponConverter()  Coupon? appliedCoupon,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Cart() when $default != null:
return $default(_that.items,_that.comboItems,_that.cartDiscountPercentage,_that.appliedCoupon,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CartItem> items,  List<ComboCartItem> comboItems,  double cartDiscountPercentage, @CouponConverter()  Coupon? appliedCoupon,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Cart():
return $default(_that.items,_that.comboItems,_that.cartDiscountPercentage,_that.appliedCoupon,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CartItem> items,  List<ComboCartItem> comboItems,  double cartDiscountPercentage, @CouponConverter()  Coupon? appliedCoupon,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Cart() when $default != null:
return $default(_that.items,_that.comboItems,_that.cartDiscountPercentage,_that.appliedCoupon,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Cart implements Cart {
  const _Cart({final  List<CartItem> items = const [], final  List<ComboCartItem> comboItems = const [], this.cartDiscountPercentage = 0.0, @CouponConverter() this.appliedCoupon = null, this.updatedAt}): _items = items,_comboItems = comboItems;
  factory _Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

 final  List<CartItem> _items;
@override@JsonKey() List<CartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

 final  List<ComboCartItem> _comboItems;
@override@JsonKey() List<ComboCartItem> get comboItems {
  if (_comboItems is EqualUnmodifiableListView) return _comboItems;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comboItems);
}

@override@JsonKey() final  double cartDiscountPercentage;
@override@JsonKey()@CouponConverter() final  Coupon? appliedCoupon;
@override final  DateTime? updatedAt;

/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartCopyWith<_Cart> get copyWith => __$CartCopyWithImpl<_Cart>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CartToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cart&&const DeepCollectionEquality().equals(other._items, _items)&&const DeepCollectionEquality().equals(other._comboItems, _comboItems)&&(identical(other.cartDiscountPercentage, cartDiscountPercentage) || other.cartDiscountPercentage == cartDiscountPercentage)&&(identical(other.appliedCoupon, appliedCoupon) || other.appliedCoupon == appliedCoupon)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),const DeepCollectionEquality().hash(_comboItems),cartDiscountPercentage,appliedCoupon,updatedAt);

@override
String toString() {
  return 'Cart(items: $items, comboItems: $comboItems, cartDiscountPercentage: $cartDiscountPercentage, appliedCoupon: $appliedCoupon, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CartCopyWith<$Res> implements $CartCopyWith<$Res> {
  factory _$CartCopyWith(_Cart value, $Res Function(_Cart) _then) = __$CartCopyWithImpl;
@override @useResult
$Res call({
 List<CartItem> items, List<ComboCartItem> comboItems, double cartDiscountPercentage,@CouponConverter() Coupon? appliedCoupon, DateTime? updatedAt
});


@override $CouponCopyWith<$Res>? get appliedCoupon;

}
/// @nodoc
class __$CartCopyWithImpl<$Res>
    implements _$CartCopyWith<$Res> {
  __$CartCopyWithImpl(this._self, this._then);

  final _Cart _self;
  final $Res Function(_Cart) _then;

/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? comboItems = null,Object? cartDiscountPercentage = null,Object? appliedCoupon = freezed,Object? updatedAt = freezed,}) {
  return _then(_Cart(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,comboItems: null == comboItems ? _self._comboItems : comboItems // ignore: cast_nullable_to_non_nullable
as List<ComboCartItem>,cartDiscountPercentage: null == cartDiscountPercentage ? _self.cartDiscountPercentage : cartDiscountPercentage // ignore: cast_nullable_to_non_nullable
as double,appliedCoupon: freezed == appliedCoupon ? _self.appliedCoupon : appliedCoupon // ignore: cast_nullable_to_non_nullable
as Coupon?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CouponCopyWith<$Res>? get appliedCoupon {
    if (_self.appliedCoupon == null) {
    return null;
  }

  return $CouponCopyWith<$Res>(_self.appliedCoupon!, (value) {
    return _then(_self.copyWith(appliedCoupon: value));
  });
}
}

// dart format on
