import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/config/license_provider.dart';
import 'home_screen.dart';
import 'license_screen.dart';

class InitScreen extends ConsumerStatefulWidget {
  const InitScreen({super.key});

  @override
  ConsumerState<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends ConsumerState<InitScreen> {
  @override
  Widget build(BuildContext context) {
    print('🚀 InitScreen: Verificando estado de licencia...');
    
    // Usar directamente el licenseProvider para verificar si hay licencia válida
    final licenseState = ref.watch(licenseProvider);
    
    return licenseState.when(
      data: (license) {
        // Verificar si la licencia es válida: debe tener activationStatus=true y key no vacía
        final isValidLicense = license.activationStatus && 
                              license.key.isNotEmpty && 
                              license.tenantId > 0;
        
        if (isValidLicense) {
          print('✅ InitScreen: Licencia válida encontrada, navegando a HomeScreen');
          print('🏢 InitScreen: Tenant ID: ${license.tenantId}');
          final keyPreview = license.key.length > 8 ? '${license.key.substring(0, 8)}...' : license.key;
          print('🔑 InitScreen: License Key: $keyPreview');
          return const HomeScreen();
        } else {
          print('❌ InitScreen: Sin licencia válida, navegando a LicenseScreen');
          print('📝 InitScreen: activationStatus=${license.activationStatus}, key.isEmpty=${license.key.isEmpty}, tenantId=${license.tenantId}');
          return const LicenseScreen();
        }
      },
      loading: () {
        print('🔄 InitScreen: Cargando estado de licencia...');
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Verificando licencia...'),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        print('❌ InitScreen: Error al verificar licencia: $error');
        return const LicenseScreen(); // En caso de error, ir a pantalla de licencia
      },
    );
  }
}
