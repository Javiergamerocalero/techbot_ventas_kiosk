import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/helpers/employee_purchase_hook.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/providers/utils/timer_provider.dart';
import 'package:ventas_kiosko/widgets/utils/linear_timer.dart';
import '../styles/app_styles.dart';
import '../providers/config/app_dimensions_provider.dart';

class PaymentSuccessScreen extends ConsumerStatefulWidget {
  static const routeName = '/payment-success';

  const PaymentSuccessScreen({super.key});

  @override
  ConsumerState<PaymentSuccessScreen> createState() =>
      _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends ConsumerState<PaymentSuccessScreen> {
  /// El temporizador arranca UNA vez al entrar. Antes se reiniciaba en
  /// cada build mientras estuviera en cero, así que al vencer volvía a
  /// empezar y la pantalla se quedaba dando vueltas sin volver nunca al
  /// video (Javier, 2026-09-17).
  bool _arrancado = false;

  /// Evita que se dispare el regreso más de una vez.
  bool _volviendo = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref
          .read(timerProvider.notifier)
          .start(ref.read(secondaryDurationProvider));

      // San Fernando: si hay sesión de empleado activa y el hook no
      // fue disparado desde IzipayPaymentScreen (que ya la habría
      // limpiado), registrar la compra ahora con el total del carrito.
      // Idempotente por sesión (registrar limpia el session).
      final totalPrice = ref.read(cartTotalPriceProvider);
      if (totalPrice > 0) {
        EmployeePurchaseHook.registerIfEmployeeSession(ref, amount: totalPrice);
      }
      setState(() => _arrancado = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final timer = ref.watch(timerProvider);

    // Al vencer, de vuelta al video. Se espera a que el temporizador haya
    // arrancado: al montar todavía puede venir en cero de la pantalla
    // anterior, y sin esa guarda la pantalla se cerraría al instante.
    if (_arrancado && timer == 0 && !_volviendo) {
      _volviendo = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _goHome(context, ref);
      });
    }
    
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
                          _goHome(context, ref);
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
  void _goHome(BuildContext context, WidgetRef ref) {
    ref.read(cartNotifierProvider.notifier).clearCart();
    ref.read(timerProvider.notifier).reset();
    ref.read(inactivityTimerProvider.notifier).stopInactivity();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

}
