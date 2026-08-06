import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/config/payment_method.dart';

part 'payment_methods_provider.g.dart';

/// Provider para gestionar los métodos de pago
@Riverpod(keepAlive: true)
class PaymentMethodsNotifier extends _$PaymentMethodsNotifier {
  static const String _storageKey = 'payment_methods_config';

  @override
  Future<PaymentMethodsConfig> build() async {
    print('💳 PaymentMethodsProvider: Inicializando...');
    return await _loadFromStorage();
  }

  /// Carga la configuración desde SharedPreferences
  Future<PaymentMethodsConfig> _loadFromStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);

      if (jsonString != null) {
        final json = jsonDecode(jsonString) as Map<String, dynamic>;
        final config = PaymentMethodsConfig.fromJson(json);
        print('💳 PaymentMethodsProvider: Configuración cargada - ${config.methods.length} métodos');
        return config;
      }
    } catch (e) {
      print('❌ PaymentMethodsProvider: Error al cargar configuración: $e');
    }

    // Retornar configuración por defecto con todos los métodos desactivados
    print('💳 PaymentMethodsProvider: Usando configuración por defecto');
    return _getDefaultConfig();
  }

  /// Guarda la configuración en SharedPreferences
  Future<void> _saveToStorage(PaymentMethodsConfig config) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(config.toJson());
      await prefs.setString(_storageKey, jsonString);
      print('💳 PaymentMethodsProvider: Configuración guardada exitosamente');
    } catch (e) {
      print('❌ PaymentMethodsProvider: Error al guardar configuración: $e');
    }
  }

  /// Configuración por defecto con todos los métodos desactivados
  PaymentMethodsConfig _getDefaultConfig() {
    return PaymentMethodsConfig(
      methods: PaymentMethodType.values.map((type) {
        return PaymentMethod(
          type: type,
          isActive: false,
          configuration: {},
        );
      }).toList(),
    );
  }

  /// Activa o desactiva un método de pago
  Future<void> togglePaymentMethod(PaymentMethodType type, bool isActive) async {
    print('💳 PaymentMethodsProvider: ${isActive ? "Activando" : "Desactivando"} ${type.displayName}');

    final currentConfig = await future;
    final updatedMethods = currentConfig.methods.map((method) {
      if (method.type == type) {
        return method.copyWith(isActive: isActive);
      }
      return method;
    }).toList();

    final newConfig = PaymentMethodsConfig(methods: updatedMethods);
    await _saveToStorage(newConfig);
    state = AsyncValue.data(newConfig);
  }

  /// Actualiza la configuración de un método de pago
  Future<void> updatePaymentMethodConfig(
    PaymentMethodType type,
    Map<String, dynamic> configuration,
  ) async {
    print('💳 PaymentMethodsProvider: Actualizando configuración de ${type.displayName}');

    final currentConfig = await future;
    final updatedMethods = currentConfig.methods.map((method) {
      if (method.type == type) {
        return method.copyWith(configuration: configuration);
      }
      return method;
    }).toList();

    final newConfig = PaymentMethodsConfig(methods: updatedMethods);
    await _saveToStorage(newConfig);
    state = AsyncValue.data(newConfig);
  }

  /// Obtiene un método de pago específico
  PaymentMethod? getPaymentMethod(PaymentMethodType type) {
    final config = state.value;
    if (config == null) return null;

    try {
      return config.methods.firstWhere((method) => method.type == type);
    } catch (e) {
      return null;
    }
  }

  /// Obtiene todos los métodos de pago activos
  List<PaymentMethod> getActivePaymentMethods() {
    final config = state.value;
    if (config == null) return [];

    return config.methods.where((method) => method.isActive).toList();
  }

  /// Reinicia la configuración a valores por defecto
  Future<void> resetToDefaults() async {
    print('💳 PaymentMethodsProvider: Reiniciando a configuración por defecto');
    final defaultConfig = _getDefaultConfig();
    await _saveToStorage(defaultConfig);
    state = AsyncValue.data(defaultConfig);
  }
}

/// Provider derivado para obtener métodos activos
@riverpod
List<PaymentMethod> activePaymentMethods(Ref ref) {
  final configAsync = ref.watch(paymentMethodsNotifierProvider);
  return configAsync.when(
    data: (config) => config.methods.where((m) => m.isActive).toList(),
    loading: () => [],
    error: (_, __) => [],
  );
}

/// Provider derivado para verificar si un método está activo
@riverpod
bool isPaymentMethodActive(Ref ref, PaymentMethodType type) {
  final configAsync = ref.watch(paymentMethodsNotifierProvider);
  return configAsync.when(
    data: (config) {
      try {
        final method = config.methods.firstWhere((m) => m.type == type);
        return method.isActive;
      } catch (e) {
        return false;
      }
    },
    loading: () => false,
    error: (_, __) => false,
  );
}
