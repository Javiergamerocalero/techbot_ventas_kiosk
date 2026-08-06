import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/printer/printer_provider.dart';
import 'package:ventas_kiosko/screens/payment_success_screen.dart';
import 'package:ventas_kiosko/services/izipay_service.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

/// Pantalla del flow de pago con PinPad Izipay (P400 vía PMP-API REST).
///
/// Recibe por [amount] el monto a cobrar y por [invoiceData] los
/// datos del comprobante (que luego se muestran en la pantalla de
/// éxito, igual que el resto de métodos de pago). Estados:
///
///  - `starting`  — se dispara la compra.
///  - `awaitCard` — pinpad esperando lectura de tarjeta / PIN.
///  - `binReceived` — solo en modo "Con BIN": el pinpad devolvió el
///    BIN y estamos por disparar la compra final.
///  - `processing` — compra final en curso (puede tardar hasta 120s).
///  - `success` — compra aprobada, se navega a Success.
///  - `failure` — compra rechazada o error de red, con botones
///    Reintentar / Cancelar.
class IzipayPaymentScreen extends ConsumerStatefulWidget {
  static const routeName = '/payment-izipay';

  const IzipayPaymentScreen({
    super.key,
    required this.amount,
    this.invoiceData,
  });

  final double amount;
  final Map<String, dynamic>? invoiceData;

  @override
  ConsumerState<IzipayPaymentScreen> createState() =>
      _IzipayPaymentScreenState();
}

enum _IzipayState {
  starting,
  awaitCard,
  binReceived,
  processing,
  success,
  failure,
}

class _IzipayPaymentScreenState extends ConsumerState<IzipayPaymentScreen> {
  final _service = IzipayService();

  _IzipayState _state = _IzipayState.starting;
  String? _bin;
  String _errorMessage = '';
  IzipayPurchaseResult? _result;

  @override
  void initState() {
    super.initState();
    // Arrancar el flow apenas se monta la pantalla.
    WidgetsBinding.instance.addPostFrameCallback((_) => _run());
  }

