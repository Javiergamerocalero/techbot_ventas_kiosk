import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../models/payment/cashdro_transaction.dart';
import '../../providers/payment/cashdro_payment_provider.dart';
import '../../providers/config/app_dimensions_provider.dart';
import '../../providers/config/license_provider.dart';
import '../../styles/app_styles.dart';
import '../../widgets/common/screen_header.dart';
import '../../models/config/app_dimensions.dart';
import '../../models/config/payment_method.dart';
import '../../services/cashdro_config_service.dart';
import './payment_success_screen.dart';
import './payment_confirmation_screen.dart';

class CashDroPaymentScreen extends ConsumerStatefulWidget {
  static const routeName = '/cashdro-payment';

  final double amount;
  final String? ticketId;
  final Map<String, dynamic>? invoiceData;
  final Map<String, dynamic>? paymentMethod;

  const CashDroPaymentScreen({
    super.key,
    required this.amount,
    this.ticketId,
    this.invoiceData,
    this.paymentMethod,
  });

  @override
  ConsumerState<CashDroPaymentScreen> createState() => _CashDroPaymentScreenState();
}

class _CashDroPaymentScreenState extends ConsumerState<CashDroPaymentScreen> {
  WebViewController? _webViewController;
  bool _webViewInitialized = false;
  Timer? _navigationTimer;
  bool _hasNavigated = false;

