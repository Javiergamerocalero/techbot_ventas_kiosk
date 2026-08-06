import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider para manejar el estado de loading de botones de incremento/decremento
/// Evita múltiples llamadas simultáneas a endpoints
class ButtonLoadingNotifier extends StateNotifier<Map<String, bool>> {
  ButtonLoadingNotifier() : super({});

  /// Marca un botón como loading
  void setLoading(String key, bool isLoading) {
    state = {...state, key: isLoading};
  }

  /// Verifica si un botón está en loading
  bool isLoading(String key) {
    return state[key] ?? false;
  }

  /// Ejecuta una operación async mientras mantiene el estado de loading
  Future<T> executeWithLoading<T>(String key, Future<T> Function() operation) async {
    if (isLoading(key)) {
      throw Exception('Operation already in progress for key: $key');
    }

    setLoading(key, true);
    try {
      final result = await operation();
      return result;
    } finally {
      setLoading(key, false);
    }
  }
}

/// Provider global para el estado de loading de botones
final buttonLoadingProvider = StateNotifierProvider<ButtonLoadingNotifier, Map<String, bool>>((ref) {
  return ButtonLoadingNotifier();
});

/// Provider para verificar si un botón específico está en loading
final buttonIsLoadingProvider = Provider.family<bool, String>((ref, key) {
  final loadingState = ref.watch(buttonLoadingProvider);
  return loadingState[key] ?? false;
});
