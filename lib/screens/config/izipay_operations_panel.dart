import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/screens/config/izipay_result_screen.dart';
import 'package:ventas_kiosko/services/izipay_service.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

/// Operaciones de supervisor del PinPad Izipay (PMP-API).
///
/// Usa el mismo [IzipayService] de compra/anulación. Códigos PMP:
/// duplicado 03, reporte detallado 04, reporte totales 05, anulación 06,
/// cierre 07.
class IzipayOperationsPanel extends ConsumerStatefulWidget {
  const IzipayOperationsPanel({super.key});

  @override
  ConsumerState<IzipayOperationsPanel> createState() =>
      _IzipayOperationsPanelState();
}

class _IzipayOperationsPanelState extends ConsumerState<IzipayOperationsPanel> {
  final _service = IzipayService();
  bool _busy = false;

  Future<void> _run(
    String title,
    Future<IzipayPurchaseResult> Function() op,
  ) async {
    if (_busy) return;
    setState(() => _busy = true);
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: Row(
          children: [
            SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
            SizedBox(width: 16),
            Expanded(child: Text('Consultando pinpad...')),
          ],
        ),
      ),
    );
    try {
      final result = await op();
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      Navigator.of(context).pushNamed(
        IzipayResultScreen.routeName,
        arguments: {
          'title': title,
          'result': result,
        },
      );
    } catch (e) {
      if (!mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      final msg = e is IzipayException ? e.message : e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(msg), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _runVoid() async {
    final amountCtrl = TextEditingController();
    final refCtrl = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('Anulación'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amountCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Monto (S/)',
                hintText: '10.50',
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: refCtrl,
              decoration: const InputDecoration(
                labelText: 'Referencia (trace / REF)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(d, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(d, true),
            child: const Text('Anular'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    final amount = double.tryParse(amountCtrl.text.trim().replaceAll(',', '.'));
    final reference = refCtrl.text.trim();
    if (amount == null || amount <= 0 || reference.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Monto y referencia son obligatorios')),
      );
      return;
    }
    await _run(
      'Anulación',
      () => _service.voidPurchase(amount: amount, reference: reference),
    );
  }

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final cs = Theme.of(context).colorScheme;

    Widget tile({
      required IconData icon,
      required String label,
      required VoidCallback onTap,
      Color? color,
    }) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: _busy ? null : onTap,
          icon: Icon(icon, color: color ?? cs.primary),
          label: Align(
            alignment: Alignment.centerLeft,
            child: Text(label),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Operaciones Izipay',
          style: TextStyle(
            fontSize: d.fontSizeBody,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: d.spacingS),
        Text(
          'El resultado se muestra en pantalla. Desde ahí puedes imprimir '
          'o cerrar. El cierre de turno no se puede deshacer.',
          style: AppTextStyles.caption(d).copyWith(
            color: cs.onSurface.withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: d.spacingM),
        tile(
          icon: Icons.print_outlined,
          label: 'Duplicado',
          onTap: () => _run('Duplicado', _service.duplicateLast),
        ),
        SizedBox(height: d.spacingS),
        tile(
          icon: Icons.undo_outlined,
          label: 'Anulación',
          color: cs.error,
          onTap: _runVoid,
        ),
        SizedBox(height: d.spacingS),
        tile(
          icon: Icons.list_alt_outlined,
          label: 'Reporte detallado',
          onTap: () => _run('Reporte detallado', _service.detailedReport),
        ),
        SizedBox(height: d.spacingS),
        tile(
          icon: Icons.summarize_outlined,
          label: 'Reporte totales',
          onTap: () => _run('Reporte totales', _service.totalsReport),
        ),
        SizedBox(height: d.spacingS),
        tile(
          icon: Icons.lock_clock_outlined,
          label: 'Cierre de turno',
          color: cs.error,
          onTap: () async {
            final ok = await showDialog<bool>(
              context: context,
              builder: (d) => AlertDialog(
                title: const Text('Cierre de turno'),
                content: const Text(
                  'Vas a cerrar el lote del pinpad Izipay. '
                  'Esta acción no se puede deshacer. ¿Continuar?',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(d, false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(d, true),
                    child: const Text('Cerrar turno'),
                  ),
                ],
              ),
            );
            if (ok == true && mounted) {
              await _run('Cierre de turno', _service.closeShift);
            }
          },
        ),
      ],
    );
  }
}
