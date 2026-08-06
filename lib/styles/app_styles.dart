import 'package:flutter/material.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';

/// Paleta de colores centralizada para la app
class AppColors {
  static const primary = Color(0xFF0A73FF);  // Azul #0A73FF
  static const secondary = Color(0xFF00C897);
  static const background = Color(0xFFF9F9F9);
  static const textPrimary = Color(0xFF222222);
  static const textSecondary = Color(0xFF757575);
  static const divider = Color(0xFFE0E0E0);
  static const white = Colors.white;
  static const error = Color(0xFFE53935);
  static const success = Color(0xFF43A047); // Verde
  static const info = Color(0xFF2196F3); // Azul info
  static const warning = Color(0xFFFFC107); // Amarillo
  static const greyLight = Color(0xFFF5F5F5);
  static const grey = Color(0xFFBDBDBD);
  static const greyDark = Color(0xFF616161);
  static const greenLight = Color(0xFFE8F5E9);
  static const green = Color(0xFF4CAF50);
  static const greenDark = Color(0xFF388E3C);
}

/// Estilos de texto centralizados y responsivos
class AppTextStyles {
  static TextStyle title(AppDimensions d) => TextStyle(
    fontSize: d.fontSizeTitle,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  static TextStyle subtitle(AppDimensions d) => TextStyle(
    fontSize: d.fontSizeSubtitle,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static TextStyle body(AppDimensions d) => TextStyle(
    fontSize: d.fontSizeBody,
    color: AppColors.textPrimary,
  );
  static TextStyle caption(AppDimensions d) => TextStyle(
    fontSize: d.fontSizeCaption,
    color: AppColors.textSecondary,
  );
  static TextStyle button(AppDimensions d) => TextStyle(
    fontSize: d.fontSizeButton,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static TextStyle price(AppDimensions d) => TextStyle(
    fontSize: d.fontSizePrice,
    fontWeight: FontWeight.bold,
    color: AppColors.green,
  );
  // Precio más compacto para mini cards (visible, pero menor que price)
  static TextStyle priceSmall(AppDimensions d) => TextStyle(
    fontSize: d.fontSizeBody * 1.20,
    fontWeight: FontWeight.w700,
    color: AppColors.green,
  );
  // Título compacto para mini cards
  static TextStyle cardTitleSmall(AppDimensions d) => TextStyle(
    fontSize: d.fontSizeBody * 0.95,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  // Texto secundario compacto para mini cards
  static TextStyle cardCaptionSmall(AppDimensions d) => TextStyle(
    fontSize: d.fontSizeCaption * 0.95,
    color: AppColors.textSecondary,
  );
  static TextStyle sectionHeader(AppDimensions d) => TextStyle(
    fontSize: d.fontSizeTitle,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  // Encabezado más compacto para listados
  static TextStyle sectionHeaderSmall(AppDimensions d) => TextStyle(
    fontSize: d.fontSizeSubtitle,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
  static TextStyle description(AppDimensions d) => TextStyle(
    fontSize: d.fontSizeDescription,
    color: AppColors.textSecondary,
    height: 1.5,
  );
}
 

/// Bordes reutilizables para la UI
class AppBorders {
  static final roundedM = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  );
  static final roundedS = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  );
}

/// Paddings reutilizables para la UI
class AppPaddings {
  static const paddingM = EdgeInsets.all(16);
  static const paddingS = EdgeInsets.all(8);
  static const paddingButton = EdgeInsets.symmetric(vertical: 14, horizontal: 24);
}

class AppSpacings {
  static const spacingXS = 4.0;
  static const spacingS = 8.0;
  static const spacingM = 16.0;
  static const spacingL = 24.0;
  static const spacingXL = 32.0;
}
