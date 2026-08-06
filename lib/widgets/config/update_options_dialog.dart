import 'package:flutter/material.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:ventas_kiosko/widgets/utils/custom_button.dart';

Future<void> showUpdateOptionsDialog({
  required BuildContext context,
  required AppDimensions dimensions,
  required VoidCallback onUpdateApp,
  required Future<void> Function() onUpdateTheme,
  required Future<void> Function() onUpdateProducts,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) {
      final colorScheme = Theme.of(dialogContext).colorScheme;
      return AlertDialog(
        title: const Text('Actualización'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              text: 'Actualizar tema',
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await onUpdateTheme();
              },
              dimensions: dimensions,
              variant: ButtonVariant.primary,
              isFullWidth: true,
              icon: Icon(Icons.palette, color: colorScheme.onPrimary),
            ),
            SizedBox(height: dimensions.spacingS),
            CustomButton(
              text: 'Actualizar productos',
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                await onUpdateProducts();
              },
              dimensions: dimensions,
              variant: ButtonVariant.primary,
              isFullWidth: true,
              icon: Icon(Icons.inventory_2, color: colorScheme.onPrimary),
            ),
            SizedBox(height: dimensions.spacingS),
            CustomButton(
              text: 'Actualizar aplicación',
              onPressed: () {
                Navigator.of(dialogContext).pop();
                onUpdateApp();
              },
              dimensions: dimensions,
              variant: ButtonVariant.secondary,
              isFullWidth: true,
              icon: Icon(Icons.system_update_alt, color: colorScheme.onSecondary),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
          ),
        ],
      );
    },
  );
}
