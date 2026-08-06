import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/screens/home_screen.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  static const routeName = '/loading';
  
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    print('🔄 LoadingScreen: Iniciando carga de configuraciones...');
    
    // Esperar un poco para que se complete la validación de licencia
    await Future.delayed(const Duration(milliseconds: 1500));
    
    if (mounted) {
      print('🏠 LoadingScreen: Navegando a HomeScreen');
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo o icono principal
            Container(
              width: d.imageSizeL,
              height: d.imageSizeL,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.primary.withValues(alpha: 0.3),
                  width: d.borderWidth,
                ),
              ),
              child: Icon(
                Icons.store,
                size: d.iconSizeL,
                color: colorScheme.primary,
              ),
            ),
            
            SizedBox(height: d.spacingL),
            
            // Título
            Text(
              'Ventas Kiosko',
              style: TextStyle(
                fontSize: d.fontSizeTitle,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            
            SizedBox(height: d.spacingM),
            
            // Subtítulo
            Text(
              'Cargando configuraciones...',
              style: TextStyle(
                fontSize: d.fontSizeBody,
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            
            SizedBox(height: d.spacingL),
            
            // Spinner de carga
            SizedBox(
              width: d.iconSizeL,
              height: d.iconSizeL,
              child: CircularProgressIndicator(
                strokeWidth: d.borderWidth * 3,
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
