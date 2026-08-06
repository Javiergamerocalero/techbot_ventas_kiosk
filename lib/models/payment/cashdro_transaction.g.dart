// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashdro_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CashDroTransaction _$CashDroTransactionFromJson(Map<String, dynamic> json) =>
    _CashDroTransaction(
      operationId: json['operation_id'] as String?,
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      state:
          $enumDecodeNullable(
            _$CashDroTransactionStateEnumMap,
            json['state'],
          ) ??
          CashDroTransactionState.idle,
      totalIn: (json['total_in'] as num?)?.toDouble(),
      totalOut: (json['total_out'] as num?)?.toDouble(),
      withError: json['with_error'] as bool?,
      errorMessage: json['error_message'] as String?,
      payInProgress: (json['pay_in_progress'] as num?)?.toInt(),
      payOutProgress: (json['pay_out_progress'] as num?)?.toInt(),
      aliasId: json['alias_id'] as String?,
    );

Map<String, dynamic> _$CashDroTransactionToJson(_CashDroTransaction instance) =>
    <String, dynamic>{
      'operation_id': instance.operationId,
      'amount': instance.amount,
      'state': _$CashDroTransactionStateEnumMap[instance.state]!,
      'total_in': instance.totalIn,
      'total_out': instance.totalOut,
      'with_error': instance.withError,
      'error_message': instance.errorMessage,
      'pay_in_progress': instance.payInProgress,
      'pay_out_progress': instance.payOutProgress,
      'alias_id': instance.aliasId,
    };

const _$CashDroTransactionStateEnumMap = {
  CashDroTransactionState.idle: 'idle',
  CashDroTransactionState.starting: 'starting',
  CashDroTransactionState.acknowledged: 'acknowledged',
  CashDroTransactionState.executing: 'executing',
  CashDroTransactionState.polling: 'polling',
  CashDroTransactionState.finishing: 'finishing',
  CashDroTransactionState.completed: 'completed',
  CashDroTransactionState.error: 'error',
  CashDroTransactionState.cancelled: 'cancelled',
};
