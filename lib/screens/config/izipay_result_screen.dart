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
        title: Text(widget.title, style: AppTextStyles.title(d)),
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
                  style: AppTextStyles.subtitle(d),
                ),
              SizedBox(height: d.spacingM),
              Expanded(
                child: Container(
                  padding: d.paddingM,
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(d.borderRadiusM),
                  ),
                  child: SingleChildScrollView(
                    child: SelectableText(
                      _plainText,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: d.fontSizeBody,
                      ),
                    ),
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
