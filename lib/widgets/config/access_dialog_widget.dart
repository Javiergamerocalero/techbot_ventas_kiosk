import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ventas_kiosko/screens/config/config_screen.dart';
import 'package:ventas_kiosko/providers/config/license_provider.dart';
// import 'package:ventas_kiosko/widgets/utils/keyboard.dart';

Future<void> accessDialogWidget(BuildContext context) async {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController textFieldController = TextEditingController();

  return showDialog<void>(
    context: context,
    barrierDismissible: true, // User can tap outside to dismiss
    builder: (BuildContext dialogContext) {
      return Consumer(
        builder: (context, ref, child) {
          final licenseNotifier = ref.read(licenseProvider.notifier);
          
          return AlertDialog(
        title: const Text('Ingresar Contraseña'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    controller: textFieldController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Contraseña', border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese una contraseña';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            /////////////// Keyboard ///////////////
            // Keyboard(controller: textFieldController, type: KeyboardType.alphanumeric, maxLength: 20),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Dismiss the dialog
            },
          ),
          ElevatedButton(
            child: const Text('Continuar'),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                print('🔐 Validando contraseña: ${textFieldController.text}');
                
                // Usar el config_password del endpoint o fallback a '1234'
                bool isValidPassword = false;
                String passwordSource = '';
                
                if (licenseNotifier.hasConfigPassword) {
                  // Usar password del endpoint
                  isValidPassword = licenseNotifier.validateConfigPassword(textFieldController.text);
                  passwordSource = 'endpoint';
                  print('🔧 Usando config_password del endpoint');
                } else {
                  // Fallback al password local
                  isValidPassword = textFieldController.text == '1234';
                  passwordSource = 'local fallback';
                  print('⚠️ Usando password local (fallback): endpoint no disponible');
                }
                
                if (isValidPassword) {
                  print('✅ Contraseña válida (fuente: $passwordSource)');
                  if (!context.mounted) return;
                  Navigator.of(dialogContext).pop();
                  Navigator.of(context).pushNamed(ConfigScreen.routeName);
                } else {
                  print('❌ Contraseña incorrecta (fuente: $passwordSource)');
                  // Show error message
                  ScaffoldMessenger.of(dialogContext).hideCurrentSnackBar();
                  ScaffoldMessenger.of(dialogContext).showSnackBar(
                    SnackBar(
                      content: Text(
                        licenseNotifier.hasConfigPassword 
                          ? 'Contraseña incorrecta!'
                          : 'Contraseña incorrecta! (usando fallback local)',
                      ),
                    ),
                  );
                }
              }
            },
          ),
        ],
          );
        },
      );
    },
  );
}
