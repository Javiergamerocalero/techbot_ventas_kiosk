import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../models/payment/cashdro_transaction.dart';
import '../../services/cashdro_payment_service.dart';
import '../../services/cashdro_config_service.dart';

part 'cashdro_payment_provider.g.dart';

/// Provider del servicio CashDro
@riverpod
CashDroPaymentService cashdroPaymentService(Ref ref) {
  return CashDroPaymentService();
}

/// Provider del estado de la transacción CashDro
@Riverpod(keepAlive: true)
class CashdroPaymentNotifier extends _$CashdroPaymentNotifier {
  Timer? _pollingTimer;
  int _pollingAttempts = 0;
  static const int _maxPollingAttempts = 120; // 2 minutos (cada 1 segundo)
  static const Duration _pollingInterval = Duration(seconds: 1);

  @override
  CashDroTransaction build() {
    // Configurar limpieza automática cuando el provider se dispose
    ref.onDispose(() {
      _pollingTimer?.cancel();
    });
    
    return CashDroTransaction.initial(0.0);
  }

  CashDroPaymentService get _service => ref.read(cashdroPaymentServiceProvider);

  /// Ejecutar flujo completo de pago
  Future<void> executePayment({
    required double amount,
    String? aliasId,
  }) async {
    try {
      print('💰 CashDro: Iniciando flujo de pago por \$${amount.toStringAsFixed(2)}');

      // Obtener configuración de SharedPreferences
      var config = await CashdroConfigService.getConfig();

      // Si no hay configuración, usar valores por defecto para simulación
      if (!config.isConfigured) {
        print('⚠️ CashDro: Sin configuración - usando valores por defecto para simulación');
        config = CashdroConfig(
          ipAddress: '192.168.1.100',
          username: 'admin',
          password: 'admin123',
        );
      } else {
        print('✅ CashDro: Configuración obtenida - IP: ${config.ipAddress}');
      }

      // Reiniciar estado
      state = CashDroTransaction.initial(amount).copyWith(
        aliasId: aliasId,
      );

      // Paso 1: Iniciar transacción
      await _startTransaction(config, amount, aliasId);

      if (state.hasError) return;

      // Paso 2: Confirmar ejecución
      await _acknowledgeTransaction(config);

      if (state.hasError) return;

      // Paso 3: Iniciar polling del estado
      _startPolling(config);
    } catch (e) {
      print('❌ CashDro: Error en executePayment: $e');
      state = state.copyWith(
        state: CashDroTransactionState.error,
        errorMessage: 'Error inesperado: $e',
      );
    }
  }

  /// Paso 1: Iniciar transacción de venta
  Future<void> _startTransaction(
    CashdroConfig config,
    double amount,
    String? aliasId,
  ) async {
    state = state.copyWith(state: CashDroTransactionState.starting);

    final response = await _service.startSaleOperation(
      ipAddress: config.ipAddress,
      username: config.username,
      password: config.password,
      amount: amount,
      aliasId: aliasId,
    );

    if (response.isSuccess && response.operationId != null) {
      state = state.copyWith(
        operationId: response.operationId,
        state: CashDroTransactionState.acknowledged,
      );
    } else {
      final errorMsg = response.errorMessage ?? 
          _service.getErrorMessage(response.code);
      
      state = state.copyWith(
        state: CashDroTransactionState.error,
        errorMessage: errorMsg,
      );
    }
  }

  /// Paso 2: Confirmar ejecución de la transacción
  Future<void> _acknowledgeTransaction(CashdroConfig config) async {
    if (state.operationId == null) {
      state = state.copyWith(
        state: CashDroTransactionState.error,
        errorMessage: 'No se pudo obtener el ID de operación',
      );
      return;
    }

    final response = await _service.acknowledgeOperation(
      ipAddress: config.ipAddress,
      username: config.username,
      password: config.password,
      operationId: state.operationId!,
    );

    if (response.isSuccess) {
      state = state.copyWith(
        state: CashDroTransactionState.executing,
      );
    } else {
      final errorMsg = response.errorMessage ?? 
          _service.getErrorMessage(response.code);
      
      state = state.copyWith(
        state: CashDroTransactionState.error,
        errorMessage: errorMsg,
      );
    }
  }