  Future<void> _run() async {
    setState(() {
      _state = _IzipayState.awaitCard;
      _errorMessage = '';
      _bin = null;
      _result = null;
    });

    try {
      final result = await _service.purchase(
        amount: widget.amount,
        onBinReceived: (bin) async {
          if (!mounted) return false;
          setState(() {
            _state = _IzipayState.binReceived;
            _bin = bin;
          });
          // Delay corto para que el operador vea el BIN antes de
          // que arranque el paso final. La UI queda en "binReceived"
          // hasta que este callback devuelve true.
          await Future.delayed(const Duration(milliseconds: 800));
          if (!mounted) return false;
          setState(() => _state = _IzipayState.processing);
          return true;
        },
      );

      // Imprimir voucher — no bloqueamos el éxito si la impresión falla.
      await _tryPrintVoucher(result.printData);

      if (!mounted) return;
      setState(() {
        _state = _IzipayState.success;
        _result = result;
      });

      // Pequeño delay para que el user vea "Aprobado" antes de
      // saltar al PaymentSuccessScreen.
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(
        PaymentSuccessScreen.routeName,
        arguments: {
          'amount': widget.amount,
          'invoiceData': widget.invoiceData,
          'approvalCode': result.approvalCode,
          'card': result.card,
        },
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _state = _IzipayState.failure;
        _errorMessage = _humanizeError(e);
      });
    }
  }

  Future<void> _tryPrintVoucher(String printData) async {
    if (printData.isEmpty) return;
    try {
      final printable = IzipayVoucherFormatter.toPlainText(printData);
      if (printable.trim().isEmpty) return;
      // Usamos el mismo PrinterManager que el resto del app — lee la
      // impresora seleccionada de SharedPreferences y hace sendData.
      await ref.read(printerManagerProvider.notifier).print(
            printable,
            partialCut: true,
          );
    } catch (e) {
      // La impresión no debe romper el éxito del pago — el operador
      // puede reimprimir después desde el menú admin del pinpad.
      // ignore: avoid_print
      print('⚠️ Izipay voucher print falló (no bloqueante): $e');
    }
  }

  String _humanizeError(Object e) {
    if (e is IzipayException) return e.message;
    return 'Ocurrió un error inesperado. Intenta nuevamente.';
  }

  IconData _iconFor(_IzipayState s) => switch (s) {
        _IzipayState.starting || _IzipayState.awaitCard => Icons.credit_card,
        _IzipayState.binReceived => Icons.pin,
        _IzipayState.processing => Icons.sync,
        _IzipayState.success => Icons.check_circle,
        _IzipayState.failure => Icons.error,
      };

  String _titleFor(_IzipayState s) => switch (s) {
        _IzipayState.starting => 'Iniciando pago...',
        _IzipayState.awaitCard =>
          'Inserte, deslice o acerque su tarjeta al pinpad',
        _IzipayState.binReceived => 'Tarjeta detectada',
        _IzipayState.processing => 'Procesando pago...',
        _IzipayState.success => '¡Pago aprobado!',
        _IzipayState.failure => 'Pago no completado',
      };

  String _subtitleFor(_IzipayState s) => switch (s) {
        _IzipayState.starting => '',
        _IzipayState.awaitCard =>
          'Siga las instrucciones en la pantalla del pinpad',
        _IzipayState.binReceived => _bin != null && _bin!.isNotEmpty
            ? 'BIN: $_bin'
            : 'Verificando datos...',
        _IzipayState.processing => 'Esperando confirmación del pinpad',
        _IzipayState.success => _result?.approvalCode.isNotEmpty == true
            ? 'Código de aprobación: ${_result!.approvalCode}'
            : '',
        _IzipayState.failure => _errorMessage,
      };

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final cs = Theme.of(context).colorScheme;
    final s = _state;
    final isBusy = s == _IzipayState.starting ||
        s == _IzipayState.awaitCard ||
        s == _IzipayState.binReceived ||
        s == _IzipayState.processing;

    return Scaffold(
      backgroundColor: cs.surface,
      body: SafeArea(
        child: Padding(
          padding: d.paddingL,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    _iconFor(s),
                    size: d.iconSizeL * 3,
                    color: s == _IzipayState.success
                        ? Colors.green
                        : s == _IzipayState.failure
                            ? cs.error
                            : cs.primary,
                  ),
                  SizedBox(height: d.spacingL),
                  Text(
                    _titleFor(s),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title(d),
                  ),
                  SizedBox(height: d.spacingM),
                  Text(
                    _subtitleFor(s),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: d.fontSizeBody,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: d.spacingXL),
                  Text(
                    'S/ ${widget.amount.toStringAsFixed(2)}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: d.fontSizeTitle * 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: d.spacingXL),
                  if (isBusy)
                    const Center(child: CircularProgressIndicator())
                  else if (s == _IzipayState.failure) ...[
                    FilledButton.icon(
                      onPressed: _run,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                    ),
                    SizedBox(height: d.spacingM),
                    OutlinedButton.icon(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                      label: const Text('Cancelar'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Convierte el `print_data` que devuelve el PinPad Izipay (formato
/// binario con prefijos de fuente) a texto plano imprimible línea a
/// línea. El spec (sección 6) define:
///
///  - Cada línea empieza con un byte de formato (0x41 fuente normal,
///    0x42 doble, 0x43/0x44 invertidos) y termina con 0x0D.
///  - Líneas en blanco: bytes `32 1B 20 0D`.
///  - Líneas con imagen: `0x32 0x1C 0xZZ 0x0D` — para impresión
///    térmica simple las ignoramos.
///
/// Este parser saca todos los prefijos de formato y devuelve el
/// texto plano — suficiente para una impresora térmica básica que no
/// distingue fuentes.
class IzipayVoucherFormatter {
  static String toPlainText(String printData) {
    final lines = <String>[];
    final buffer = StringBuffer();
    var expectingFormatPrefix = true;

    for (final rune in printData.runes) {
      if (rune == 0x0D || rune == 0x0A) {
        lines.add(buffer.toString());
        buffer.clear();
        expectingFormatPrefix = true;
        continue;
      }
      if (expectingFormatPrefix &&
          (rune == 0x41 || rune == 0x42 || rune == 0x43 || rune == 0x44)) {
        // Consumir el prefijo de formato sin agregarlo al texto.
        expectingFormatPrefix = false;
        continue;
      }
      // Ignorar bytes de control raros (ESC 0x1B, GS 0x1D, FS 0x1C).
      if (rune == 0x1B || rune == 0x1D || rune == 0x1C) {
        expectingFormatPrefix = false;
        continue;
      }
      expectingFormatPrefix = false;
      buffer.write(String.fromCharCode(rune));
    }
    if (buffer.isNotEmpty) lines.add(buffer.toString());

    // Eliminar líneas duplicadas de padding y trimear derecha.
    return lines.map((l) => l.trimRight()).join('\n');
  }
}