  /// Getter para obtener el PaymentMethod desde el JSON
  PaymentMethod? get paymentMethod {
    if (widget.paymentMethod == null) return null;
    try {
      return PaymentMethod.fromJson(widget.paymentMethod!);
    } catch (e) {
      print('❌ Error al parsear PaymentMethod: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    
    try {
      // Logging de argumentos recibidos
      print('🏪 CashDroPaymentScreen iniciado');
      print('💰 Monto: \$${widget.amount.toStringAsFixed(2)}');
      print('🎫 TicketId: ${widget.ticketId}');
      print('📄 Datos de facturación: ${widget.invoiceData}');
      print('💳 Método de pago JSON: ${widget.paymentMethod}');
      print('💳 Método de pago parseado: ${paymentMethod?.type.displayName ?? 'No disponible'}');
    } catch (e, stackTrace) {
      print('❌ Error en initState de CashDroPaymentScreen: $e');
      print('📚 Stack trace: $stackTrace');
    }
    
    // Iniciar transacción
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startPayment();
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  Future<void> _startPayment() async {
    final notifier = ref.read(cashdroPaymentNotifierProvider.notifier);
    
    await notifier.executePayment(
      amount: widget.amount,
      aliasId: widget.ticketId,
    );
  }

  void _initializeWebView(String ipAddress) {
    if (_webViewInitialized) return;
    
    // URL del WebView de CashDro
    const webViewUrl = 'https://parica101.ngrok.app/Cashdro3Web/index.html#/splash/true';

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.background)
      ..loadRequest(Uri.parse(webViewUrl));

    setState(() {
      _webViewInitialized = true;
    });

    print('🌐 WebView inicializado: $webViewUrl');
  }

  void _handleTransactionFinishing() async {
    if (_hasNavigated) return;
    _hasNavigated = true;

    // Obtener timeout de la configuración
    final config = await CashdroConfigService.getConfig();
    final timeoutSeconds = config.timeoutSeconds;

    print('🔄 CashDro: Transacción en estado finishing');
    print('⏱️ CashDro: Mostrando WebView por $timeoutSeconds segundos...');

    // Esperar el tiempo configurado mientras se muestra el WebView
    await Future.delayed(Duration(seconds: timeoutSeconds));

    if (!mounted) return;

    print('🎉 CashDro: Navegando a pantalla de éxito');

    // Limpiar estado del provider ANTES de navegar
    ref.read(cashdroPaymentNotifierProvider.notifier).reset();

    // Navegar
    Navigator.of(context).pushReplacementNamed(
      PaymentSuccessScreen.routeName,
      arguments: {
        'amount': widget.amount,
        'paymentMethod': 'CashDro',
      },
    );
  }

  Future<void> _handleTransactionCompleted() async {
    if (_hasNavigated) return;
    _hasNavigated = true;

    print('🎉 CashDro: Transacción completada, navegando inmediatamente');

    // Pequeña pausa para mostrar el estado completado
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Limpiar estado del provider ANTES de navegar
    ref.read(cashdroPaymentNotifierProvider.notifier).reset();

    // Navegar
    Navigator.of(context).pushReplacementNamed(
      PaymentSuccessScreen.routeName,
      arguments: {
        'amount': widget.amount,
        'paymentMethod': 'CashDro',
      },
    );
  }

  /// Manejar botón atrás - cancelar transacción y navegar a PaymentConfirmationScreen
  Future<void> _handleBackButton(CashDroTransaction transaction) async {
    print('🔙 CashDro: Usuario presionó botón atrás');

    // Resetear inmediatamente el provider para detener cualquier operación en curso
    ref.read(cashdroPaymentNotifierProvider.notifier).reset();
    print('🔄 CashDro: Provider reseteado inmediatamente');

    // Si hay una transacción en curso, intentar cancelarla en background (sin esperar)
    if (transaction.operationId != null && 
        (transaction.isInProgress || transaction.state == CashDroTransactionState.polling)) {
      print('🛑 CashDro: Iniciando cancelación en background');
      
      // Cancelar en background sin esperar el resultado
      ref.read(cashdroPaymentNotifierProvider.notifier).cancelTransaction().catchError((e) {
        print('❌ CashDro: Error en cancelación background: $e');
      });
    }

    // Navegar inmediatamente sin esperar la cancelación
    if (mounted) {
      print('🚀 CashDro: Navegando inmediatamente a PaymentConfirmationScreen');
      Navigator.of(context).pushReplacementNamed(
        PaymentConfirmationScreen.routeName,
        arguments: {
          'amount': widget.amount,
          'invoiceData': widget.invoiceData,
        },
      );
    }
  }

  /// Obtener símbolo de moneda de la licencia o valor por defecto
  String _getCurrencySymbol() {
    try {
      // Intentar obtener el símbolo de moneda de la licencia
      final licenseAsync = ref.read(licenseProvider);
      return licenseAsync.when(
        data: (licenseData) {
          // Por ahora usar símbolo por defecto, se puede extender para obtener de la licencia
          return 'S/'; // Símbolo por defecto para Perú
        },
        loading: () => 'S/',
        error: (_, __) => 'S/',
      );
    } catch (e) {
      print('⚠️ Error obteniendo símbolo de moneda: $e');
      return 'S/'; // Fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      final d = ref.watch(appDimensionsProvider(context));
      final colorScheme = Theme.of(context).colorScheme;
      final transaction = ref.watch(cashdroPaymentNotifierProvider);

    // Escuchar cambios de estado - cuando cambia a finishing
    ref.listen<CashDroTransaction>(
      cashdroPaymentNotifierProvider,
      (previous, next) {
        print('🔄 CashDro: Estado cambió de ${previous?.state} a ${next.state}');
        
        // Solo ejecutar si no hemos navegado aún
        if (!_hasNavigated) {
          // Caso 1: Cambio a finishing - mostrar WebView y esperar
          if (previous != null &&
              previous.state != CashDroTransactionState.finishing &&
              next.state == CashDroTransactionState.finishing) {
            print('🔄 CashDro: Detectado cambio a finishing - mostrando WebView');
            _handleTransactionFinishing();
          }
          // Caso 2: Cambio a completed - solo navegar si ya pasó por finishing
          else if (next.state == CashDroTransactionState.completed && 
                   previous?.state == CashDroTransactionState.finishing) {
            print('🔄 CashDro: Transacción completada después de finishing');
            _handleTransactionCompleted();
          }
        }
      },
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header con monto
            ScreenHeader(
              title: 'Pago con CashDro - ${_getCurrencySymbol()}${widget.amount.toStringAsFixed(2)}',
              d: d,
              colorScheme: colorScheme,
              onBack: () => _handleBackButton(transaction),
            ),

            // Contenido principal
            Expanded(
              child: _buildContent(transaction, d, colorScheme),
            ),
          ],
        ),
      ),
    );
    } catch (e, stackTrace) {
      print('❌ Error en build de CashDroPaymentScreen: $e');
      print('📚 Stack trace: $stackTrace');
      
      // Fallback UI en caso de error
      return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error al cargar pantalla de pago',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Por favor, intenta nuevamente',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Volver'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildContent(
    CashDroTransaction transaction,
    AppDimensions d,
    ColorScheme colorScheme,
  ) {
    print('🔍 CashDro: _buildContent - Estado actual: ${transaction.state}');
    print('🔍 CashDro: _buildContent - HasError: ${transaction.hasError}');
    print('🔍 CashDro: _buildContent - HasNavigated: $_hasNavigated');

    // Estado de error
    if (transaction.hasError) {
      print('❌ CashDro: Mostrando estado de error');
      return _buildErrorState(transaction, d);
    }

    // Inicializar WebView si aún no está inicializado
    if (!_webViewInitialized && transaction.operationId != null) {
      _initializeWebView('');
    }

    // Mostrar WebView para estados en progreso, polling, finishing Y completed (si no ha navegado)
    if (transaction.isInProgress || 
        transaction.state == CashDroTransactionState.polling ||
        transaction.state == CashDroTransactionState.finishing ||
        (transaction.state == CashDroTransactionState.completed && !_hasNavigated)) {
      print('🌐 CashDro: Mostrando WebView - Estado: ${transaction.state}');
      return _buildWebViewState(transaction, d, colorScheme);
    }

    // Estado completado (solo si ya se ha navegado o como fallback)
    if (transaction.state == CashDroTransactionState.completed) {
      print('✅ CashDro: Mostrando estado completado');
      return _buildCompletedState(d);
    }

    // Estado por defecto - loading
    return _buildLoadingState('Iniciando...', d);
  }

