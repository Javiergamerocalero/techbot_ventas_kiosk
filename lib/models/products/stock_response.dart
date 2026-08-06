import 'package:freezed_annotation/freezed_annotation.dart';

part 'stock_response.freezed.dart';
part 'stock_response.g.dart';

/// Modelo que representa la respuesta de validación de stock.
@freezed
sealed class StockResponse with _$StockResponse {
  /// [isAvailable]: indica si hay stock disponible.
  /// [availableStock]: cantidad de stock disponible.
  /// [message]: mensaje descriptivo del estado.
  /// [additionalData]: datos adicionales del API (opcional).
  const factory StockResponse({
    required bool isAvailable,
    required int availableStock,
    required String message,
    Map<String, dynamic>? additionalData,
  }) = _StockResponse;

  factory StockResponse.fromJson(Map<String, dynamic> json) =>
      _$StockResponseFromJson(json);
}

/// Extensión con helpers para lógica de negocio sobre stock.
extension StockResponseExtension on StockResponse {
  /// Indica si hay stock suficiente para la cantidad solicitada.
  bool hasEnoughStock(int requestedQuantity) {
    return isAvailable && availableStock >= requestedQuantity;
  }

  /// Devuelve un mensaje personalizado según el estado del stock.
  String getDisplayMessage(String productName) {
    if (isAvailable) {
      return 'Producto agregado al carrito';
    } else {
      return 'Lo sentimos, "$productName" no está disponible en este momento';
    }
  }
}
