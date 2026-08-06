import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'app_dimensions.freezed.dart';

@freezed
sealed class AppDimensions with _$AppDimensions {
  const AppDimensions._();

  /// Modelo centralizado para todas las dimensiones responsivas y constantes visuales de la app.
  const factory AppDimensions({
    // Dimensiones de pantalla
    required double screenWidth,
    required double screenHeight,
    required double borderWidth,

    // Espaciados
    required double spacingXS, // Extra pequeño
    required double spacingS,  // Pequeño
    required double spacingM,  // Mediano
    required double spacingL,  // Grande
    required double spacingXL, // Extra grande

    // Paddings y Margins
    required EdgeInsets paddingS,
    required EdgeInsets paddingM,
    required double paddingMDouble,
    required EdgeInsets paddingL,
    required EdgeInsets marginS,
    required EdgeInsets marginM,
    required EdgeInsets marginL,
    required EdgeInsets paddingAllM,

    // Tamaños de fuente
    required double fontSizeTitle,
    required double fontSizeSubtitle,
    required double fontSizeBody,
    required double fontSizeCaption,
    required double fontSizeButton,

    // Tamaños de imágenes y cards
    required double imageSizeS,
    required double imageSizeM,
    required double imageSizeL,
    required double cardHeight,
    required double cardWidth,

    // Otros tamaños y radios
    required double iconSizeS,
    required double iconSizeM,
    required double iconSizeL,
    required double borderRadiusS,
    required double borderRadiusM,
    required double borderRadiusL,

    // AppBar y botones
    required double appBarHeight,
    required double buttonHeight,

    // Compatibilidad con provider
    required double horizontalPadding,
    required double verticalPadding,
    required double smallSpacing,
    required double mediumSpacing,
    required double largeSpacing,
    required double iconSize,
    required double borderRadius,
    required double blurRadius,
  }) = _AppDimensions;

  /// Tamaño de fuente para precios
  double get fontSizePrice => fontSizeTitle * 1.1;

  /// Tamaño de fuente para descripciones largas
  double get fontSizeDescription => fontSizeBody * 0.98;

  /// Alto recomendado para ProductMiniCard (ajustado para mostrar más texto)
  double get productMiniCardHeight => screenHeight * 0.30;

}