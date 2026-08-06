import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'stock_warning_provider.g.dart';

/// Notifier para controlar el modal de stock insuficiente
@Riverpod(keepAlive: true)
class StockWarning extends _$StockWarning {
  @override
  Set<String> build() {
    return <String>{};
  }

  /// Verifica si ya se mostró la advertencia para un producto/combo específico
  bool hasShownWarning(String itemId) {
    final hasShown = state.contains(itemId);
    print('🚨 StockWarning: ¿Ya se mostró advertencia para $itemId? $hasShown');
    return hasShown;
  }

  /// Marca que ya se mostró la advertencia para un producto/combo
  void markWarningShown(String itemId) {
    print('🚨 StockWarning: Marcando advertencia mostrada para $itemId');
    state = {...state, itemId};
    print('🚨 StockWarning: Total items con advertencia mostrada: ${state.length}');
  }

  void resetSession() {
    print('🚨 StockWarning: Reiniciando sesión de advertencias');
    state = <String>{};
  }

  /// Obtiene la lista de items que ya mostraron advertencia (para debugging)
  Set<String> get shownWarnings => Set.from(state);
}
