import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/utils/loading_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

class ConfigNiubizIm30Screen extends ConsumerStatefulWidget {
  static const routeName = '/config-niubiz-im30';

  const ConfigNiubizIm30Screen({super.key});

  @override
  ConsumerState<ConfigNiubizIm30Screen> createState() => _ConfigNiubizIm30ScreenState();
}

class _ConfigNiubizIm30ScreenState extends ConsumerState<ConfigNiubizIm30Screen> {
  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final isLoading = ref.watch(loadingProvider);

    return Stack(
      children: [
        Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        title: Text(
          'Configurar Niubiz/IM30',
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
                'La configuración para Niubiz/IM30 estará disponible próximamente.',
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
      )),
        if (isLoading)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: colorScheme.scrim.withValues(alpha: 0.5),
            child: Center(
              child: CircularProgressIndicator(color: colorScheme.primary, strokeWidth: d.borderWidth * 3),
            ),
          ),
      ],
    );
  }
}
