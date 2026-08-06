// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cashdro_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CashDroTransaction {

@JsonKey(name: 'operation_id') String? get operationId; double get amount; CashDroTransactionState get state;@JsonKey(name: 'total_in') double? get totalIn;@JsonKey(name: 'total_out') double? get totalOut;@JsonKey(name: 'with_error') bool? get withError;@JsonKey(name: 'error_message') String? get errorMessage;@JsonKey(name: 'pay_in_progress') int? get payInProgress;@JsonKey(name: 'pay_out_progress') int? get payOutProgress;@JsonKey(name: 'alias_id') String? get aliasId;
/// Create a copy of CashDroTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashDroTransactionCopyWith<CashDroTransaction> get copyWith => _$CashDroTransactionCopyWithImpl<CashDroTransaction>(this as CashDroTransaction, _$identity);

  /// Serializes this CashDroTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashDroTransaction&&(identical(other.operationId, operationId) || other.operationId == operationId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.state, state) || other.state == state)&&(identical(other.totalIn, totalIn) || other.totalIn == totalIn)&&(identical(other.totalOut, totalOut) || other.totalOut == totalOut)&&(identical(other.withError, withError) || other.withError == withError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.payInProgress, payInProgress) || other.payInProgress == payInProgress)&&(identical(other.payOutProgress, payOutProgress) || other.payOutProgress == payOutProgress)&&(identical(other.aliasId, aliasId) || other.aliasId == aliasId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,operationId,amount,state,totalIn,totalOut,withError,errorMessage,payInProgress,payOutProgress,aliasId);

@override
String toString() {
  return 'CashDroTransaction(operationId: $operationId, amount: $amount, state: $state, totalIn: $totalIn, totalOut: $totalOut, withError: $withError, errorMessage: $errorMessage, payInProgress: $payInProgress, payOutProgress: $payOutProgress, aliasId: $aliasId)';
}


}

