import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/printer/printer_provider.dart';
import 'package:ventas_kiosko/services/izipay_service.dart';
import 'package:ventas_kiosko/services/izipay_voucher_formatter.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

/// Resultado de una operación de supervisor Izipay: primero en pantalla,
/// con botones Imprimir y Cerrar.
class IzipayResultScreen extends ConsumerStatefulWidget {
  static const routeName = '/izipay-result';

  const IzipayResultScreen({
    super.key,
    required this.title,
    required this.result,
  });

  final String title;
  final IzipayPurchaseResult result;

  @override
  ConsumerState<IzipayResultScreen> createState() => _IzipayResultScreenState();
}

class _IzipayResultScreenState extends ConsumerState<IzipayResultScreen> {
  bool _printing = false;
  String? _printError;

  String get _plainText {
    if (widget.result.printData.trim().isEmpty) {
      return widget.result.message.isNotEmpty
          ? widget.result.message
          : 'Operación completada.';
    }
    final formatted = IzipayVoucherFormatter.toPlainText(widget.result.printData);
    return formatted.trim().isEmpty ? widget.result.message : formatted;
  }

  Future<void> _print() async {
    setState(() {
      _printing = true;
      _printError = null;
    });
    try {
      await ref.read(printerManagerProvider.notifier).print(
            _plainText,
            partialCut: true,
          );
    } catch (e) {
      if (mounted) {
        setState(() => _printError = e.toString());
      }
    } finally {
      if (mounted) setState(() => _printing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final cs = Theme.of(context).colorScheme;
    final canPrint = widget.result.printData.trim().isNotEmpty ||
        widget.result.message.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: AppTextStyles.subtitle(d),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: d.paddingL,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.result.message.isNotEmpty)
                Text(
                  widget.result.message,
                  style: AppTextStyles.caption(d).copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              SizedBox(height: d.spacingM),
              Expanded(
                child: Container(
                  padding: d.paddingM,
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(d.borderRadiusM),
                  ),
                  // El voucher viene en columnas fijas (38 caracteres la
                  // fuente normal, según la sección 6 del manual), así que
                  // el tamaño se calcula para que una fila entera entre sin
                  // partirse. Con letra grande cada línea se cortaba en dos
                  // y el comprobante quedaba ilegible (Javier, 2026-09-16).
                  child: LayoutBuilder(
                    builder: (context, restricciones) {
                      final tamano = VoucherFit.tamanoQueEntra(restricciones.maxWidth);
                      return SingleChildScrollView(
                        child: SelectableText(
                          _plainText,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: tamano,
                            height: 1.25,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (_printError != null) ...[
                SizedBox(height: d.spacingS),
                Text(
                  'No se pudo imprimir: $_printError',
                  style: TextStyle(color: cs.error, fontSize: d.fontSizeCaption),
                ),
              ],
              SizedBox(height: d.spacingL),
              FilledButton.icon(
                onPressed: !canPrint || _printing ? null : _print,
                icon: _printing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.print),
                label: Text(_printing ? 'Imprimiendo...' : 'Imprimir'),
              ),
              SizedBox(height: d.spacingM),
              OutlinedButton.icon(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
                label: const Text('Cerrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Qué tamaño de letra hace que una fila del voucher entre entera.
///
/// El comprobante viene en columnas fijas — 38 caracteres la fuente
/// normal, según la sección 6 del manual PMP-API — así que el tamaño no
/// puede salir de la escala general de la app: tiene que salir del ancho
/// disponible. Con letra grande cada fila se partía en dos y el voucher
/// quedaba ilegible.
///
/// La proporción de un carácter monoespaciado **se mide**, no se estima:
/// depende de la fuente que tenga el equipo, y una constante a ojo falla
/// en cuanto el dispositivo usa otra. Medir cuesta un layout de 38
/// caracteres, que es nada.
class VoucherFit {
  const VoucherFit._();

  /// Caracteres por fila en fuente normal.
  static const columnas = 38;

  static const tamanoMinimo = 7.0;
  static const tamanoMaximo = 15.0;

  /// Tamaño de referencia para medir; el resultado se escala desde acá.
  static const _referencia = 20.0;

  static double tamanoQueEntra(double anchoDisponible) {
    if (!anchoDisponible.isFinite || anchoDisponible <= 0) return tamanoMinimo;

    final medidor = TextPainter(
      text: TextSpan(
        text: 'X' * columnas,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: _referencia,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    // Ancho de la fila por cada punto de tamaño de letra.
    final anchoPorPunto = medidor.width / _referencia;
    if (anchoPorPunto <= 0) return tamanoMinimo;

    return (anchoDisponible / anchoPorPunto)
        .clamp(tamanoMinimo, tamanoMaximo);
  }
}
