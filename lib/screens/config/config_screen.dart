import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/utils/loading_provider.dart';
import 'package:ventas_kiosko/screens/config/config_globals_screen.dart';
import 'package:ventas_kiosko/screens/config/config_logs_screen.dart';
import 'package:ventas_kiosko/screens/config/config_payment_methods_screen.dart';
import 'package:ventas_kiosko/screens/config/config_printer_screen.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

class ConfigScreen extends ConsumerStatefulWidget {
  static const routeName = '/config';

  const ConfigScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends ConsumerState<ConfigScreen> {
  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isLoading = ref.watch(loadingProvider);

    return Stack(
      children: [
        DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: colorScheme.surface,
              foregroundColor: colorScheme.onSurface,
              title: Text('Configuración', style: AppTextStyles.title(d).copyWith(color: colorScheme.onSurface)),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(d.appBarHeight * 0.7),
                child: SizedBox(
                  height: d.appBarHeight * 0.7,
                  child: TabBar(
                    indicatorColor: colorScheme.primary,
                    labelColor: colorScheme.primary,
                    unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.6),
                    tabs: [
                      Tab(
                        icon: Icon(Icons.print, size: d.iconSizeM),
                        height: d.appBarHeight * 0.7,
                      ),
                      Tab(
                        icon: Icon(Icons.payments, size: d.iconSizeM),
                        height: d.appBarHeight * 0.7,
                      ),
                      Tab(
                        icon: Icon(Icons.receipt_long, size: d.iconSizeM),
                        height: d.appBarHeight * 0.7,
                      ),
                      Tab(
                        icon: Icon(Icons.settings, size: d.iconSizeM),
                        height: d.appBarHeight * 0.7,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children: [
                ConfigPrinterScreen(),
                ConfigPaymentMethodsScreen(),
                const ConfigLogsScreen(),
                ConfigGlobalsScreen(),
              ],
            ),
          ),
        ),
        if (isLoading)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: colorScheme.scrim.withValues(alpha: 0.5),
            child: Center(
              child: CircularProgressIndicator(color: colorScheme.primary, strokeWidth: d.borderWidth * 3),
            ),
          ),
      ],
    );
  }

}
