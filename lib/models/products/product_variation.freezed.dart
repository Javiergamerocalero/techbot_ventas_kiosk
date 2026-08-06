// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_variation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductVariation {

 int get id;@JsonKey(name: 'product_id') int get productId; String? get sku; Map<String, dynamic> get attributes;@JsonKey(name: 'formatted_attributes') String get formattedAttributes; int get stock;@JsonKey(name: 'available_stock') int get availableStock;@JsonKey(name: 'reserved_stock') int get reservedStock;@JsonKey(name: 'is_active') bool get isActive;
/// Create a copy of ProductVariation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductVariationCopyWith<ProductVariation> get copyWith => _$ProductVariationCopyWithImpl<ProductVariation>(this as ProductVariation, _$identity);

  /// Serializes this ProductVariation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductVariation&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.sku, sku) || other.sku == sku)&&const DeepCollectionEquality().equals(other.attributes, attributes)&&(identical(other.formattedAttributes, formattedAttributes) || other.formattedAttributes == formattedAttributes)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.availableStock, availableStock) || other.availableStock == availableStock)&&(identical(other.reservedStock, reservedStock) || other.reservedStock == reservedStock)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,sku,const DeepCollectionEquality().hash(attributes),formattedAttributes,stock,availableStock,reservedStock,isActive);

