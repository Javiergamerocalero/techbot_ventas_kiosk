// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'combo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Combo {

 int get id; String get name; String get description; String get price; bool get hasTax; double? get taxPercentage; bool get hasDiscount; double? get discountPercentage; String get discountedPrice; String? get finalPrice; String get thumbnail; List<Map<String, dynamic>> get images; bool get isActive; List<Product> get products; int get stock; String get sku; String get currencyCode; String get currencySymbol;@JsonKey(name: 'requires_variation_selection') bool get requiresVariationSelection;
/// Create a copy of Combo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComboCopyWith<Combo> get copyWith => _$ComboCopyWithImpl<Combo>(this as Combo, _$identity);

  /// Serializes this Combo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Combo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.hasTax, hasTax) || other.hasTax == hasTax)&&(identical(other.taxPercentage, taxPercentage) || other.taxPercentage == taxPercentage)&&(identical(other.hasDiscount, hasDiscount) || other.hasDiscount == hasDiscount)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.discountedPrice, discountedPrice) || other.discountedPrice == discountedPrice)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other.products, products)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.currencySymbol, currencySymbol) || other.currencySymbol == currencySymbol)&&(identical(other.requiresVariationSelection, requiresVariationSelection) || other.requiresVariationSelection == requiresVariationSelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,price,hasTax,taxPercentage,hasDiscount,discountPercentage,discountedPrice,finalPrice,thumbnail,const DeepCollectionEquality().hash(images),isActive,const DeepCollectionEquality().hash(products),stock,sku,currencyCode,currencySymbol,requiresVariationSelection]);

@override
String toString() {
  return 'Combo(id: $id, name: $name, description: $description, price: $price, hasTax: $hasTax, taxPercentage: $taxPercentage, hasDiscount: $hasDiscount, discountPercentage: $discountPercentage, discountedPrice: $discountedPrice, finalPrice: $finalPrice, thumbnail: $thumbnail, images: $images, isActive: $isActive, products: $products, stock: $stock, sku: $sku, currencyCode: $currencyCode, currencySymbol: $currencySymbol, requiresVariationSelection: $requiresVariationSelection)';
}


}