/// @nodoc
abstract mixin class $CashDroTransactionCopyWith<$Res>  {
  factory $CashDroTransactionCopyWith(CashDroTransaction value, $Res Function(CashDroTransaction) _then) = _$CashDroTransactionCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'operation_id') String? operationId, double amount, CashDroTransactionState state,@JsonKey(name: 'total_in') double? totalIn,@JsonKey(name: 'total_out') double? totalOut,@JsonKey(name: 'with_error') bool? withError,@JsonKey(name: 'error_message') String? errorMessage,@JsonKey(name: 'pay_in_progress') int? payInProgress,@JsonKey(name: 'pay_out_progress') int? payOutProgress,@JsonKey(name: 'alias_id') String? aliasId
});




}
/// @nodoc
class _$CashDroTransactionCopyWithImpl<$Res>
    implements $CashDroTransactionCopyWith<$Res> {
  _$CashDroTransactionCopyWithImpl(this._self, this._then);

  final CashDroTransaction _self;
  final $Res Function(CashDroTransaction) _then;

/// Create a copy of CashDroTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? operationId = freezed,Object? amount = null,Object? state = null,Object? totalIn = freezed,Object? totalOut = freezed,Object? withError = freezed,Object? errorMessage = freezed,Object? payInProgress = freezed,Object? payOutProgress = freezed,Object? aliasId = freezed,}) {
  return _then(_self.copyWith(
operationId: freezed == operationId ? _self.operationId : operationId // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CashDroTransactionState,totalIn: freezed == totalIn ? _self.totalIn : totalIn // ignore: cast_nullable_to_non_nullable
as double?,totalOut: freezed == totalOut ? _self.totalOut : totalOut // ignore: cast_nullable_to_non_nullable
as double?,withError: freezed == withError ? _self.withError : withError // ignore: cast_nullable_to_non_nullable
as bool?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,payInProgress: freezed == payInProgress ? _self.payInProgress : payInProgress // ignore: cast_nullable_to_non_nullable
as int?,payOutProgress: freezed == payOutProgress ? _self.payOutProgress : payOutProgress // ignore: cast_nullable_to_non_nullable
as int?,aliasId: freezed == aliasId ? _self.aliasId : aliasId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CashDroTransaction].
extension CashDroTransactionPatterns on CashDroTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashDroTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashDroTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashDroTransaction value)  $default,){
final _that = this;
switch (_that) {
case _CashDroTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashDroTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _CashDroTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'operation_id')  String? operationId,  double amount,  CashDroTransactionState state, @JsonKey(name: 'total_in')  double? totalIn, @JsonKey(name: 'total_out')  double? totalOut, @JsonKey(name: 'with_error')  bool? withError, @JsonKey(name: 'error_message')  String? errorMessage, @JsonKey(name: 'pay_in_progress')  int? payInProgress, @JsonKey(name: 'pay_out_progress')  int? payOutProgress, @JsonKey(name: 'alias_id')  String? aliasId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashDroTransaction() when $default != null:
return $default(_that.operationId,_that.amount,_that.state,_that.totalIn,_that.totalOut,_that.withError,_that.errorMessage,_that.payInProgress,_that.payOutProgress,_that.aliasId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'operation_id')  String? operationId,  double amount,  CashDroTransactionState state, @JsonKey(name: 'total_in')  double? totalIn, @JsonKey(name: 'total_out')  double? totalOut, @JsonKey(name: 'with_error')  bool? withError, @JsonKey(name: 'error_message')  String? errorMessage, @JsonKey(name: 'pay_in_progress')  int? payInProgress, @JsonKey(name: 'pay_out_progress')  int? payOutProgress, @JsonKey(name: 'alias_id')  String? aliasId)  $default,) {final _that = this;
switch (_that) {
case _CashDroTransaction():
return $default(_that.operationId,_that.amount,_that.state,_that.totalIn,_that.totalOut,_that.withError,_that.errorMessage,_that.payInProgress,_that.payOutProgress,_that.aliasId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'operation_id')  String? operationId,  double amount,  CashDroTransactionState state, @JsonKey(name: 'total_in')  double? totalIn, @JsonKey(name: 'total_out')  double? totalOut, @JsonKey(name: 'with_error')  bool? withError, @JsonKey(name: 'error_message')  String? errorMessage, @JsonKey(name: 'pay_in_progress')  int? payInProgress, @JsonKey(name: 'pay_out_progress')  int? payOutProgress, @JsonKey(name: 'alias_id')  String? aliasId)?  $default,) {final _that = this;
switch (_that) {
case _CashDroTransaction() when $default != null:
return $default(_that.operationId,_that.amount,_that.state,_that.totalIn,_that.totalOut,_that.withError,_that.errorMessage,_that.payInProgress,_that.payOutProgress,_that.aliasId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CashDroTransaction extends CashDroTransaction {
  const _CashDroTransaction({@JsonKey(name: 'operation_id') this.operationId, this.amount = 0.0, this.state = CashDroTransactionState.idle, @JsonKey(name: 'total_in') this.totalIn, @JsonKey(name: 'total_out') this.totalOut, @JsonKey(name: 'with_error') this.withError, @JsonKey(name: 'error_message') this.errorMessage, @JsonKey(name: 'pay_in_progress') this.payInProgress, @JsonKey(name: 'pay_out_progress') this.payOutProgress, @JsonKey(name: 'alias_id') this.aliasId}): super._();
  factory _CashDroTransaction.fromJson(Map<String, dynamic> json) => _$CashDroTransactionFromJson(json);

@override@JsonKey(name: 'operation_id') final  String? operationId;
@override@JsonKey() final  double amount;
@override@JsonKey() final  CashDroTransactionState state;
@override@JsonKey(name: 'total_in') final  double? totalIn;
@override@JsonKey(name: 'total_out') final  double? totalOut;
@override@JsonKey(name: 'with_error') final  bool? withError;
@override@JsonKey(name: 'error_message') final  String? errorMessage;
@override@JsonKey(name: 'pay_in_progress') final  int? payInProgress;
@override@JsonKey(name: 'pay_out_progress') final  int? payOutProgress;
@override@JsonKey(name: 'alias_id') final  String? aliasId;

/// Create a copy of CashDroTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashDroTransactionCopyWith<_CashDroTransaction> get copyWith => __$CashDroTransactionCopyWithImpl<_CashDroTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CashDroTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashDroTransaction&&(identical(other.operationId, operationId) || other.operationId == operationId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.state, state) || other.state == state)&&(identical(other.totalIn, totalIn) || other.totalIn == totalIn)&&(identical(other.totalOut, totalOut) || other.totalOut == totalOut)&&(identical(other.withError, withError) || other.withError == withError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.payInProgress, payInProgress) || other.payInProgress == payInProgress)&&(identical(other.payOutProgress, payOutProgress) || other.payOutProgress == payOutProgress)&&(identical(other.aliasId, aliasId) || other.aliasId == aliasId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,operationId,amount,state,totalIn,totalOut,withError,errorMessage,payInProgress,payOutProgress,aliasId);

@override
String toString() {
  return 'CashDroTransaction(operationId: $operationId, amount: $amount, state: $state, totalIn: $totalIn, totalOut: $totalOut, withError: $withError, errorMessage: $errorMessage, payInProgress: $payInProgress, payOutProgress: $payOutProgress, aliasId: $aliasId)';
}


}

/// @nodoc
abstract mixin class _$CashDroTransactionCopyWith<$Res> implements $CashDroTransactionCopyWith<$Res> {
  factory _$CashDroTransactionCopyWith(_CashDroTransaction value, $Res Function(_CashDroTransaction) _then) = __$CashDroTransactionCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'operation_id') String? operationId, double amount, CashDroTransactionState state,@JsonKey(name: 'total_in') double? totalIn,@JsonKey(name: 'total_out') double? totalOut,@JsonKey(name: 'with_error') bool? withError,@JsonKey(name: 'error_message') String? errorMessage,@JsonKey(name: 'pay_in_progress') int? payInProgress,@JsonKey(name: 'pay_out_progress') int? payOutProgress,@JsonKey(name: 'alias_id') String? aliasId
});




}
/// @nodoc
class __$CashDroTransactionCopyWithImpl<$Res>
    implements _$CashDroTransactionCopyWith<$Res> {
  __$CashDroTransactionCopyWithImpl(this._self, this._then);

  final _CashDroTransaction _self;
  final $Res Function(_CashDroTransaction) _then;

/// Create a copy of CashDroTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? operationId = freezed,Object? amount = null,Object? state = null,Object? totalIn = freezed,Object? totalOut = freezed,Object? withError = freezed,Object? errorMessage = freezed,Object? payInProgress = freezed,Object? payOutProgress = freezed,Object? aliasId = freezed,}) {
  return _then(_CashDroTransaction(
operationId: freezed == operationId ? _self.operationId : operationId // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as CashDroTransactionState,totalIn: freezed == totalIn ? _self.totalIn : totalIn // ignore: cast_nullable_to_non_nullable
as double?,totalOut: freezed == totalOut ? _self.totalOut : totalOut // ignore: cast_nullable_to_non_nullable
as double?,withError: freezed == withError ? _self.withError : withError // ignore: cast_nullable_to_non_nullable
as bool?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,payInProgress: freezed == payInProgress ? _self.payInProgress : payInProgress // ignore: cast_nullable_to_non_nullable
as int?,payOutProgress: freezed == payOutProgress ? _self.payOutProgress : payOutProgress // ignore: cast_nullable_to_non_nullable
as int?,aliasId: freezed == aliasId ? _self.aliasId : aliasId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CashDroStartResponse {

 int get code;@JsonKey(name: 'operation_id') String? get operationId;@JsonKey(name: 'error_message') String? get errorMessage;
/// Create a copy of CashDroStartResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashDroStartResponseCopyWith<CashDroStartResponse> get copyWith => _$CashDroStartResponseCopyWithImpl<CashDroStartResponse>(this as CashDroStartResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashDroStartResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.operationId, operationId) || other.operationId == operationId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,code,operationId,errorMessage);

@override
String toString() {
  return 'CashDroStartResponse(code: $code, operationId: $operationId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CashDroStartResponseCopyWith<$Res>  {
  factory $CashDroStartResponseCopyWith(CashDroStartResponse value, $Res Function(CashDroStartResponse) _then) = _$CashDroStartResponseCopyWithImpl;
@useResult
$Res call({
 int code,@JsonKey(name: 'operation_id') String? operationId,@JsonKey(name: 'error_message') String? errorMessage
});




}
/// @nodoc
class _$CashDroStartResponseCopyWithImpl<$Res>
    implements $CashDroStartResponseCopyWith<$Res> {
  _$CashDroStartResponseCopyWithImpl(this._self, this._then);

  final CashDroStartResponse _self;
  final $Res Function(CashDroStartResponse) _then;

/// Create a copy of CashDroStartResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? operationId = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,operationId: freezed == operationId ? _self.operationId : operationId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CashDroStartResponse].
extension CashDroStartResponsePatterns on CashDroStartResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashDroStartResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashDroStartResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashDroStartResponse value)  $default,){
final _that = this;
switch (_that) {
case _CashDroStartResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashDroStartResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CashDroStartResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code, @JsonKey(name: 'operation_id')  String? operationId, @JsonKey(name: 'error_message')  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashDroStartResponse() when $default != null:
return $default(_that.code,_that.operationId,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int code, @JsonKey(name: 'operation_id')  String? operationId, @JsonKey(name: 'error_message')  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CashDroStartResponse():
return $default(_that.code,_that.operationId,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int code, @JsonKey(name: 'operation_id')  String? operationId, @JsonKey(name: 'error_message')  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CashDroStartResponse() when $default != null:
return $default(_that.code,_that.operationId,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CashDroStartResponse extends CashDroStartResponse {
  const _CashDroStartResponse({required this.code, @JsonKey(name: 'operation_id') this.operationId, @JsonKey(name: 'error_message') this.errorMessage}): super._();
  

@override final  int code;
@override@JsonKey(name: 'operation_id') final  String? operationId;
@override@JsonKey(name: 'error_message') final  String? errorMessage;

/// Create a copy of CashDroStartResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashDroStartResponseCopyWith<_CashDroStartResponse> get copyWith => __$CashDroStartResponseCopyWithImpl<_CashDroStartResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashDroStartResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.operationId, operationId) || other.operationId == operationId)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,code,operationId,errorMessage);

@override
String toString() {
  return 'CashDroStartResponse(code: $code, operationId: $operationId, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CashDroStartResponseCopyWith<$Res> implements $CashDroStartResponseCopyWith<$Res> {
  factory _$CashDroStartResponseCopyWith(_CashDroStartResponse value, $Res Function(_CashDroStartResponse) _then) = __$CashDroStartResponseCopyWithImpl;
@override @useResult
$Res call({
 int code,@JsonKey(name: 'operation_id') String? operationId,@JsonKey(name: 'error_message') String? errorMessage
});




}
/// @nodoc
class __$CashDroStartResponseCopyWithImpl<$Res>
    implements _$CashDroStartResponseCopyWith<$Res> {
  __$CashDroStartResponseCopyWithImpl(this._self, this._then);

  final _CashDroStartResponse _self;
  final $Res Function(_CashDroStartResponse) _then;

/// Create a copy of CashDroStartResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? operationId = freezed,Object? errorMessage = freezed,}) {
  return _then(_CashDroStartResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,operationId: freezed == operationId ? _self.operationId : operationId // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CashDroSimpleResponse {

 int get code;@JsonKey(name: 'error_message') String? get errorMessage;
/// Create a copy of CashDroSimpleResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashDroSimpleResponseCopyWith<CashDroSimpleResponse> get copyWith => _$CashDroSimpleResponseCopyWithImpl<CashDroSimpleResponse>(this as CashDroSimpleResponse, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashDroSimpleResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,code,errorMessage);

@override
String toString() {
  return 'CashDroSimpleResponse(code: $code, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CashDroSimpleResponseCopyWith<$Res>  {
  factory $CashDroSimpleResponseCopyWith(CashDroSimpleResponse value, $Res Function(CashDroSimpleResponse) _then) = _$CashDroSimpleResponseCopyWithImpl;
@useResult
$Res call({
 int code,@JsonKey(name: 'error_message') String? errorMessage
});




}
/// @nodoc
class _$CashDroSimpleResponseCopyWithImpl<$Res>
    implements $CashDroSimpleResponseCopyWith<$Res> {
  _$CashDroSimpleResponseCopyWithImpl(this._self, this._then);

  final CashDroSimpleResponse _self;
  final $Res Function(CashDroSimpleResponse) _then;

/// Create a copy of CashDroSimpleResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CashDroSimpleResponse].
extension CashDroSimpleResponsePatterns on CashDroSimpleResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashDroSimpleResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashDroSimpleResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashDroSimpleResponse value)  $default,){
final _that = this;
switch (_that) {
case _CashDroSimpleResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashDroSimpleResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CashDroSimpleResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code, @JsonKey(name: 'error_message')  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashDroSimpleResponse() when $default != null:
return $default(_that.code,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int code, @JsonKey(name: 'error_message')  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CashDroSimpleResponse():
return $default(_that.code,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int code, @JsonKey(name: 'error_message')  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CashDroSimpleResponse() when $default != null:
return $default(_that.code,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CashDroSimpleResponse extends CashDroSimpleResponse {
  const _CashDroSimpleResponse({required this.code, @JsonKey(name: 'error_message') this.errorMessage}): super._();
  

@override final  int code;
@override@JsonKey(name: 'error_message') final  String? errorMessage;

/// Create a copy of CashDroSimpleResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashDroSimpleResponseCopyWith<_CashDroSimpleResponse> get copyWith => __$CashDroSimpleResponseCopyWithImpl<_CashDroSimpleResponse>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashDroSimpleResponse&&(identical(other.code, code) || other.code == code)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,code,errorMessage);

@override
String toString() {
  return 'CashDroSimpleResponse(code: $code, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CashDroSimpleResponseCopyWith<$Res> implements $CashDroSimpleResponseCopyWith<$Res> {
  factory _$CashDroSimpleResponseCopyWith(_CashDroSimpleResponse value, $Res Function(_CashDroSimpleResponse) _then) = __$CashDroSimpleResponseCopyWithImpl;
@override @useResult
$Res call({
 int code,@JsonKey(name: 'error_message') String? errorMessage
});




}
/// @nodoc
class __$CashDroSimpleResponseCopyWithImpl<$Res>
    implements _$CashDroSimpleResponseCopyWith<$Res> {
  __$CashDroSimpleResponseCopyWithImpl(this._self, this._then);

  final _CashDroSimpleResponse _self;
  final $Res Function(_CashDroSimpleResponse) _then;

/// Create a copy of CashDroSimpleResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? errorMessage = freezed,}) {
  return _then(_CashDroSimpleResponse(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$CashDroOperationStatus {

 int get code;@JsonKey(name: 'operation_id') String? get operationId; String? get state;// I, Q, E, F
@JsonKey(name: 'pay_in_progress') int? get payInProgress;// 0 o 1
@JsonKey(name: 'pay_out_progress') int? get payOutProgress;// 0 o 1
 String? get total;@JsonKey(name: 'total_in') String? get totalIn;@JsonKey(name: 'total_out') String? get totalOut;@JsonKey(name: 'with_error') bool? get withError;@JsonKey(name: 'error_message') String? get errorMessage;
/// Create a copy of CashDroOperationStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CashDroOperationStatusCopyWith<CashDroOperationStatus> get copyWith => _$CashDroOperationStatusCopyWithImpl<CashDroOperationStatus>(this as CashDroOperationStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashDroOperationStatus&&(identical(other.code, code) || other.code == code)&&(identical(other.operationId, operationId) || other.operationId == operationId)&&(identical(other.state, state) || other.state == state)&&(identical(other.payInProgress, payInProgress) || other.payInProgress == payInProgress)&&(identical(other.payOutProgress, payOutProgress) || other.payOutProgress == payOutProgress)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalIn, totalIn) || other.totalIn == totalIn)&&(identical(other.totalOut, totalOut) || other.totalOut == totalOut)&&(identical(other.withError, withError) || other.withError == withError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,code,operationId,state,payInProgress,payOutProgress,total,totalIn,totalOut,withError,errorMessage);

@override
String toString() {
  return 'CashDroOperationStatus(code: $code, operationId: $operationId, state: $state, payInProgress: $payInProgress, payOutProgress: $payOutProgress, total: $total, totalIn: $totalIn, totalOut: $totalOut, withError: $withError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $CashDroOperationStatusCopyWith<$Res>  {
  factory $CashDroOperationStatusCopyWith(CashDroOperationStatus value, $Res Function(CashDroOperationStatus) _then) = _$CashDroOperationStatusCopyWithImpl;
@useResult
$Res call({
 int code,@JsonKey(name: 'operation_id') String? operationId, String? state,@JsonKey(name: 'pay_in_progress') int? payInProgress,@JsonKey(name: 'pay_out_progress') int? payOutProgress, String? total,@JsonKey(name: 'total_in') String? totalIn,@JsonKey(name: 'total_out') String? totalOut,@JsonKey(name: 'with_error') bool? withError,@JsonKey(name: 'error_message') String? errorMessage
});




}
/// @nodoc
class _$CashDroOperationStatusCopyWithImpl<$Res>
    implements $CashDroOperationStatusCopyWith<$Res> {
  _$CashDroOperationStatusCopyWithImpl(this._self, this._then);

  final CashDroOperationStatus _self;
  final $Res Function(CashDroOperationStatus) _then;

/// Create a copy of CashDroOperationStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? code = null,Object? operationId = freezed,Object? state = freezed,Object? payInProgress = freezed,Object? payOutProgress = freezed,Object? total = freezed,Object? totalIn = freezed,Object? totalOut = freezed,Object? withError = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,operationId: freezed == operationId ? _self.operationId : operationId // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,payInProgress: freezed == payInProgress ? _self.payInProgress : payInProgress // ignore: cast_nullable_to_non_nullable
as int?,payOutProgress: freezed == payOutProgress ? _self.payOutProgress : payOutProgress // ignore: cast_nullable_to_non_nullable
as int?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as String?,totalIn: freezed == totalIn ? _self.totalIn : totalIn // ignore: cast_nullable_to_non_nullable
as String?,totalOut: freezed == totalOut ? _self.totalOut : totalOut // ignore: cast_nullable_to_non_nullable
as String?,withError: freezed == withError ? _self.withError : withError // ignore: cast_nullable_to_non_nullable
as bool?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CashDroOperationStatus].
extension CashDroOperationStatusPatterns on CashDroOperationStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashDroOperationStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashDroOperationStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashDroOperationStatus value)  $default,){
final _that = this;
switch (_that) {
case _CashDroOperationStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashDroOperationStatus value)?  $default,){
final _that = this;
switch (_that) {
case _CashDroOperationStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int code, @JsonKey(name: 'operation_id')  String? operationId,  String? state, @JsonKey(name: 'pay_in_progress')  int? payInProgress, @JsonKey(name: 'pay_out_progress')  int? payOutProgress,  String? total, @JsonKey(name: 'total_in')  String? totalIn, @JsonKey(name: 'total_out')  String? totalOut, @JsonKey(name: 'with_error')  bool? withError, @JsonKey(name: 'error_message')  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashDroOperationStatus() when $default != null:
return $default(_that.code,_that.operationId,_that.state,_that.payInProgress,_that.payOutProgress,_that.total,_that.totalIn,_that.totalOut,_that.withError,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int code, @JsonKey(name: 'operation_id')  String? operationId,  String? state, @JsonKey(name: 'pay_in_progress')  int? payInProgress, @JsonKey(name: 'pay_out_progress')  int? payOutProgress,  String? total, @JsonKey(name: 'total_in')  String? totalIn, @JsonKey(name: 'total_out')  String? totalOut, @JsonKey(name: 'with_error')  bool? withError, @JsonKey(name: 'error_message')  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CashDroOperationStatus():
return $default(_that.code,_that.operationId,_that.state,_that.payInProgress,_that.payOutProgress,_that.total,_that.totalIn,_that.totalOut,_that.withError,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int code, @JsonKey(name: 'operation_id')  String? operationId,  String? state, @JsonKey(name: 'pay_in_progress')  int? payInProgress, @JsonKey(name: 'pay_out_progress')  int? payOutProgress,  String? total, @JsonKey(name: 'total_in')  String? totalIn, @JsonKey(name: 'total_out')  String? totalOut, @JsonKey(name: 'with_error')  bool? withError, @JsonKey(name: 'error_message')  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CashDroOperationStatus() when $default != null:
return $default(_that.code,_that.operationId,_that.state,_that.payInProgress,_that.payOutProgress,_that.total,_that.totalIn,_that.totalOut,_that.withError,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CashDroOperationStatus extends CashDroOperationStatus {
  const _CashDroOperationStatus({required this.code, @JsonKey(name: 'operation_id') this.operationId, this.state, @JsonKey(name: 'pay_in_progress') this.payInProgress, @JsonKey(name: 'pay_out_progress') this.payOutProgress, this.total, @JsonKey(name: 'total_in') this.totalIn, @JsonKey(name: 'total_out') this.totalOut, @JsonKey(name: 'with_error') this.withError, @JsonKey(name: 'error_message') this.errorMessage}): super._();
  

@override final  int code;
@override@JsonKey(name: 'operation_id') final  String? operationId;
@override final  String? state;
// I, Q, E, F
@override@JsonKey(name: 'pay_in_progress') final  int? payInProgress;
// 0 o 1
@override@JsonKey(name: 'pay_out_progress') final  int? payOutProgress;
// 0 o 1
@override final  String? total;
@override@JsonKey(name: 'total_in') final  String? totalIn;
@override@JsonKey(name: 'total_out') final  String? totalOut;
@override@JsonKey(name: 'with_error') final  bool? withError;
@override@JsonKey(name: 'error_message') final  String? errorMessage;

/// Create a copy of CashDroOperationStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CashDroOperationStatusCopyWith<_CashDroOperationStatus> get copyWith => __$CashDroOperationStatusCopyWithImpl<_CashDroOperationStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashDroOperationStatus&&(identical(other.code, code) || other.code == code)&&(identical(other.operationId, operationId) || other.operationId == operationId)&&(identical(other.state, state) || other.state == state)&&(identical(other.payInProgress, payInProgress) || other.payInProgress == payInProgress)&&(identical(other.payOutProgress, payOutProgress) || other.payOutProgress == payOutProgress)&&(identical(other.total, total) || other.total == total)&&(identical(other.totalIn, totalIn) || other.totalIn == totalIn)&&(identical(other.totalOut, totalOut) || other.totalOut == totalOut)&&(identical(other.withError, withError) || other.withError == withError)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,code,operationId,state,payInProgress,payOutProgress,total,totalIn,totalOut,withError,errorMessage);

@override
String toString() {
  return 'CashDroOperationStatus(code: $code, operationId: $operationId, state: $state, payInProgress: $payInProgress, payOutProgress: $payOutProgress, total: $total, totalIn: $totalIn, totalOut: $totalOut, withError: $withError, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CashDroOperationStatusCopyWith<$Res> implements $CashDroOperationStatusCopyWith<$Res> {
  factory _$CashDroOperationStatusCopyWith(_CashDroOperationStatus value, $Res Function(_CashDroOperationStatus) _then) = __$CashDroOperationStatusCopyWithImpl;
@override @useResult
$Res call({
 int code,@JsonKey(name: 'operation_id') String? operationId, String? state,@JsonKey(name: 'pay_in_progress') int? payInProgress,@JsonKey(name: 'pay_out_progress') int? payOutProgress, String? total,@JsonKey(name: 'total_in') String? totalIn,@JsonKey(name: 'total_out') String? totalOut,@JsonKey(name: 'with_error') bool? withError,@JsonKey(name: 'error_message') String? errorMessage
});




}
/// @nodoc
class __$CashDroOperationStatusCopyWithImpl<$Res>
    implements _$CashDroOperationStatusCopyWith<$Res> {
  __$CashDroOperationStatusCopyWithImpl(this._self, this._then);

  final _CashDroOperationStatus _self;
  final $Res Function(_CashDroOperationStatus) _then;

/// Create a copy of CashDroOperationStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? code = null,Object? operationId = freezed,Object? state = freezed,Object? payInProgress = freezed,Object? payOutProgress = freezed,Object? total = freezed,Object? totalIn = freezed,Object? totalOut = freezed,Object? withError = freezed,Object? errorMessage = freezed,}) {
  return _then(_CashDroOperationStatus(
code: null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as int,operationId: freezed == operationId ? _self.operationId : operationId // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,payInProgress: freezed == payInProgress ? _self.payInProgress : payInProgress // ignore: cast_nullable_to_non_nullable
as int?,payOutProgress: freezed == payOutProgress ? _self.payOutProgress : payOutProgress // ignore: cast_nullable_to_non_nullable
as int?,total: freezed == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as String?,totalIn: freezed == totalIn ? _self.totalIn : totalIn // ignore: cast_nullable_to_non_nullable
as String?,totalOut: freezed == totalOut ? _self.totalOut : totalOut // ignore: cast_nullable_to_non_nullable
as String?,withError: freezed == withError ? _self.withError : withError // ignore: cast_nullable_to_non_nullable
as bool?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
