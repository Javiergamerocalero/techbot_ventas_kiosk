import 'dart:async' as async;
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ventas_kiosko/providers/utils/timer_provider.dart';
import 'package:ventas_kiosko/providers/cart/cart_provider.dart';
import 'package:ventas_kiosko/screens/products_screen.dart';
import 'package:ventas_kiosko/widgets/config/access_dialog_widget.dart';
import 'package:ventas_kiosko/providers/utils/products_sync_provider.dart';
import 'package:ventas_kiosko/routes/kiosk_route_observer.dart';
import 'package:ventas_kiosko/utils/debug_session_log.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin, RouteAware {
  late PageController _pageController;
  async.Timer? _timer;
  int _currentPage = 0;
  bool _isSyncingProducts = false;
  
  final List<String> _carouselImages = [
    'assets/images/1.png',
    'assets/images/3.png', 
    'assets/images/2.png',
  ];

  @override
  void initState() {
    super.initState();
    // La limpieza del carrito ahora se maneja directamente en TimeUpScreen
    // Solo verificar si hay items residuales por si acaso
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndClearCart();
    });
    print('🏠 HomeScreen: Proceso de limpieza iniciado');
    
    // Inicializar carousel
    _pageController = PageController();
    _startAutoSlide();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      kioskRouteObserver.subscribe(this, route);
    }
  }

  @override
  void didPopNext() {
    _checkAndClearCart();
    ref.read(timerProvider.notifier).reset();
    ref.read(inactivityTimerProvider.notifier).stopInactivity();
  }

  void _startAutoSlide() {
    _timer = async.Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < _carouselImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _checkAndClearCart() async {
    try {
      final currentItems = ref.read(cartTotalItemsProvider);
      if (currentItems > 0) {
        print('⚠️ HomeScreen: Detectados $currentItems items residuales en carrito');
        // #region agent log
        agentDebugLog(
          location: 'home_screen.dart:_checkAndClearCart',
          message: 'Home found leftover cart items',
          hypothesisId: 'C',
          data: {'leftoverItems': currentItems},
        );
        // #endregion
        ref.read(cartNotifierProvider.notifier).clearCart();
      } else {
        print('✅ HomeScreen: Carrito ya está limpio');
      }
    } catch (e) {
      print('🏠 HomeScreen: Error verificando carrito: $e');
    }
  }

  @override
  void dispose() {
    kioskRouteObserver.unsubscribe(this);
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;

    final mainTime = ref.watch(mainDurationProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: Stack(
        children: [
          RawGestureDetector(
        gestures: <Type, GestureRecognizerFactory>{
          TapGestureRecognizer: GestureRecognizerFactoryWithHandlers<TapGestureRecognizer>(
            () => TapGestureRecognizer(),
            (TapGestureRecognizer instance) {
              instance.onTap = () async {
                ref.read(cartNotifierProvider.notifier).clearCart();
                // Verificar si es necesario refrescar productos/combos (<= 1h)
                if (mounted) setState(() => _isSyncingProducts = true);
                try {
                  await ref.read(productsSyncProvider.notifier).ensureFreshData();
                } catch (_) {
                  // No bloquear por error de sync
                } finally {
                  if (mounted) setState(() => _isSyncingProducts = false);
                }

                ref.read(timerProvider.notifier).start(mainTime);
                if (mounted) {
                  // ignore: use_build_context_synchronously
                  Navigator.of(context).pushNamed(ProductsScreen.routeName);
                }
              };
            },
          ),
          LongPressGestureRecognizer: GestureRecognizerFactoryWithHandlers<LongPressGestureRecognizer>(
            () => LongPressGestureRecognizer(
              // Set custom duration here, e.g., 2 seconds
              duration: const Duration(seconds: 3),
              debugOwner: this, // typically 'this' from a State object
            ),
            (LongPressGestureRecognizer instance) {
              instance.onLongPress = () {
                accessDialogWidget(context);
              };
            },
          ),
        },
        child: Stack(
          children: [
            // Carousel de imágenes de fondo
            SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _carouselImages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.asset(
                    _carouselImages[index],
                    fit: BoxFit.cover,
                    width: screenWidth,
                    height: screenHeight,
                  );
                },
              ),
            ),
           
          ],
        ),
      ),
          if (_isSyncingProducts)
            Positioned.fill(
              child: Container(
                color: colorScheme.scrim.withValues(alpha: 0.5),
                child: const Center(
                  child: SizedBox(
                    width: 64,
                    height: 64,
                    child: CircularProgressIndicator(strokeWidth: 6),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
