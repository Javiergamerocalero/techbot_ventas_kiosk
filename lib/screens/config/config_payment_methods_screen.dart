import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:ventas_kiosko/providers/config/payment_methods_provider.dart';
import 'package:ventas_kiosko/models/config/payment_method.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/screens/config/config_niubiz_lane3000_screen.dart';
import 'package:ventas_kiosko/screens/config/config_niubiz_im30_screen.dart';
import 'package:ventas_kiosko/screens/config/config_izipay_screen.dart';
import 'package:ventas_kiosko/screens/config/config_cashdro_screen.dart';

class ConfigPaymentMethodsScreen extends ConsumerWidget {
  const ConfigPaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final paymentMethodsAsync = ref.watch(paymentMethodsNotifierProvider);

    return paymentMethodsAsync.when(
      data: (config) => _buildContent(context, ref, d, colorScheme, config),
      loading: () => Center(
        child: CircularProgressIndicator(color: colorScheme.primary, strokeWidth: d.borderWidth * 3),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: d.iconSizeL * 2, color: colorScheme.error),
            SizedBox(height: d.spacingM),
            Text(
              'Error al cargar métodos de pago',
              style: AppTextStyles.subtitle(d).copyWith(color: colorScheme.error),
            ),
            SizedBox(height: d.spacingS),
            Text(
              error.toString(),
              style: AppTextStyles.caption(d).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.6)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    AppDimensions d,
    ColorScheme colorScheme,
    PaymentMethodsConfig config,
  ) {
    return Padding(
      padding: d.paddingM,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Métodos de Pago Disponibles:', d, colorScheme),
          SizedBox(height: d.spacingS),
          Text(
            'Activa los métodos de pago que deseas utilizar',
            style: AppTextStyles.caption(d).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7)),
          ),
          SizedBox(height: d.spacingL),
          Expanded(
            child: ListView.separated(
              itemCount: config.methods.length,
              separatorBuilder: (context, index) => SizedBox(height: d.spacingM),
              itemBuilder: (context, index) {
                final method = config.methods[index];
                return _buildPaymentMethodCard(context, ref, d, colorScheme, method);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, AppDimensions d, ColorScheme colorScheme) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: AppTextStyles.subtitle(d).copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
    );
  }

  void _navigateToConfigScreen(BuildContext context, PaymentMethodType type) {
    Widget screen;

    switch (type) {
      case PaymentMethodType.niubizLane3000:
        screen = const ConfigNiubizLane3000Screen();
        break;
      case PaymentMethodType.niubizIm30:
        screen = const ConfigNiubizIm30Screen();
        break;
      case PaymentMethodType.izipay:
        screen = const ConfigIzipayScreen();
        break;
      case PaymentMethodType.cashdroS:
        screen = const ConfigCashdroScreen();
        break;
    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  }

  Widget _buildPaymentMethodCard(
    BuildContext context,
    WidgetRef ref,
    AppDimensions d,
    ColorScheme colorScheme,
    PaymentMethod method,
  ) {
    return Card(
      color: colorScheme.surface,
      elevation: d.blurRadius * 0.3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(d.borderRadiusM),
        side: BorderSide(
          color: method.isActive
              ? colorScheme.primary.withValues(alpha: 0.3)
              : colorScheme.outline.withValues(alpha: 0.2),
          width: d.borderWidth,
        ),
      ),
      child: Padding(
        padding: d.paddingS,
        child: Row(
          children: [
            // Switch para activar/desactivar
            Switch(
              value: method.isActive,
              onChanged: (value) {
                ref.read(paymentMethodsNotifierProvider.notifier).togglePaymentMethod(method.type, value);
              },
              activeColor: colorScheme.primary,
            ),
            SizedBox(width: d.spacingM),

            // Nombre del método de pago
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.type.displayName,
                    style: AppTextStyles.body(d).copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.w600),
                  ),
                  if (!method.isActive)
                    Text(
                      'Desactivado',
                      style: AppTextStyles.caption(d).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.5)),
                    ),
                  if (method.isActive)
                    Text(
                      'Activo',
                      style: AppTextStyles.caption(d).copyWith(color: colorScheme.primary, fontWeight: FontWeight.w500),
                    ),
                ],
              ),
            ),

            // Botón de configuración (solo visible si está activo)
            if (method.isActive)
              IconButton(
                onPressed: () {
                  _navigateToConfigScreen(context, method.type);
                },
                icon: Icon(Icons.settings, color: colorScheme.primary, size: d.iconSizeM),
                tooltip: 'Configurar ${method.type.displayName}',
              ),
          ],
        ),
      ),
    );
  }
}
