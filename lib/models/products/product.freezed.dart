// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Product {

 int get id; String get name; String get description; String get price; bool get hasDiscount; double? get discountPercentage; String get discountedPrice; String get thumbnail; List<Map<String, dynamic>> get images; int get categoryId; int? get subCategoryId; bool get isFavorite; int? get stock; int? get availableStock; int? get reservedStock; String get sku; bool get hasVariations; List<ProductVariation> get variations; String get currencyCode; String get currencySymbol;@JsonKey(name: 'requires_variation_selection') bool get requiresVariationSelection;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);

  /// Serializes this Product to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.hasDiscount, hasDiscount) || other.hasDiscount == hasDiscount)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.discountedPrice, discountedPrice) || other.discountedPrice == discountedPrice)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&const DeepCollectionEquality().equals(other.images, images)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.subCategoryId, subCategoryId) || other.subCategoryId == subCategoryId)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.availableStock, availableStock) || other.availableStock == availableStock)&&(identical(other.reservedStock, reservedStock) || other.reservedStock == reservedStock)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.hasVariations, hasVariations) || other.hasVariations == hasVariations)&&const DeepCollectionEquality().equals(other.variations, variations)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.currencySymbol, currencySymbol) || other.currencySymbol == currencySymbol)&&(identical(other.requiresVariationSelection, requiresVariationSelection) || other.requiresVariationSelection == requiresVariationSelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,price,hasDiscount,discountPercentage,discountedPrice,thumbnail,const DeepCollectionEquality().hash(images),categoryId,subCategoryId,isFavorite,stock,availableStock,reservedStock,sku,hasVariations,const DeepCollectionEquality().hash(variations),currencyCode,currencySymbol,requiresVariationSelection]);

