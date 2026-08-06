import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/utils/timer_provider.dart';
import 'package:ventas_kiosko/widgets/utils/linear_timer.dart';
import '../styles/app_styles.dart';
import '../providers/config/app_dimensions_provider.dart';

class PaymentSuccessScreen extends ConsumerWidget {
  static const routeName = '/payment-success';

  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final timer = ref.watch(timerProvider);
    final secondary = ref.watch(secondaryDurationProvider);

    // Iniciar el temporizador con la duración secundaria al entrar, solo si no está corriendo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (timer <= 0) {
        ref.read(timerProvider.notifier).start(secondary);
      }
    });

    handleTimer(context, ref, timer);
    
    return Scaffold(
      body:  Stack(
          children: [
            Column(
              children: [
                _buildSuccessHeader(context, ref, d, colorScheme),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(d.spacingL),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                    Icon(Icons.check_circle_outline, color: colorScheme.secondary, size: d.iconSizeL * 2),
                    SizedBox(height: d.spacingL),
                    Text('¡Gracias por tu compra!', style: AppTextStyles.sectionHeader(d), textAlign: TextAlign.center),
                    SizedBox(height: d.spacingM),
                    Text('Tu pago se ha procesado correctamente.', style: AppTextStyles.body(d), textAlign: TextAlign.center),
                    SizedBox(height: d.spacingXL),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.primary,
                          padding: EdgeInsets.symmetric(vertical: d.spacingM),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(d.borderRadiusL),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).popUntil((route) => route.isFirst);
                        },
                        child: Text(
                          'Volver al inicio', 
                          style: AppTextStyles.button(d).copyWith(
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (timer > 0) LinearTimer(timer: timer),
          ],
        ),
    );
  }

  Widget _buildSuccessHeader(BuildContext context, WidgetRef ref, dynamic d, ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.only(
        top: d.screenHeight * 0.06 + d.spacingM,
        left: d.horizontalPadding,
        right: d.horizontalPadding,
        bottom: d.spacingM,
      ),
      child: Row(
        children: [
          SizedBox(width: d.iconSizeL + d.spacingS), // Espacio equivalente al botón de regreso
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '¡Pago Exitoso!',
                  style: AppTextStyles.title(d).copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                Text(
                  'Tu compra se ha completado',
                  style: AppTextStyles.caption(d).copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: d.iconSizeL + d.spacingS), // Espacio para mantener centrado
        ],
      ),
    );
  }
 Future<void> handleTimer(BuildContext context, WidgetRef ref, int timer) async {
    if (timer == 0) {
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(timerProvider.notifier).start(ref.read(secondaryDurationProvider));
          Navigator.popUntil(context, (route) => route.isFirst);
        });
      }
    }
  }

}
