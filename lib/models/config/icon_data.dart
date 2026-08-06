import 'package:flutter/material.dart' as flutter;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'icon_data.freezed.dart';
part 'icon_data.g.dart';

/// Modelo personalizado para manejar íconos tanto de Material Icons como assets.
@freezed
sealed class AppIconData with _$AppIconData {
  /// Ícono de Material Icons usando codePoint.
  /// [codePoint]: El código Unicode para un ícono material (requerido para IconData en Flutter).
  /// [fontFamily]: La familia de fuente para el ícono (ej: 'MaterialIcons').
  /// [isMaterialIcon]: Booleano para distinguir entre íconos material y basados en assets.
  const factory AppIconData.material({
    required int codePoint,
    required String fontFamily,
    required bool isMaterialIcon,
    String? iconName,
    String? assetPath,
  }) = MaterialIconData;

  const factory AppIconData.asset({
    required int codePoint,
    required String fontFamily,
    required bool isMaterialIcon,
    String? iconName,
    String? assetPath,
  }) = AssetIconData;

  factory AppIconData.fromJson(Map<String, dynamic> json) => AppIconDataMapExtension.fromMap(json);
}

// JsonConverter para usar en modelos padres
class AppIconDataConverter implements JsonConverter<AppIconData, Map<String, dynamic>> {
  const AppIconDataConverter();
  @override
  AppIconData fromJson(Map<String, dynamic> json) => AppIconDataMapExtension.fromMap(json);
  @override
  Map<String, dynamic> toJson(AppIconData data) => data.toMap();
}

extension AppIconDataMapExtension on AppIconData {
  static AppIconData fromMap(Map<String, dynamic> map) {
    if (map['is_material_icon'] == true) {
      return AppIconData.material(
        codePoint: map['icon_code_point'] ?? 0,
        fontFamily: map['font_family'] ?? 'MaterialIcons',
        isMaterialIcon: true,
        iconName: map['icon_name'],
        assetPath: map['asset_path'],
      );
    } else {
      return AppIconData.asset(
        codePoint: 0, // Para assets no usamos codePoint
        fontFamily: '', // Para assets no usamos fontFamily
        isMaterialIcon: false,
        iconName: map['icon_name'],
        assetPath: map['asset_path'],
      );
    }
  }

  Map<String, dynamic> toMap() {
    return when(
      material: (codePoint, fontFamily, isMaterialIcon, iconName, assetPath) => {
        'icon_code_point': codePoint,
        'font_family': fontFamily,
        'is_material_icon': true,
        if (iconName != null) 'icon_name': iconName,
        if (assetPath != null) 'asset_path': assetPath,
      },
      asset: (codePoint, fontFamily, isMaterialIcon, iconName, assetPath) => {
        'icon_code_point': codePoint,
        'font_family': fontFamily,
        'is_material_icon': false,
        if (iconName != null) 'icon_name': iconName,
        'asset_path': assetPath,
      },
    );
  }
}


/// Extensión para convertir a Flutter IconData y manejar assets.
extension AppIconDataExtension on AppIconData {
  flutter.IconData? toFlutterIconData() {
    return map(
      material: (m) => flutter.IconData(
        m.codePoint,
        fontFamily: m.fontFamily,
      ),
      asset: (_) => flutter.Icons.category, // Fallback para assets
    );
  }

  /// Indica si es un ícono material.
  bool get isMaterial => map(
    material: (_) => true,
    asset: (_) => false,
  );

  /// Obtiene la ruta del asset si es un ícono de asset.
  String? get assetPath => mapOrNull(
    asset: (a) => a.assetPath,
  );

  /// Helper para crear íconos material comunes.
  static AppIconData materialIcon(int codePoint, {String fontFamily = 'MaterialIcons', String? iconName}) {
    return AppIconData.material(
      codePoint: codePoint,
      fontFamily: fontFamily,
      isMaterialIcon: true,
      iconName: iconName,
      assetPath: null,
    );
  }

  /// Helper para crear íconos de asset.
  static AppIconData assetIcon(String? path, {String? iconName}) {
    return AppIconData.asset(
      codePoint: 0,
      fontFamily: '',
      isMaterialIcon: false,
      iconName: iconName,
      assetPath: path,
    );
  }

  /// Helper para crear íconos desde nombre de string.
  static AppIconData fromString(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'restaurant':
        return AppIcons.restaurant;
      case 'local_drink':
        return AppIcons.localDrink;
      case 'cake':
        return AppIcons.cake;
      case 'local_offer':
        return AppIcons.localOffer;
      case 'wrap_text':
        return AppIcons.wrapText;
      case 'shopping_cart':
        return AppIcons.shoppingCart;
      default:
        return AppIcons.category;
    }
  }
}

/// Íconos predefinidos comunes para la aplicación.
class AppIcons {
  static final restaurant = AppIconData.material(
    codePoint: flutter.Icons.restaurant.codePoint,
    fontFamily: 'MaterialIcons',
    isMaterialIcon: true,
    iconName: 'restaurant',
    assetPath: null,
  );
  static final localDrink = AppIconData.material(
    codePoint: flutter.Icons.local_drink.codePoint,
    fontFamily: 'MaterialIcons',
    isMaterialIcon: true,
    iconName: 'local_drink',
    assetPath: null,
  );
  static final cake = AppIconData.material(
    codePoint: flutter.Icons.cake.codePoint,
    fontFamily: 'MaterialIcons',
    isMaterialIcon: true,
    iconName: 'cake',
    assetPath: null,
  );
  static final localOffer = AppIconData.material(
    codePoint: flutter.Icons.local_offer.codePoint,
    fontFamily: 'MaterialIcons',
    isMaterialIcon: true,
    iconName: 'local_offer',
    assetPath: null,
  );
  static final category = AppIconData.material(
    codePoint: flutter.Icons.category.codePoint,
    fontFamily: 'MaterialIcons',
    isMaterialIcon: true,
    iconName: 'category',
    assetPath: null,
  );
  static final wrapText = AppIconData.material(
    codePoint: flutter.Icons.wrap_text.codePoint,
    fontFamily: 'MaterialIcons',
    isMaterialIcon: true,
    iconName: 'wrap_text',
    assetPath: null,
  );
  static final shoppingCart = AppIconData.material(
    codePoint: flutter.Icons.shopping_cart.codePoint,
    fontFamily: 'MaterialIcons',
    isMaterialIcon: true,
    iconName: 'shopping_cart',
    assetPath: null,
  );
}
