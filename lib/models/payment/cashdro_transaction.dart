import 'package:freezed_annotation/freezed_annotation.dart';

part 'cashdro_transaction.freezed.dart';
part 'cashdro_transaction.g.dart';

/// Estados de una transacción CashDro
enum CashDroTransactionState {
  @JsonValue('idle')
  idle,
  @JsonValue('starting')
  starting,
  @JsonValue('acknowledged')
  acknowledged,
  @JsonValue('executing')
  executing,
  @JsonValue('polling')
  polling,
  @JsonValue('finishing')
  finishing, // Transacción finalizada, mostrando WebView antes de navegar
  @JsonValue('completed')
  completed,
  @JsonValue('error')
  error,
  @JsonValue('cancelled')
  cancelled,
}

/// Modelo de transacción CashDro
@freezed
sealed class CashDroTransaction with _$CashDroTransaction {
  const factory CashDroTransaction({
    @JsonKey(name: 'operation_id') String? operationId,
    @Default(0.0) double amount,
    @Default(CashDroTransactionState.idle) CashDroTransactionState state,
    @JsonKey(name: 'total_in') double? totalIn,
    @JsonKey(name: 'total_out') double? totalOut,
    @JsonKey(name: 'with_error') bool? withError,
    @JsonKey(name: 'error_message') String? errorMessage,
    @JsonKey(name: 'pay_in_progress') int? payInProgress,
    @JsonKey(name: 'pay_out_progress') int? payOutProgress,
    @JsonKey(name: 'alias_id') String? aliasId,
  }) = _CashDroTransaction;

  const CashDroTransaction._();

  /// Transacción inicial
  factory CashDroTransaction.initial(double amount) {
    return CashDroTransaction(
      amount: amount,
      state: CashDroTransactionState.idle,
    );
  }

  /// JSON serialization
  factory CashDroTransaction.fromJson(Map<String, dynamic> json) =>
      _$CashDroTransactionFromJson(json);

  /// Verifica si la transacción está completa
  bool get isCompleted => state == CashDroTransactionState.completed;

  /// Verifica si la transacción tiene error
  bool get hasError => state == CashDroTransactionState.error || withError == true;

  /// Verifica si la transacción está en progreso
  bool get isInProgress {
    return state == CashDroTransactionState.starting ||
        state == CashDroTransactionState.acknowledged ||
        state == CashDroTransactionState.executing ||
        state == CashDroTransactionState.polling;
  }

  /// Verifica si el cobro está completo (payInProgress == 1)
  bool get isPaymentComplete => payInProgress == 1;

  /// Verifica si el cambio fue dispensado (payOutProgress == 1)
  bool get isChangeDispensed => payOutProgress == 1;
}

/// Respuesta de inicio de operación
@freezed
sealed class CashDroStartResponse with _$CashDroStartResponse {
  const factory CashDroStartResponse({
    required int code,
    @JsonKey(name: 'operation_id') String? operationId,
    @JsonKey(name: 'error_message') String? errorMessage,
  }) = _CashDroStartResponse;

  const CashDroStartResponse._();

  /// JSON serialization
  factory CashDroStartResponse.fromJson(Map<String, dynamic> json) {
    final code = json['code'] as int;
    final response = json['response'] as Map<String, dynamic>?;
    
    return CashDroStartResponse(
      code: code,
      operationId: response?['operation']?['operationId'] as String?,
      errorMessage: response?['errorMessage'] as String?,
    );
  }

  bool get isSuccess => code == 1;
}

/// Respuesta de operación simple (acknowledge, import, cancel)
@freezed
sealed class CashDroSimpleResponse with _$CashDroSimpleResponse {
  const factory CashDroSimpleResponse({
    required int code,
    @JsonKey(name: 'error_message') String? errorMessage,
  }) = _CashDroSimpleResponse;

  const CashDroSimpleResponse._();

  /// JSON serialization
  factory CashDroSimpleResponse.fromJson(Map<String, dynamic> json) {
    final code = json['code'] as int;
    final response = json['response'] as Map<String, dynamic>?;
    
    return CashDroSimpleResponse(
      code: code,
      errorMessage: response?['errorMessage'] as String?,
    );
  }

  bool get isSuccess => code == 1;
}

/// Estado de operación (askOperation)
@freezed
sealed class CashDroOperationStatus with _$CashDroOperationStatus {
  const factory CashDroOperationStatus({
    required int code,
    @JsonKey(name: 'operation_id') String? operationId,
    String? state, // I, Q, E, F
    @JsonKey(name: 'pay_in_progress') int? payInProgress, // 0 o 1
    @JsonKey(name: 'pay_out_progress') int? payOutProgress, // 0 o 1
    String? total,
    @JsonKey(name: 'total_in') String? totalIn,
    @JsonKey(name: 'total_out') String? totalOut,
    @JsonKey(name: 'with_error') bool? withError,
    @JsonKey(name: 'error_message') String? errorMessage,
  }) = _CashDroOperationStatus;

  const CashDroOperationStatus._();

  /// JSON serialization
  factory CashDroOperationStatus.fromJson(Map<String, dynamic> json) {
    final code = json['code'] as int;
    final response = json['response'] as Map<String, dynamic>?;
    final operation = response?['operation'] as Map<String, dynamic>?;
    final operationData = operation?['operation'] as Map<String, dynamic>?;

    return CashDroOperationStatus(
      code: code,
      operationId: operationData?['operationid'] as String?,
      state: operationData?['state'] as String?,
      payInProgress: operationData?['payInProgress'] as int?,
      payOutProgress: operationData?['payOutProgress'] as int?,
      total: operationData?['total'] as String?,
      totalIn: operationData?['totalin'] as String?,
      totalOut: operationData?['totalout'] as String?,
      withError: operation?['withError'] as bool?,
      errorMessage: response?['errorMessage'] as String?,
    );
  }

  bool get isSuccess => code == 1;
  bool get isFinished => state == 'F';
  bool get isExecuting => state == 'E';
  bool get isQueued => state == 'Q';
  bool get isPending => state == 'I';

  /// Convierte totalIn de string a double (divide por 100)
  double? get totalInAmount {
    if (totalIn == null) return null;
    final value = int.tryParse(totalIn!);
    return value != null ? value / 100.0 : null;
  }

  /// Convierte totalOut de string a double (divide por 100, valor negativo)
  double? get totalOutAmount {
    if (totalOut == null) return null;
    final value = int.tryParse(totalOut!);
    return value != null ? value.abs() / 100.0 : null;
  }
}
