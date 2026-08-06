import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ventas_kiosko/providers/utils/timer_provider.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/utils/helpers.dart';
import 'package:ventas_kiosko/widgets/utils/linear_timer.dart';

class TimeUpScreen extends ConsumerStatefulWidget {
  static const routeName = '/time-up';

  const TimeUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TimeUpScreenState();
}

class _TimeUpScreenState extends ConsumerState<TimeUpScreen> {
  
  /// Limpia el carrito y repone el stock antes de regresar al home
  Future<void> _clearCartAndGoHome(BuildContext context, WidgetRef ref) async {
    try {
      // Llamar al endpoint para limpiar carrito y reponer stock
      final response = await ref.read(cartNotifierProvider.notifier).clearCartWithBackend();
      
      if (!response.isAvailable) {
        // Fallback: limpiar solo localmente si falla el backend
        ref.read(cartNotifierProvider.notifier).clearCart();
      }
    } catch (e) {
      // Fallback: limpiar solo localmente si falla el backend
      ref.read(cartNotifierProvider.notifier).clearCart();
    }
    
    // Regresar al home después de limpiar
    if (context.mounted) {
      Navigator.popUntil(context, (route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    final timer = ref.watch(timerProvider);
    final mainTime = ref.watch(mainDurationProvider);
    
    handleTimer(context, ref, timer);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ////////// Background Image //////////
          Image.asset(
            'assets/images/standby_img.jpg',
            height: double.infinity,
            width: double.infinity,
            opacity: const AlwaysStoppedAnimation(0.4),
            fit: BoxFit.fitHeight,
          ),
          ////////// Body //////////
          Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.012, horizontal: screenWidth * 0.048),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ////////// Text //////////
                      Text(
                        '¿Deseas más tiempo para completar tu operación?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: screenHeight * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.08),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ////////// Button 1 //////////
                          elevatedButton(
                            backgroundColor: cyan,
                            minimumSize: Size(screenWidth * 0.4, screenHeight * 0.05),
                            paddingVertical: 0,
                            borderColor: cyan,
                            borderWidth: 1,
                            child: Text(
                              'Si',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.026,
                                // fontSize: 32,
                              ),
                            ),
                            onPressed: () {
                              ref.read(timerProvider.notifier).start(mainTime);
                              Navigator.pop(context);
                            },
                          ),
                          ////////// Button 2 //////////
                          elevatedButton(
                            backgroundColor: const Color(0xFFf6c83f),
                            minimumSize: Size(screenWidth * 0.4, screenHeight * 0.05),
                            paddingVertical: 0,
                            borderColor: const Color(0xFFf6c83f),
                            borderWidth: 1,
                            child: Text(
                              'No',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenHeight * 0.026,
                                // fontSize: 32,
                              ),
                            ),
                            onPressed: () async {
                              await _clearCartAndGoHome(context, ref);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ////////// Timer //////////
          LinearTimer(timer: timer),
        ],
      ),
    );
  }

  Future<void> handleTimer(BuildContext context, WidgetRef ref, int timer) async {
    if (timer == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _clearCartAndGoHome(context, ref);
      });
    }
  }
}
