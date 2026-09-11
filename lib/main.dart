import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ventas_kiosko/providers/config/theme_provider.dart';
import 'package:ventas_kiosko/routes/custom_routes.dart';
import 'package:ventas_kiosko/routes/kiosk_route_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await dotenv.load(fileName: ".env");
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