import 'package:flutter/material.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';

/// Helpers de layout centralizados para la UI de productos
class AppLayout {
  /// Padding horizontal estándar para secciones de productos
  static const double horizontalPagePadding = 12.0;

  /// Dimensiones base para ThemeData (sin contexto)
  static const double baseFontSizeTitle = 20.0;
  static const double baseFontSizeButton = 16.0;
  static const double baseBorderRadiusS = 8.0;
  static const double baseBorderRadiusM = 12.0;
  static const double baseBorderRadiusL = 16.0;
  static const double baseBorderRadiusXL = 20.0;
  static const double baseElevation = 2.0;
  static const double basePaddingHorizontal = 24.0;
  static const double basePaddingVertical = 12.0;
  static const double baseBorderWidth = 2.0;

  /// Calcula la altura de una imagen dado un ancho y un aspecto (por defecto 16:9)
  static double imageHeightForAspect({
    required double width,
    double aspectWidth = 16,
    double aspectHeight = 9,
  }) {
    return width * (aspectHeight / aspectWidth);
  }

  /// Alto estimado del bloque de texto para mini cards (nombre, caption, precio)
  static double miniCardTextBlockHeight(
    AppDimensions d,
    TextScaler scaler, {
    int nameLines = 2,
    double lineHeight = 1.2,
    double lineHeightPrice = 1.2,
  }) {
    final nameHeight = scaler.scale(d.fontSizeBody) * nameLines * lineHeight;
    final captionHeight = scaler.scale(d.fontSizeCaption) * lineHeight;
    final priceSmallFont = d.fontSizeBody * 1.20; // igual que AppTextStyles.priceSmall
    final priceHeight = scaler.scale(priceSmallFont) * lineHeightPrice;
    return d.paddingS.vertical +
        (d.spacingXS * 2) +
        nameHeight +
        captionHeight +
        priceHeight +
        d.spacingM; // margen extra
  }

  /// Devuelve las métricas completas para la sección horizontal de productos.
  static ProductSectionMetrics productSectionMetrics({
    required BuildContext context,
    required AppDimensions dimensions,
    required TextScaler textScaler,
    int nameLines = 2,
    double lineHeight = 1.2,
    double lineHeightPrice = 1.2,
    double? pagePadding,
  }) {
    final double hp = pagePadding ?? horizontalPagePadding;
    final width = MediaQuery.sizeOf(context).width;
    final available = width - (hp * 2);
    // Dos cards visibles con un espacio entre ellas
    final cardWidth = (available - dimensions.spacingS) / 2;
    // Altura de imagen según AspectRatio 16:9
    final imageHeight = imageHeightForAspect(width: cardWidth);
    // Alto estimado del bloque de texto
    final textHeight = miniCardTextBlockHeight(
      dimensions,
      textScaler,
      nameLines: nameLines,
      lineHeight: lineHeight,
      lineHeightPrice: lineHeightPrice,
    );
    final listHeight = imageHeight + textHeight + dimensions.spacingS; // seguridad

    return ProductSectionMetrics(
      cardWidth: cardWidth,
      imageHeight: imageHeight,
      textHeight: textHeight,
      listHeight: listHeight,
      horizontalPadding: hp,
    );
  }
}

/// Contenedor de métricas para la sección horizontal de productos.
class ProductSectionMetrics {
  final double cardWidth;
  final double imageHeight;
  final double textHeight;
  final double listHeight;
  final double horizontalPadding;

  const ProductSectionMetrics({
    required this.cardWidth,
    required this.imageHeight,
    required this.textHeight,
    required this.listHeight,
    required this.horizontalPadding,
  });
}
