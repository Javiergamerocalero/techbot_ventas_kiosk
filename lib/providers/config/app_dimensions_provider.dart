import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:riverpod/riverpod.dart';
part 'app_dimensions_provider.g.dart';

@riverpod
AppDimensions appDimensions(Ref ref, BuildContext context) {
  final size = MediaQuery.sizeOf(context);
  final width = size.width;
  final height = size.height;

  // Cálculos proporcionales y escalables
  final spacingXS = width * 0.01;
  final spacingS = width * 0.02;
  final spacingM = width * 0.04;
  final spacingL = width * 0.08;
  final spacingXL = width * 0.12;

  final paddingS = EdgeInsets.all(width * 0.02);
  final paddingM = EdgeInsets.all(width * 0.04);
  final paddingL = EdgeInsets.all(width * 0.08);
  final marginS = EdgeInsets.all(width * 0.02);
  final marginM = EdgeInsets.all(width * 0.04);
  final marginL = EdgeInsets.all(width * 0.08);

  final fontSizeTitle = width * 0.06; // ~24 en 400px
  final fontSizeSubtitle = width * 0.045; // ~18
  final fontSizeBody = width * 0.04; // ~16
  final fontSizeCaption = width * 0.03; // ~12
  final fontSizeButton = width * 0.04; // ~16

  final imageSizeS = width * 0.15; // ~60
  final imageSizeM = width * 0.2;  // ~80
  final imageSizeL = width * 0.3;  // ~120
  final cardHeight = height * 0.12; // ~80 en 600px
  final cardWidth = width * 0.2;    // ~80 en 400px

  final iconSizeS = width * 0.04;
  final iconSizeM = width * 0.06;
  final iconSizeL = width * 0.08;

  final borderRadiusS = width * 0.02;
  final borderRadiusM = width * 0.04;
  final borderRadiusL = width * 0.08;

  final horizontalPadding = width * 0.05; // 5% del ancho
  final verticalPadding = height * 0.025; // 2.5% del alto
  final smallSpacing = width * 0.02; // 2% del ancho
  final mediumSpacing = width * 0.04; // 4% del ancho
  final largeSpacing = width * 0.08; // 8% del ancho
  final iconSize = width * 0.07; // 7% del ancho
  final borderRadius = width * 0.04; // 4% del ancho
  final appBarHeight = height * 0.09; // 9% del alto
  final buttonHeight = height * 0.065; // 6.5% del alto

  // Default border width for all UI borders
  const borderWidth = 1.0;

  return AppDimensions(
    paddingAllM: EdgeInsets.all(spacingM),
    // Dimensiones pantalla
    screenWidth: width,
    screenHeight: height,
    borderWidth: borderWidth,
    // Espaciados
    spacingXS: spacingXS,
    spacingS: spacingS,
    spacingM: spacingM,
    spacingL: spacingL,
    spacingXL: spacingXL,
    // Paddings y margins
    paddingS: paddingS,
    paddingM: paddingM,
    paddingMDouble: spacingM,
    paddingL: paddingL,
    marginS: marginS,
    marginM: marginM,
    marginL: marginL,
    // Font sizes
    fontSizeTitle: fontSizeTitle,
    fontSizeSubtitle: fontSizeSubtitle,
    fontSizeBody: fontSizeBody,
    fontSizeCaption: fontSizeCaption,
    fontSizeButton: fontSizeButton,
    // Imágenes/cards
    imageSizeS: imageSizeS,
    imageSizeM: imageSizeM,
    imageSizeL: imageSizeL,
    cardHeight: cardHeight,
    cardWidth: cardWidth,
    // Otros
    iconSizeS: iconSizeS,
    iconSizeM: iconSizeM,
    iconSizeL: iconSizeL,
    borderRadiusS: borderRadiusS,
    borderRadiusM: borderRadiusM,
    borderRadiusL: borderRadiusL,
    // AppBar y botones
    appBarHeight: appBarHeight,
    buttonHeight: buttonHeight,
    // Compatibilidad legacy
    horizontalPadding: horizontalPadding,
    verticalPadding: verticalPadding,
    smallSpacing: smallSpacing,
    mediumSpacing: mediumSpacing,
    largeSpacing: largeSpacing,
    iconSize: iconSize,
    borderRadius: borderRadius,
    blurRadius: width * 0.04,
  );
}