@override
String toString() {
  return 'Product(id: $id, name: $name, description: $description, price: $price, hasDiscount: $hasDiscount, discountPercentage: $discountPercentage, discountedPrice: $discountedPrice, thumbnail: $thumbnail, images: $images, categoryId: $categoryId, subCategoryId: $subCategoryId, isFavorite: $isFavorite, stock: $stock, availableStock: $availableStock, reservedStock: $reservedStock, sku: $sku, hasVariations: $hasVariations, variations: $variations, currencyCode: $currencyCode, currencySymbol: $currencySymbol, requiresVariationSelection: $requiresVariationSelection)';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 int id, String name, String description, String price, bool hasDiscount, double? discountPercentage, String discountedPrice, String thumbnail, List<Map<String, dynamic>> images, int categoryId, int? subCategoryId, bool isFavorite, int? stock, int? availableStock, int? reservedStock, String sku, bool hasVariations, List<ProductVariation> variations, String currencyCode, String currencySymbol,@JsonKey(name: 'requires_variation_selection') bool requiresVariationSelection
});




}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? price = null,Object? hasDiscount = null,Object? discountPercentage = freezed,Object? discountedPrice = null,Object? thumbnail = null,Object? images = null,Object? categoryId = null,Object? subCategoryId = freezed,Object? isFavorite = null,Object? stock = freezed,Object? availableStock = freezed,Object? reservedStock = freezed,Object? sku = null,Object? hasVariations = null,Object? variations = null,Object? currencyCode = null,Object? currencySymbol = null,Object? requiresVariationSelection = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,hasDiscount: null == hasDiscount ? _self.hasDiscount : hasDiscount // ignore: cast_nullable_to_non_nullable
as bool,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,discountedPrice: null == discountedPrice ? _self.discountedPrice : discountedPrice // ignore: cast_nullable_to_non_nullable
as String,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self.images : images // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,subCategoryId: freezed == subCategoryId ? _self.subCategoryId : subCategoryId // ignore: cast_nullable_to_non_nullable
as int?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,availableStock: freezed == availableStock ? _self.availableStock : availableStock // ignore: cast_nullable_to_non_nullable
as int?,reservedStock: freezed == reservedStock ? _self.reservedStock : reservedStock // ignore: cast_nullable_to_non_nullable
as int?,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,hasVariations: null == hasVariations ? _self.hasVariations : hasVariations // ignore: cast_nullable_to_non_nullable
as bool,variations: null == variations ? _self.variations : variations // ignore: cast_nullable_to_non_nullable
as List<ProductVariation>,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,currencySymbol: null == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String,requiresVariationSelection: null == requiresVariationSelection ? _self.requiresVariationSelection : requiresVariationSelection // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String description,  String price,  bool hasDiscount,  double? discountPercentage,  String discountedPrice,  String thumbnail,  List<Map<String, dynamic>> images,  int categoryId,  int? subCategoryId,  bool isFavorite,  int? stock,  int? availableStock,  int? reservedStock,  String sku,  bool hasVariations,  List<ProductVariation> variations,  String currencyCode,  String currencySymbol, @JsonKey(name: 'requires_variation_selection')  bool requiresVariationSelection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.hasDiscount,_that.discountPercentage,_that.discountedPrice,_that.thumbnail,_that.images,_that.categoryId,_that.subCategoryId,_that.isFavorite,_that.stock,_that.availableStock,_that.reservedStock,_that.sku,_that.hasVariations,_that.variations,_that.currencyCode,_that.currencySymbol,_that.requiresVariationSelection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String description,  String price,  bool hasDiscount,  double? discountPercentage,  String discountedPrice,  String thumbnail,  List<Map<String, dynamic>> images,  int categoryId,  int? subCategoryId,  bool isFavorite,  int? stock,  int? availableStock,  int? reservedStock,  String sku,  bool hasVariations,  List<ProductVariation> variations,  String currencyCode,  String currencySymbol, @JsonKey(name: 'requires_variation_selection')  bool requiresVariationSelection)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.name,_that.description,_that.price,_that.hasDiscount,_that.discountPercentage,_that.discountedPrice,_that.thumbnail,_that.images,_that.categoryId,_that.subCategoryId,_that.isFavorite,_that.stock,_that.availableStock,_that.reservedStock,_that.sku,_that.hasVariations,_that.variations,_that.currencyCode,_that.currencySymbol,_that.requiresVariationSelection);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String description,  String price,  bool hasDiscount,  double? discountPercentage,  String discountedPrice,  String thumbnail,  List<Map<String, dynamic>> images,  int categoryId,  int? subCategoryId,  bool isFavorite,  int? stock,  int? availableStock,  int? reservedStock,  String sku,  bool hasVariations,  List<ProductVariation> variations,  String currencyCode,  String currencySymbol, @JsonKey(name: 'requires_variation_selection')  bool requiresVariationSelection)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.price,_that.hasDiscount,_that.discountPercentage,_that.discountedPrice,_that.thumbnail,_that.images,_that.categoryId,_that.subCategoryId,_that.isFavorite,_that.stock,_that.availableStock,_that.reservedStock,_that.sku,_that.hasVariations,_that.variations,_that.currencyCode,_that.currencySymbol,_that.requiresVariationSelection);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Product implements Product {
  const _Product({required this.id, required this.name, required this.description, required this.price, this.hasDiscount = false, this.discountPercentage, required this.discountedPrice, required this.thumbnail, final  List<Map<String, dynamic>> images = const [], required this.categoryId, this.subCategoryId, this.isFavorite = false, this.stock, this.availableStock, this.reservedStock, this.sku = '', this.hasVariations = false, final  List<ProductVariation> variations = const [], this.currencyCode = 'PEN', this.currencySymbol = 'PEN', @JsonKey(name: 'requires_variation_selection') this.requiresVariationSelection = false}): _images = images,_variations = variations;
  factory _Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

@override final  int id;
@override final  String name;
@override final  String description;
@override final  String price;
@override@JsonKey() final  bool hasDiscount;
@override final  double? discountPercentage;
@override final  String discountedPrice;
@override final  String thumbnail;
 final  List<Map<String, dynamic>> _images;
@override@JsonKey() List<Map<String, dynamic>> get images {
  if (_images is EqualUnmodifiableListView) return _images;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_images);
}

@override final  int categoryId;
@override final  int? subCategoryId;
@override@JsonKey() final  bool isFavorite;
@override final  int? stock;
@override final  int? availableStock;
@override final  int? reservedStock;
@override@JsonKey() final  String sku;
@override@JsonKey() final  bool hasVariations;
 final  List<ProductVariation> _variations;
@override@JsonKey() List<ProductVariation> get variations {
  if (_variations is EqualUnmodifiableListView) return _variations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_variations);
}

