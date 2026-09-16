import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ventas_kiosko/providers/config/theme_provider.dart';
import 'package:ventas_kiosko/routes/custom_routes.dart';
import 'package:ventas_kiosko/routes/kiosk_route_observer.dart';
import 'package:ventas_kiosko/utils/product_catalog.dart';
import 'package:ventas_kiosko/services/app_log.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await dotenv.load(fileName: ".env");
  // El filtro de catálogo se consulta en código síncrono: hay que
  // tener la preferencia leída antes del primer build.
  await ProductCatalog.loadPreference();
  // El registro de operaciones sobrevive a un reinicio del kiosco: es lo
  // que Javier mira cuando algo falló y él no estaba delante.
  await AppLog.cargar();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final themeAsync = ref.watch(appThemeNotifierProvider);
    
    return themeAsync.maybeWhen(
      data: (theme) {
        print('🎨 MainApp: Tema cargado - aplicando al MaterialApp');
        return MaterialApp(
          title: 'Ventas Kiosko',
          debugShowCheckedModeBanner: false,
          theme: theme,
          initialRoute: '/',
          routes: customRoutes,
          onGenerateRoute: generateRoute,
          navigatorObservers: [kioskRouteObserver],
        );
      },
      orElse: () {
        print('⏳ MainApp: Usando MaterialApp básico (loading/error)');
        return MaterialApp(
          title: 'Ventas Kiosko',
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: customRoutes,
          onGenerateRoute: generateRoute,
          navigatorObservers: [kioskRouteObserver],
        );
      },
    );
  }
}