import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/utils/timer_provider.dart';
import 'package:ventas_kiosko/screens/time_up_screen.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/utils/linear_timer.dart';

class TestScreen extends ConsumerWidget {
  static const routeName = '/test';
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final d = ref.watch(appDimensionsProvider(context));
    final timer = ref.watch(timerProvider);

    handleTimer(context, ref, timer);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: d.imageSizeL,
                  height: d.imageSizeL,
                  decoration: BoxDecoration(
                    color: AppColors.greyLight,
                    borderRadius: BorderRadius.circular(d.borderRadiusL),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.grey.withValues(alpha: 0.15 * 255),
                        blurRadius: d.blurRadius,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.storefront,
                    color: AppColors.primary,
                    size: d.iconSizeL * 1.3,
                  ),
                ),
                SizedBox(height: d.spacingL),
                Text(
                  'Kiosko Digital',
                  style: AppTextStyles.title(d),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: d.spacingM),
                Text(
                  '¡Transforma tu punto de venta en una experiencia digital moderna! Descubre las ventajas de un kiosko digital:',
                  style: AppTextStyles.subtitle(d).copyWith(color: AppColors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: d.spacingL),
                Card(
                  color: AppColors.greyLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(d.borderRadiusM),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(d.spacingM),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.touch_app, color: AppColors.primary),
                            SizedBox(width: d.spacingS),
                            Expanded(child: Text('Pedidos rápidos y sencillos', style: AppTextStyles.body(d))),
                          ],
                        ),
                        SizedBox(height: d.spacingS),
                        Row(
                          children: [
                            Icon(Icons.payment, color: AppColors.primary),
                            SizedBox(width: d.spacingS),
                            Expanded(child: Text('Pagos digitales y seguros', style: AppTextStyles.body(d))),
                          ],
                        ),
                        SizedBox(height: d.spacingS),
                        Row(
                          children: [
                            Icon(Icons.analytics, color: AppColors.primary),
                            SizedBox(width: d.spacingS),
                            Expanded(child: Text('Reportes en tiempo real', style: AppTextStyles.body(d))),
                          ],
                        ),
                        SizedBox(height: d.spacingS),
                        Row(
                          children: [
                            Icon(Icons.settings, color: AppColors.primary),
                            SizedBox(width: d.spacingS),
                            Expanded(child: Text('Totalmente personalizable', style: AppTextStyles.body(d))),
                          ],
                        ),
                        SizedBox(height: d.spacingM),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_forward),
                            label: Text('¡Comienza ahora!'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(d.borderRadiusS),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          LinearTimer(timer: timer),
        ],
      ),
    );
  }

  Future<void> handleTimer(BuildContext context, WidgetRef ref, int timer) async {
    if (timer == 0) {
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(timerProvider.notifier).start(ref.read(secondaryDurationProvider));
          Navigator.pushNamed(context, TimeUpScreen.routeName);
        });
      }
    }
  }
}