/// @nodoc
abstract mixin class $ComboCopyWith<$Res>  {
  factory $ComboCopyWith(Combo value, $Res Function(Combo) _then) = _$ComboCopyWithImpl;
@useResult
$Res call({
 int id, String name, String description, String price, bool hasTax, double? taxPercentage, bool hasDiscount, double? discountPercentage, String discountedPrice, String? finalPrice, String thumbnail, List<Map<String, dynamic>> images, bool isActive, List<Product> products, int stock, String sku, String currencyCode, String currencySymbol,@JsonKey(name: 'requires_variation_selection') bool requiresVariationSelection
});




}
/// @nodoc
class _$ComboCopyWithImpl<$Res>
    implements $ComboCopyWith<$Res> {
  _$ComboCopyWithImpl(this._self, this._then);

  final Combo _self;
  final $Res Function(Combo) _then;

/// Create a copy of Combo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? price = null,Object? hasTax = null,Object? taxPercentage = freezed,Object? hasDiscount = null,Object? discountPercentage = freezed,Object? discountedPrice = null,Object? finalPrice = freezed,Object? thumbnail = null,Object? images = null,Object? isActive = null,Object? products = null,Object? stock = null,Object? sku = null,Object? currencyCode = null,Object? currencySymbol = null,Object? requiresVariationSelection = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,hasTax: null == hasTax ? _self.hasTax : hasTax // ignore: cast_nullable_to_non_nullable
as bool,taxPercentage: freezed == taxPercentage ? _self.taxPercentage : taxPercentage // ignore: cast_nullable_to_non_nullable
as double?,hasDiscount: null == hasDiscount ? _self.hasDiscount : hasDiscount // ignore: cast_nullable_to_non_nullable
as bool,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,discountedPrice: null == discountedPrice ? _self.discountedPrice : discountedPrice // ignore: cast_nullable_to_non_nullable
as String,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as String?,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,currencySymbol: null == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String,requiresVariationSelection: null == requiresVariationSelection ? _self.requiresVariationSelection : requiresVariationSelection // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Combo].
extension ComboPatterns on Combo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Combo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Combo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Combo value)  $default,){
final _that = this;
switch (_that) {
case _Combo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Combo value)?  $default,){
final _that = this;
switch (_that) {
case _Combo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String description,  String price,  bool hasTax,  double? taxPercentage,  bool hasDiscount,  double? discountPercentage,  String discountedPrice,  String? finalPrice,  String thumbnail,  List<Map<String, dynamic>> images,  bool isActive,  List<Product> products,  int stock,  String sku,  String currencyCode,  String currencySymbol, @JsonKey(name: 'requires_variation_selection')  bool requiresVariationSelection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Combo() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.hasTax,_that.taxPercentage,_that.hasDiscount,_that.discountPercentage,_that.discountedPrice,_that.finalPrice,_that.thumbnail,_that.images,_that.isActive,_that.products,_that.stock,_that.sku,_that.currencyCode,_that.currencySymbol,_that.requiresVariationSelection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String description,  String price,  bool hasTax,  double? taxPercentage,  bool hasDiscount,  double? discountPercentage,  String discountedPrice,  String? finalPrice,  String thumbnail,  List<Map<String, dynamic>> images,  bool isActive,  List<Product> products,  int stock,  String sku,  String currencyCode,  String currencySymbol, @JsonKey(name: 'requires_variation_selection')  bool requiresVariationSelection)  $default,) {final _that = this;
switch (_that) {
case _Combo():
return $default(_that.id,_that.name,_that.description,_that.price,_that.hasTax,_that.taxPercentage,_that.hasDiscount,_that.discountPercentage,_that.discountedPrice,_that.finalPrice,_that.thumbnail,_that.images,_that.isActive,_that.products,_that.stock,_that.sku,_that.currencyCode,_that.currencySymbol,_that.requiresVariationSelection);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String description,  String price,  bool hasTax,  double? taxPercentage,  bool hasDiscount,  double? discountPercentage,  String discountedPrice,  String? finalPrice,  String thumbnail,  List<Map<String, dynamic>> images,  bool isActive,  List<Product> products,  int stock,  String sku,  String currencyCode,  String currencySymbol, @JsonKey(name: 'requires_variation_selection')  bool requiresVariationSelection)?  $default,) {final _that = this;
switch (_that) {
case _Combo() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.hasTax,_that.taxPercentage,_that.hasDiscount,_that.discountPercentage,_that.discountedPrice,_that.finalPrice,_that.thumbnail,_that.images,_that.isActive,_that.products,_that.stock,_that.sku,_that.currencyCode,_that.currencySymbol,_that.requiresVariationSelection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Combo implements Combo {
  const _Combo({required this.id, required this.name, required this.description, required this.price, this.hasTax = false, this.taxPercentage, this.hasDiscount = false, this.discountPercentage, required this.discountedPrice, this.finalPrice, required this.thumbnail, final  List<Map<String, dynamic>> images = const [], this.isActive = true, final  List<Product> products = const [], this.stock = 5, this.sku = '', this.currencyCode = 'PEN', this.currencySymbol = 'PEN', @JsonKey(name: 'requires_variation_selection') this.requiresVariationSelection = false}): _images = images,_products = products;
  factory _Combo.fromJson(Map<String, dynamic> json) => _$ComboFromJson(json);

@override final  int id;
@override final  String name;
@override final  String description;
@override final  String price;
@override@JsonKey() final  bool hasTax;
@override final  double? taxPercentage;
@override@JsonKey() final  bool hasDiscount;
@override final  double? discountPercentage;
@override final  String discountedPrice;
@override final  String? finalPrice;
@override final  String thumbnail;
 final  List<Map<String, dynamic>> _images;
@override@JsonKey() List<Map<String, dynamic>> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override@JsonKey() final  bool isActive;
 final  List<Product> _products;
@override@JsonKey() List<Product> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

@override@JsonKey() final  int stock;
@override@JsonKey() final  String sku;
@override@JsonKey() final  String currencyCode;
@override@JsonKey() final  String currencySymbol;
@override@JsonKey(name: 'requires_variation_selection') final  bool requiresVariationSelection;

/// Create a copy of Combo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComboCopyWith<_Combo> get copyWith => __$ComboCopyWithImpl<_Combo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComboToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Combo&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.hasTax, hasTax) || other.hasTax == hasTax)&&(identical(other.taxPercentage, taxPercentage) || other.taxPercentage == taxPercentage)&&(identical(other.hasDiscount, hasDiscount) || other.hasDiscount == hasDiscount)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.discountedPrice, discountedPrice) || other.discountedPrice == discountedPrice)&&(identical(other.finalPrice, finalPrice) || other.finalPrice == finalPrice)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&const DeepCollectionEquality().equals(other._products, _products)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.currencySymbol, currencySymbol) || other.currencySymbol == currencySymbol)&&(identical(other.requiresVariationSelection, requiresVariationSelection) || other.requiresVariationSelection == requiresVariationSelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,price,hasTax,taxPercentage,hasDiscount,discountPercentage,discountedPrice,finalPrice,thumbnail,const DeepCollectionEquality().hash(_images),isActive,const DeepCollectionEquality().hash(_products),stock,sku,currencyCode,currencySymbol,requiresVariationSelection]);

@override
String toString() {
  return 'Combo(id: $id, name: $name, description: $description, price: $price, hasTax: $hasTax, taxPercentage: $taxPercentage, hasDiscount: $hasDiscount, discountPercentage: $discountPercentage, discountedPrice: $discountedPrice, finalPrice: $finalPrice, thumbnail: $thumbnail, images: $images, isActive: $isActive, products: $products, stock: $stock, sku: $sku, currencyCode: $currencyCode, currencySymbol: $currencySymbol, requiresVariationSelection: $requiresVariationSelection)';
}


}

/// @nodoc
abstract mixin class _$ComboCopyWith<$Res> implements $ComboCopyWith<$Res> {
  factory _$ComboCopyWith(_Combo value, $Res Function(_Combo) _then) = __$ComboCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String description, String price, bool hasTax, double? taxPercentage, bool hasDiscount, double? discountPercentage, String discountedPrice, String? finalPrice, String thumbnail, List<Map<String, dynamic>> images, bool isActive, List<Product> products, int stock, String sku, String currencyCode, String currencySymbol,@JsonKey(name: 'requires_variation_selection') bool requiresVariationSelection
});




}
/// @nodoc
class __$ComboCopyWithImpl<$Res>
    implements _$ComboCopyWith<$Res> {
  __$ComboCopyWithImpl(this._self, this._then);

  final _Combo _self;
  final $Res Function(_Combo) _then;

/// Create a copy of Combo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? price = null,Object? hasTax = null,Object? taxPercentage = freezed,Object? hasDiscount = null,Object? discountPercentage = freezed,Object? discountedPrice = null,Object? finalPrice = freezed,Object? thumbnail = null,Object? images = null,Object? isActive = null,Object? products = null,Object? stock = null,Object? sku = null,Object? currencyCode = null,Object? currencySymbol = null,Object? requiresVariationSelection = null,}) {
  return _then(_Combo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,hasTax: null == hasTax ? _self.hasTax : hasTax // ignore: cast_nullable_to_non_nullable
as bool,taxPercentage: freezed == taxPercentage ? _self.taxPercentage : taxPercentage // ignore: cast_nullable_to_non_nullable
as double?,hasDiscount: null == hasDiscount ? _self.hasDiscount : hasDiscount // ignore: cast_nullable_to_non_nullable
as bool,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,discountedPrice: null == discountedPrice ? _self.discountedPrice : discountedPrice // ignore: cast_nullable_to_non_nullable
as String,finalPrice: freezed == finalPrice ? _self.finalPrice : finalPrice // ignore: cast_nullable_to_non_nullable
as String?,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<Product>,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,currencySymbol: null == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String,requiresVariationSelection: null == requiresVariationSelection ? _self.requiresVariationSelection : requiresVariationSelection // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
