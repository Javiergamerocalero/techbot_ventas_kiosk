import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

class ConfigIzipayScreen extends ConsumerWidget {
  static const routeName = '/config-izipay';

  const ConfigIzipayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        title: Text(
          'Configurar Izipay',
          style: AppTextStyles.title(d).copyWith(color: colorScheme.onSurface),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: d.iconSizeM),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: d.paddingL,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícono grande
              Container(
                padding: EdgeInsets.all(d.spacingXL),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.construction,
                  size: d.iconSizeL * 3,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(height: d.spacingXL),

              // Título
              Text(
                'Configuración en Desarrollo',
                style: AppTextStyles.title(d).copyWith(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: d.spacingM),

              // Mensaje
              Text(
                'La configuración para Izipay estará disponible próximamente.',
                style: AppTextStyles.body(d).copyWith(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: d.spacingS),

              // Información adicional
              Container(
                padding: d.paddingM,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(d.borderRadiusM),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.3),
                    width: d.borderWidth,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: d.iconSizeL,
                      color: colorScheme.primary,
                    ),
                    SizedBox(height: d.spacingS),
                    Text(
                      'Estamos trabajando en implementar las funcionalidades de configuración para este método de pago.',
                      style: AppTextStyles.caption(d).copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