@override@JsonKey() final  String currencyCode;
@override@JsonKey() final  String currencySymbol;
@override@JsonKey(name: 'requires_variation_selection') final  bool requiresVariationSelection;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.price, price) || other.price == price)&&(identical(other.hasDiscount, hasDiscount) || other.hasDiscount == hasDiscount)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.discountedPrice, discountedPrice) || other.discountedPrice == discountedPrice)&&(identical(other.thumbnail, thumbnail) || other.thumbnail == thumbnail)&&const DeepCollectionEquality().equals(other._images, _images)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.subCategoryId, subCategoryId) || other.subCategoryId == subCategoryId)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.availableStock, availableStock) || other.availableStock == availableStock)&&(identical(other.reservedStock, reservedStock) || other.reservedStock == reservedStock)&&(identical(other.sku, sku) || other.sku == sku)&&(identical(other.hasVariations, hasVariations) || other.hasVariations == hasVariations)&&const DeepCollectionEquality().equals(other._variations, _variations)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.currencySymbol, currencySymbol) || other.currencySymbol == currencySymbol)&&(identical(other.requiresVariationSelection, requiresVariationSelection) || other.requiresVariationSelection == requiresVariationSelection));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,price,hasDiscount,discountPercentage,discountedPrice,thumbnail,const DeepCollectionEquality().hash(_images),categoryId,subCategoryId,isFavorite,stock,availableStock,reservedStock,sku,hasVariations,const DeepCollectionEquality().hash(_variations),currencyCode,currencySymbol,requiresVariationSelection]);

@override
String toString() {
  return 'Product(id: $id, name: $name, description: $description, price: $price, hasDiscount: $hasDiscount, discountPercentage: $discountPercentage, discountedPrice: $discountedPrice, thumbnail: $thumbnail, images: $images, categoryId: $categoryId, subCategoryId: $subCategoryId, isFavorite: $isFavorite, stock: $stock, availableStock: $availableStock, reservedStock: $reservedStock, sku: $sku, hasVariations: $hasVariations, variations: $variations, currencyCode: $currencyCode, currencySymbol: $currencySymbol, requiresVariationSelection: $requiresVariationSelection)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String description, String price, bool hasDiscount, double? discountPercentage, String discountedPrice, String thumbnail, List<Map<String, dynamic>> images, int categoryId, int? subCategoryId, bool isFavorite, int? stock, int? availableStock, int? reservedStock, String sku, bool hasVariations, List<ProductVariation> variations, String currencyCode, String currencySymbol,@JsonKey(name: 'requires_variation_selection') bool requiresVariationSelection
});




}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? price = null,Object? hasDiscount = null,Object? discountPercentage = freezed,Object? discountedPrice = null,Object? thumbnail = null,Object? images = null,Object? categoryId = null,Object? subCategoryId = freezed,Object? isFavorite = null,Object? stock = freezed,Object? availableStock = freezed,Object? reservedStock = freezed,Object? sku = null,Object? hasVariations = null,Object? variations = null,Object? currencyCode = null,Object? currencySymbol = null,Object? requiresVariationSelection = null,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,hasDiscount: null == hasDiscount ? _self.hasDiscount : hasDiscount // ignore: cast_nullable_to_non_nullable
as bool,discountPercentage: freezed == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double?,discountedPrice: null == discountedPrice ? _self.discountedPrice : discountedPrice // ignore: cast_nullable_to_non_nullable
as String,thumbnail: null == thumbnail ? _self.thumbnail : thumbnail // ignore: cast_nullable_to_non_nullable
as String,images: null == images ? _self._images : images // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int,subCategoryId: freezed == subCategoryId ? _self.subCategoryId : subCategoryId // ignore: cast_nullable_to_non_nullable
as int?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,availableStock: freezed == availableStock ? _self.availableStock : availableStock // ignore: cast_nullable_to_non_nullable
as int?,reservedStock: freezed == reservedStock ? _self.reservedStock : reservedStock // ignore: cast_nullable_to_non_nullable
as int?,sku: null == sku ? _self.sku : sku // ignore: cast_nullable_to_non_nullable
as String,hasVariations: null == hasVariations ? _self.hasVariations : hasVariations // ignore: cast_nullable_to_non_nullable
as bool,variations: null == variations ? _self._variations : variations // ignore: cast_nullable_to_non_nullable
as List<ProductVariation>,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,currencySymbol: null == currencySymbol ? _self.currencySymbol : currencySymbol // ignore: cast_nullable_to_non_nullable
as String,requiresVariationSelection: null == requiresVariationSelection ? _self.requiresVariationSelection : requiresVariationSelection // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
