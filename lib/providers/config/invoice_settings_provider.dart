import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'invoice_settings_provider.g.dart';

/// Configuración de la facturación electrónica del kiosko.
///
/// Permite suspender el envío de comprobantes al servicio de facturación
/// electrónica (TechFact). Cuando está suspendida, el kiosko solo imprime el
/// comprobante, sin reservar correlativo ni enviar a TechFact.
@Riverpod(keepAlive: true)
class InvoiceSettings extends _$InvoiceSettings {
  static const String _suspendedKey = 'electronic_invoice_suspended';

  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_suspendedKey) ?? false;
  }

  /// Activa o desactiva la suspensión de la facturación electrónica.
  Future<void> setSuspended(bool suspended) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_suspendedKey, suspended);
    state = AsyncData(suspended);
  }
}

/// Lectura síncrona del estado de suspensión de la facturación electrónica.
///
/// Devuelve `false` mientras la configuración aún se está cargando o si nunca
/// se ha guardado, de modo que el comportamiento por defecto es facturar.
final electronicInvoiceSuspendedProvider = Provider<bool>((ref) {
  final settings = ref.watch(invoiceSettingsProvider);
  return settings.value ?? false;
});