  Widget _buildLoadingState(String message, AppDimensions d) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: d.iconSizeL * 2,
            height: d.iconSizeL * 2,
            child: CircularProgressIndicator(
              strokeWidth: d.borderWidth * 4,
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: d.spacingL),
          Text(
            message,
            style: AppTextStyles.subtitle(d).copyWith(
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWebViewState(
    CashDroTransaction transaction,
    AppDimensions d,
    ColorScheme colorScheme,
  ) {
    // WebView con overlay informativo si está completado
    Widget webViewWidget = _webViewInitialized && _webViewController != null
        ? WebViewWidget(controller: _webViewController!)
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: AppColors.primary,
                ),
                SizedBox(height: d.spacingM),
                Text(
                  'Cargando interfaz de CashDro...',
                  style: AppTextStyles.body(d).copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );

    // Si está completado, mostrar overlay informativo
    if (transaction.state == CashDroTransactionState.completed && !_hasNavigated) {
      return Stack(
        children: [
          webViewWidget,
          // Overlay semi-transparente con mensaje
          Positioned(
            bottom: d.spacingXL,
            left: d.spacingM,
            right: d.spacingM,
            child: Container(
              padding: d.paddingM,
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(d.borderRadiusM),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: d.iconSizeM,
                  ),
                  SizedBox(width: d.spacingS),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Pago Completado',
                          style: AppTextStyles.subtitle(d).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Finalizando proceso...',
                          style: AppTextStyles.caption(d).copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return webViewWidget;
  }

  Widget _buildErrorState(CashDroTransaction transaction, AppDimensions d) {
    return Center(
      child: Padding(
        padding: d.paddingL,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: d.iconSizeL * 2,
              color: AppColors.error,
            ),
            SizedBox(height: d.spacingL),
            Text(
              'Error en la Transacción',
              style: AppTextStyles.title(d).copyWith(
                color: AppColors.error,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: d.spacingM),
            Text(
              transaction.errorMessage ?? 'Ha ocurrido un error inesperado',
              style: AppTextStyles.body(d).copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: d.spacingXL),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: d.spacingM),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(d.borderRadiusL),
                  ),
                ),
                onPressed: () {
                  ref.read(cashdroPaymentNotifierProvider.notifier).reset();
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back, size: d.iconSizeM),
                label: Text(
                  'Volver',
                  style: AppTextStyles.button(d),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompletedState(AppDimensions d) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            size: d.iconSizeL * 2,
            color: AppColors.success,
          ),
          SizedBox(height: d.spacingL),
          Text(
            'Pago Completado',
            style: AppTextStyles.title(d).copyWith(
              color: AppColors.success,
            ),
          ),
          SizedBox(height: d.spacingM),
          Text(
            'Redirigiendo...',
            style: AppTextStyles.body(d).copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

}
