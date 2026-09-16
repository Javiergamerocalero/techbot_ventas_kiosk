import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/services/app_log.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

/// Registro de lo que el kiosco le manda a Izipay y a facturación, con su
/// respuesta. Pedido por Javier el 2026-09-16 para poder diagnosticar la
/// integración sin estar delante del equipo.
class ConfigLogsScreen extends ConsumerStatefulWidget {
  const ConfigLogsScreen({super.key});

  @override
  ConsumerState<ConfigLogsScreen> createState() => _ConfigLogsScreenState();
}

class _ConfigLogsScreenState extends ConsumerState<ConfigLogsScreen> {
  AppLogCategoria? _filtro;

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final cs = Theme.of(context).colorScheme;

    return ValueListenableBuilder<List<AppLogEntry>>(
      valueListenable: AppLog.entradas,
      builder: (context, todas, _) {
        final entradas = _filtro == null
            ? todas
            : todas.where((e) => e.categoria == _filtro).toList();

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                d.horizontalPadding,
                d.spacingM,
                d.horizontalPadding,
                d.spacingS,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _chipFiltro(null, 'Todo', todas.length, d, cs),
                          for (final c in AppLogCategoria.values)
                            _chipFiltro(
                              c,
                              c.etiqueta,
                              todas.where((e) => e.categoria == c).length,
                              d,
                              cs,
                            ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Copiar todo',
                    icon: Icon(Icons.copy_all, size: d.iconSizeM),
                    onPressed: todas.isEmpty ? null : _copiarTodo,
                  ),
                  IconButton(
                    tooltip: 'Borrar registro',
                    icon: Icon(Icons.delete_outline,
                        size: d.iconSizeM, color: cs.error),
                    onPressed: todas.isEmpty ? null : _confirmarBorrado,
                  ),
                ],
              ),
            ),
            Divider(height: d.borderWidth),
            Expanded(
              child: entradas.isEmpty
                  ? _vacio(d, cs)
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: d.horizontalPadding,
                        vertical: d.spacingS,
                      ),
                      itemCount: entradas.length,
                      separatorBuilder: (_, __) => SizedBox(height: d.spacingS),
                      itemBuilder: (context, i) =>
                          _tarjeta(entradas[i], d, cs),
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _chipFiltro(
    AppLogCategoria? categoria,
    String etiqueta,
    int cuantas,
    d,
    ColorScheme cs,
  ) {
    final activo = _filtro == categoria;
    return Padding(
      padding: EdgeInsets.only(right: d.spacingS),
      child: FilterChip(
        label: Text('$etiqueta ($cuantas)'),
        selected: activo,
        onSelected: (_) => setState(() => _filtro = categoria),
        selectedColor: cs.primary,
        labelStyle: AppTextStyles.caption(d).copyWith(
          color: activo ? cs.onPrimary : cs.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _vacio(d, ColorScheme cs) => Center(
        child: Padding(
          padding: EdgeInsets.all(d.spacingXL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.receipt_long,
                  size: d.iconSizeL * 2,
                  color: cs.onSurface.withValues(alpha: 0.25)),
              SizedBox(height: d.spacingL),
              Text(
                'Todavía no hay operaciones registradas',
                textAlign: TextAlign.center,
                style: AppTextStyles.body(d).copyWith(
                  color: cs.onSurface.withValues(alpha: 0.6),
                ),
              ),
              SizedBox(height: d.spacingS),
              Text(
                'Acá quedan los cobros con Izipay y los comprobantes, '
                'con lo que se envía y lo que responde cada uno.',
                textAlign: TextAlign.center,
                style: AppTextStyles.caption(d).copyWith(
                  color: cs.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _tarjeta(AppLogEntry e, d, ColorScheme cs) {
    final color = e.ok ? Colors.green.shade700 : cs.error;
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(d.borderRadiusM),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: d.spacingM),
          childrenPadding: EdgeInsets.fromLTRB(
            d.spacingM,
            0,
            d.spacingM,
            d.spacingM,
          ),
          leading: Icon(
            e.ok ? Icons.check_circle_outline : Icons.error_outline,
            color: color,
            size: d.iconSizeM,
          ),
          title: Text(
            e.operacion,
            style: AppTextStyles.body(d).copyWith(fontWeight: FontWeight.w600),
          ),
          subtitle: Text(
            '${e.horaCorta} · ${e.categoria.etiqueta}'
            '${e.milisegundos != null ? ' · ${e.milisegundos} ms' : ''}'
            '${e.detalle != null ? '\n${e.detalle}' : ''}',
            style: AppTextStyles.caption(d).copyWith(
              color: cs.onSurface.withValues(alpha: 0.7),
            ),
          ),
          children: [
            _bloque('Se envió', e.request, d, cs),
            _bloque('Respondió', e.response, d, cs),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                icon: Icon(Icons.copy, size: d.iconSizeS),
                label: const Text('Copiar esta'),
                onPressed: () => _copiar(
                  '${e.horaCorta} ${e.categoria.etiqueta} ${e.operacion}\n'
                  '${e.detalle ?? ''}\n'
                  'envío: ${e.request}\n'
                  'respuesta: ${e.response}',
                  'Operación copiada',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bloque(String titulo, String contenido, d, ColorScheme cs) {
    if (contenido.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: AppTextStyles.caption(d).copyWith(
            fontWeight: FontWeight.bold,
            color: cs.primary,
          ),
        ),
        SizedBox(height: d.spacingXS),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(d.spacingS),
          margin: EdgeInsets.only(bottom: d.spacingS),
          decoration: BoxDecoration(
            color: cs.onSurface.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(d.borderRadiusS),
          ),
          child: SelectableText(
            contenido,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: d.fontSizeCaption * 0.95,
              color: cs.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  void _copiarTodo() => _copiar(AppLog.exportarTexto(), 'Registro copiado');

  void _copiar(String texto, String aviso) {
    Clipboard.setData(ClipboardData(text: texto));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(aviso), duration: const Duration(seconds: 2)),
    );
  }

  Future<void> _confirmarBorrado() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (dc) => AlertDialog(
        title: const Text('Borrar registro'),
        content: const Text(
          'Se borran todas las operaciones guardadas. No se puede deshacer.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dc, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dc, true),
            child: const Text('Borrar'),
          ),
        ],
      ),
    );
    if (ok == true) await AppLog.limpiar();
  }
}
