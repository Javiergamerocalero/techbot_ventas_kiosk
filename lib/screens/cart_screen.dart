import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/providers/utils/timer_provider.dart';
import 'package:ventas_kiosko/screens/time_up_screen.dart';
import 'package:ventas_kiosko/widgets/utils/linear_timer.dart';
import 'package:ventas_kiosko/widgets/utils/inactivity_detector.dart';
import 'package:ventas_kiosko/widgets/cart/cart_header.dart';
import 'package:ventas_kiosko/widgets/barcode/pre_payment_barcode_scope.dart';
import 'package:ventas_kiosko/widgets/cart/cart_empty_state.dart';
import 'package:ventas_kiosko/widgets/cart/cart_items_list.dart';
import 'package:ventas_kiosko/widgets/cart/cart_summary.dart';
import 'package:ventas_kiosko/providers/utils/button_loading_provider.dart';

/// Pantalla del carrito de compras refactorizada
class CartScreen extends ConsumerWidget {
  static const routeName = '/cart';
  
  const CartScreen({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final timer = ref.watch(timerProvider);
    final cart = ref.watch(cartNotifierProvider);
    final totalItems = ref.watch(cartTotalItemsProvider);
    final loadingMap = ref.watch(buttonLoadingProvider);
    final isCartLoading = loadingMap.entries.any((e) => e.key.startsWith('cart_') && (e.value == true));

    handleTimer(context, ref, timer);
  
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: PrePaymentBarcodeScope(
        child: InactivityDetector(
        child: Stack(
          children: [
            Column(
              children: [
                const CartHeader(),
                if (cart.items.isEmpty && cart.comboItems.isEmpty)
                  const CartEmptyState()
                else
                  Expanded(
                    child: Column(
                      children: [
                        CartItemsList(cart: cart),
                        CartSummary(
                          cart: cart,
                          totalItems: totalItems,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            LinearTimer(timer: timer),
            if (isCartLoading)
              Positioned.fill(
                child: AbsorbPointer(
                  absorbing: true,
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.25),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
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