@override
String toString() {
  return 'ProductVariation(id: $id, productId: $productId, sku: $sku, attributes: $attributes, formattedAttributes: $formattedAttributes, stock: $stock, availableStock: $availableStock, reservedStock: $reservedStock, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $ProductVariationCopyWith<$Res>  {
  factory $ProductVariationCopyWith(ProductVariation value, $Res Function(ProductVariation) _then) = _$ProductVariationCopyWithImpl;
@useResult
$Res call({
 int id,@JsonKey(name: 'product_id') int productId, String? sku, Map<String, dynamic> attributes,@JsonKey(name: 'formatted_attributes') String formattedAttributes, int stock,@JsonKey(name: 'available_stock') int availableStock,@JsonKey(name: 'reserved_stock') int reservedStock,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class _$ProductVariationCopyWithImpl<$Res>
    implements $ProductVariationCopyWith<$Res> {
  _$ProductVariationCopyWithImpl(this._self, this._then);

  final ProductVariation _self;
  final $Res Function(ProductVariation) _then;

/// Create a copy of ProductVariation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? sku = freezed,Object? attributes = null,Object? formattedAttributes = null,Object? stock = null,Object? availableStock = null,Object? reservedStock = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,formattedAttributes: null == formattedAttributes ? _self.formattedAttributes : formattedAttributes // ignore: cast_nullable_to_non_nullable
as String,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,availableStock: null == availableStock ? _self.availableStock : availableStock // ignore: cast_nullable_to_non_nullable
as int,reservedStock: null == reservedStock ? _self.reservedStock : reservedStock // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductVariation].
extension ProductVariationPatterns on ProductVariation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductVariation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductVariation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductVariation value)  $default,){
final _that = this;
switch (_that) {
case _ProductVariation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductVariation value)?  $default,){
final _that = this;
switch (_that) {
case _ProductVariation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'product_id')  int productId,  String? sku,  Map<String, dynamic> attributes, @JsonKey(name: 'formatted_attributes')  String formattedAttributes,  int stock, @JsonKey(name: 'available_stock')  int availableStock, @JsonKey(name: 'reserved_stock')  int reservedStock, @JsonKey(name: 'is_active')  bool isActive)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductVariation() when $default != null:
return $default(_that.id,_that.productId,_that.sku,_that.attributes,_that.formattedAttributes,_that.stock,_that.availableStock,_that.reservedStock,_that.isActive);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id, @JsonKey(name: 'product_id')  int productId,  String? sku,  Map<String, dynamic> attributes, @JsonKey(name: 'formatted_attributes')  String formattedAttributes,  int stock, @JsonKey(name: 'available_stock')  int availableStock, @JsonKey(name: 'reserved_stock')  int reservedStock, @JsonKey(name: 'is_active')  bool isActive)  $default,) {final _that = this;
switch (_that) {
case _ProductVariation():
return $default(_that.id,_that.productId,_that.sku,_that.attributes,_that.formattedAttributes,_that.stock,_that.availableStock,_that.reservedStock,_that.isActive);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id, @JsonKey(name: 'product_id')  int productId,  String? sku,  Map<String, dynamic> attributes, @JsonKey(name: 'formatted_attributes')  String formattedAttributes,  int stock, @JsonKey(name: 'available_stock')  int availableStock, @JsonKey(name: 'reserved_stock')  int reservedStock, @JsonKey(name: 'is_active')  bool isActive)?  $default,) {final _that = this;
switch (_that) {
case _ProductVariation() when $default != null:
return $default(_that.id,_that.productId,_that.sku,_that.attributes,_that.formattedAttributes,_that.stock,_that.availableStock,_that.reservedStock,_that.isActive);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductVariation extends ProductVariation {
  const _ProductVariation({required this.id, @JsonKey(name: 'product_id') required this.productId, this.sku, required final  Map<String, dynamic> attributes, @JsonKey(name: 'formatted_attributes') required this.formattedAttributes, required this.stock, @JsonKey(name: 'available_stock') required this.availableStock, @JsonKey(name: 'reserved_stock') required this.reservedStock, @JsonKey(name: 'is_active') required this.isActive}): _attributes = attributes,super._();
  factory _ProductVariation.fromJson(Map<String, dynamic> json) => _$ProductVariationFromJson(json);

@override final  int id;
@override@JsonKey(name: 'product_id') final  int productId;
@override final  String? sku;
 final  Map<String, dynamic> _attributes;
@override Map<String, dynamic> get attributes {
  if (_attributes is EqualUnmodifiableMapView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attributes);
}

@override@JsonKey(name: 'formatted_attributes') final  String formattedAttributes;
@override final  int stock;
@override@JsonKey(name: 'available_stock') final  int availableStock;
@override@JsonKey(name: 'reserved_stock') final  int reservedStock;
@override@JsonKey(name: 'is_active') final  bool isActive;

/// Create a copy of ProductVariation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductVariationCopyWith<_ProductVariation> get copyWith => __$ProductVariationCopyWithImpl<_ProductVariation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductVariationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductVariation&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.sku, sku) || other.sku == sku)&&const DeepCollectionEquality().equals(other._attributes, _attributes)&&(identical(other.formattedAttributes, formattedAttributes) || other.formattedAttributes == formattedAttributes)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.availableStock, availableStock) || other.availableStock == availableStock)&&(identical(other.reservedStock, reservedStock) || other.reservedStock == reservedStock)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,sku,const DeepCollectionEquality().hash(_attributes),formattedAttributes,stock,availableStock,reservedStock,isActive);

@override
String toString() {
  return 'ProductVariation(id: $id, productId: $productId, sku: $sku, attributes: $attributes, formattedAttributes: $formattedAttributes, stock: $stock, availableStock: $availableStock, reservedStock: $reservedStock, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$ProductVariationCopyWith<$Res> implements $ProductVariationCopyWith<$Res> {
  factory _$ProductVariationCopyWith(_ProductVariation value, $Res Function(_ProductVariation) _then) = __$ProductVariationCopyWithImpl;
@override @useResult
$Res call({
 int id,@JsonKey(name: 'product_id') int productId, String? sku, Map<String, dynamic> attributes,@JsonKey(name: 'formatted_attributes') String formattedAttributes, int stock,@JsonKey(name: 'available_stock') int availableStock,@JsonKey(name: 'reserved_stock') int reservedStock,@JsonKey(name: 'is_active') bool isActive
});




}
/// @nodoc
class __$ProductVariationCopyWithImpl<$Res>
    implements _$ProductVariationCopyWith<$Res> {
  __$ProductVariationCopyWithImpl(this._self, this._then);

  final _ProductVariation _self;
  final $Res Function(_ProductVariation) _then;

/// Create a copy of ProductVariation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? sku = freezed,Object? attributes = null,Object? formattedAttributes = null,Object? stock = null,Object? availableStock = null,Object? reservedStock = null,Object? isActive = null,}) {
  return _then(_ProductVariation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,sku: freezed == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String?,attributes: null == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,formattedAttributes: null == formattedAttributes ? _self.formattedAttributes : formattedAttributes // ignore: cast_nullable_to_non_nullable
as String,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,availableStock: null == availableStock ? _self.availableStock : availableStock // ignore: cast_nullable_to_non_nullable
as int,reservedStock: null == reservedStock ? _self.reservedStock : reservedStock // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
