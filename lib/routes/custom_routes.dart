import 'package:flutter/material.dart';

import 'package:ventas_kiosko/screens/home_screen.dart';
import 'package:ventas_kiosko/screens/license_screen.dart';
import 'package:ventas_kiosko/screens/config/config_screen.dart';
import 'package:ventas_kiosko/screens/loading_screen.dart';
import 'package:ventas_kiosko/screens/time_up_screen.dart';
import 'package:ventas_kiosko/screens/test_screen.dart';
import 'package:ventas_kiosko/screens/products_screen.dart';
import 'package:ventas_kiosko/screens/cart_screen.dart';
import 'package:ventas_kiosko/screens/product_detail_screen.dart';
import 'package:ventas_kiosko/screens/combo_detail_screen.dart';
import 'package:ventas_kiosko/screens/init_screen.dart';
import 'package:ventas_kiosko/screens/payment_confirmation_screen.dart';
import 'package:ventas_kiosko/screens/invoice_selection_screen.dart';
import 'package:ventas_kiosko/screens/payment_success_screen.dart';
import 'package:ventas_kiosko/screens/payment_standby_screen.dart';
import 'package:ventas_kiosko/screens/config/config_niubiz_lane3000_screen.dart';
import 'package:ventas_kiosko/screens/config/config_niubiz_im30_screen.dart';
import 'package:ventas_kiosko/screens/config/config_izipay_screen.dart';
import 'package:ventas_kiosko/screens/config/izipay_result_screen.dart';
import 'package:ventas_kiosko/services/izipay_service.dart';
import 'package:ventas_kiosko/screens/config/config_cashdro_screen.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/models/combos/combo.dart';
import 'package:ventas_kiosko/screens/cashdro_payment_screen.dart';
import 'package:ventas_kiosko/screens/payment_izipay_screen.dart';
import 'package:ventas_kiosko/screens/employee_auth_screen.dart';


var customRoutes = <String, WidgetBuilder>{
  HomeScreen.routeName: (_) => const HomeScreen(),
  LicenseScreen.routeName: (_) => const LicenseScreen(),
  ConfigScreen.routeName: (_) => const ConfigScreen(),
  TimeUpScreen.routeName: (_) => const TimeUpScreen(),
  TestScreen.routeName: (_) => const TestScreen(),
  ProductsScreen.routeName: (_) => const ProductsScreen(),
  CartScreen.routeName: (_) => const CartScreen(),
  PaymentConfirmationScreen.routeName: (_) => const PaymentConfirmationScreen(),
  InvoiceSelectionScreen.routeName: (_) => const InvoiceSelectionScreen(),
  PaymentStandbyScreen.routeName: (_) => const PaymentStandbyScreen(),
  PaymentSuccessScreen.routeName: (_) => const PaymentSuccessScreen(),
  ConfigNiubizLane3000Screen.routeName: (_) => const ConfigNiubizLane3000Screen(),
  ConfigNiubizIm30Screen.routeName: (_) => const ConfigNiubizIm30Screen(),
  ConfigIzipayScreen.routeName: (_) => const ConfigIzipayScreen(),
  ConfigCashdroScreen.routeName: (_) => const ConfigCashdroScreen(),
  EmployeeAuthScreen.routeName: (_) => const EmployeeAuthScreen(),
};

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => const InitScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case LoadingScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoadingScreen());
    case ProductsScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ProductsScreen());
    case CartScreen.routeName:
      return MaterialPageRoute(builder: (_) => const CartScreen());
    case ProductDetailScreen.routeName:
      final product = settings.arguments as Product;
      return MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product));
    case ComboDetailScreen.routeName:
      final combo = settings.arguments as Combo;
      return MaterialPageRoute(builder: (_) => ComboDetailScreen(combo: combo));
    case PaymentConfirmationScreen.routeName:
      return MaterialPageRoute(builder: (_) => const PaymentConfirmationScreen());
    case InvoiceSelectionScreen.routeName:
      return MaterialPageRoute(builder: (_) => const InvoiceSelectionScreen());
    case PaymentStandbyScreen.routeName:
      return MaterialPageRoute(builder: (_) => const PaymentStandbyScreen());
    case PaymentSuccessScreen.routeName:
      return MaterialPageRoute(builder: (_) => const PaymentSuccessScreen());
    case ConfigNiubizLane3000Screen.routeName:
      return MaterialPageRoute(builder: (_) => const ConfigNiubizLane3000Screen());
    case ConfigNiubizIm30Screen.routeName:
      return MaterialPageRoute(builder: (_) => const ConfigNiubizIm30Screen());
    case ConfigIzipayScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ConfigIzipayScreen());
    case IzipayResultScreen.routeName:
      final args = settings.arguments as Map<String, dynamic>?;
      final result = args?['result'];
      if (result is! IzipayPurchaseResult) {
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Sin resultado de Izipay')),
          ),
        );
      }
      return MaterialPageRoute(
        builder: (_) => IzipayResultScreen(
          title: args?['title'] as String? ?? 'Resultado Izipay',
          result: result,
        ),
      );
    case ConfigCashdroScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ConfigCashdroScreen());
    case CashDroPaymentScreen.routeName:
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute(
        builder: (_) => CashDroPaymentScreen(
          amount: args?['amount'] as double? ?? 0.0,
          ticketId: args?['ticketId'] as String?,
          invoiceData: args?['invoiceData'] as Map<String, dynamic>?,
          paymentMethod: args?['paymentMethod'] as Map<String, dynamic>?,
        ),
      );
    case IzipayPaymentScreen.routeName:
      final args = settings.arguments as Map<String, dynamic>?;
      return MaterialPageRoute(
        builder: (_) => IzipayPaymentScreen(
          amount: args?['amount'] as double? ?? 0.0,
          invoiceData: args?['invoiceData'] as Map<String, dynamic>?,
          mode: args?['izipayMode'] == 'qr'
              ? IzipayMode.qr
              : IzipayMode.tarjeta,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(body: Center(child: Text('No route defined for ${settings.name}'))),
      );
  }
}