  /// Paso 3: Iniciar polling del estado de la transacción
  void _startPolling(CashdroConfig config) {
    _pollingAttempts = 0;
    state = state.copyWith(state: CashDroTransactionState.polling);

    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(_pollingInterval, (timer) async {
      await _checkTransactionStatus(config);

      _pollingAttempts++;

      // Si alcanzamos el máximo de intentos, cancelar
      if (_pollingAttempts >= _maxPollingAttempts) {
        print('⏱️ CashDro: Timeout - máximo de intentos alcanzado');
        timer.cancel();
        state = state.copyWith(
          state: CashDroTransactionState.error,
          errorMessage: 'Tiempo de espera agotado. La transacción tomó demasiado tiempo.',
        );
      }

      // Si la transacción terminó (completada o error), detener polling
      if (state.state == CashDroTransactionState.completed ||
          state.state == CashDroTransactionState.error) {
        timer.cancel();
      }
    });
  }

  /// Verificar estado de la transacción
  Future<void> _checkTransactionStatus(CashdroConfig config) async {
    if (state.operationId == null) return;

    final status = await _service.askOperation(
      ipAddress: config.ipAddress,
      username: config.username,
      password: config.password,
      operationId: state.operationId!,
    );

    if (!status.isSuccess) {
      final errorMsg = status.errorMessage ?? 
          _service.getErrorMessage(status.code);
      
      state = state.copyWith(
        state: CashDroTransactionState.error,
        errorMessage: errorMsg,
      );
      return;
    }

    // Actualizar estado con la información recibida
    state = state.copyWith(
      totalIn: status.totalInAmount,
      totalOut: status.totalOutAmount,
      payInProgress: status.payInProgress,
      payOutProgress: status.payOutProgress,
      withError: status.withError,
    );

    // Verificar si hay error en el dispositivo
    if (status.withError == true) {
      state = state.copyWith(
        state: CashDroTransactionState.error,
        errorMessage: 'Error en el dispositivo CashDro. Por favor, revise el estado.',
      );
      return;
    }

    // Verificar si la transacción finalizó
    if (status.isFinished) {
      print('✅ CashDro: Transacción finalizada');
      await _importTransaction(config);
    }
  }

  /// Paso 4: Importar la transacción
  Future<void> _importTransaction(CashdroConfig config) async {
    if (state.operationId == null) return;

    final response = await _service.importOperation(
      ipAddress: config.ipAddress,
      username: config.username,
      password: config.password,
      operationId: state.operationId!,
    );

    if (response.isSuccess) {
      print('✅ CashDro: Pago completado exitosamente');
      
      // Marcar como "finishing" para mostrar WebView
      state = state.copyWith(
        state: CashDroTransactionState.finishing,
      );
      
      print('⏱️ CashDro: Transacción en estado finishing');
      print('   La pantalla mostrará WebView por 30 segundos');
    } else {
      // Aunque falle el import, si la transacción se completó, considerarla exitosa
      print('⚠️ CashDro: Error al importar pero transacción completada');
      state = state.copyWith(
        state: CashDroTransactionState.finishing,
      );
    }
  }

  /// Cancelar transacción en curso
  Future<void> cancelTransaction() async {
    final operationId = state.operationId;
    
    // Cancelar timer inmediatamente
    _pollingTimer?.cancel();
    
    if (operationId == null) {
      print('⚠️ CashDro: No hay transacción para cancelar');
      state = state.copyWith(state: CashDroTransactionState.cancelled);
      return;
    }

    try {
      print('🛑 CashDro: Cancelando transacción $operationId');

      // Marcar como cancelado inmediatamente para evitar loops
      state = state.copyWith(state: CashDroTransactionState.cancelled);

      final config = await CashdroConfigService.getConfig();

      if (!config.isConfigured) {
        print('❌ CashDro: No se puede cancelar - configuración no encontrada');
        return;
      }

      // Usar timeout de 3 segundos para la cancelación
      final response = await _service.cancelOperation(
        ipAddress: config.ipAddress,
        username: config.username,
        password: config.password,
        operationId: operationId,
      ).timeout(
        const Duration(seconds: 3),
        onTimeout: () {
          print('⏱️ CashDro: Timeout en cancelación - continuando');
          return CashDroSimpleResponse(code: 1, errorMessage: 'timeout');
        },
      );

      if (response.isSuccess) {
        print('✅ CashDro: Transacción cancelada exitosamente');
      } else {
        print('❌ CashDro: Error al cancelar - ${response.errorMessage}');
      }
    } catch (e) {
      print('❌ CashDro: Error en cancelTransaction: $e');
      // Mantener estado cancelado aunque falle
    }
  }

  /// Reiniciar para nueva transacción
  void reset() {
    _pollingTimer?.cancel();
    _pollingAttempts = 0;
    state = CashDroTransaction.initial(0.0);
    print('🔄 CashDro: Estado reiniciado');
  }

  // El dispose se maneja automáticamente con @Riverpod
  // Se puede usar ref.onDispose si es necesario
}
