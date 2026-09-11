import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/screens/config/izipay_operations_panel.dart';
import 'package:ventas_kiosko/services/izipay_service.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

/// Config del PinPad Izipay (P400 vía PMP-API REST).
///
/// Guarda IP, puerto, credenciales de login del web service y el
/// toggle "Solicita BIN antes de compra" en SharedPreferences. Los
/// valores los lee [IzipayService] al momento de cada compra.
class ConfigIzipayScreen extends ConsumerStatefulWidget {
  static const routeName = '/config-izipay';

  const ConfigIzipayScreen({super.key});

  @override
  ConsumerState<ConfigIzipayScreen> createState() =>
      _ConfigIzipayScreenState();
}

class _ConfigIzipayScreenState extends ConsumerState<ConfigIzipayScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ipCtrl = TextEditingController();
  final _portCtrl = TextEditingController();
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  bool _withBin = false;
  bool _obscurePass = true;
  bool _saving = false;
  bool _testing = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _ipCtrl.dispose();
    _portCtrl.dispose();
    _userCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _ipCtrl.text = prefs.getString(IzipayService.kPrefIp) ?? '';
      _portCtrl.text = prefs.getString(IzipayService.kPrefPort) ?? '9090';
      _userCtrl.text = prefs.getString(IzipayService.kPrefUser) ?? 'izipay';
      _passCtrl.text =
          prefs.getString(IzipayService.kPrefPassword) ?? 'izipay';
      _withBin = prefs.getBool(IzipayService.kPrefWithBin) ?? false;
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(IzipayService.kPrefIp, _ipCtrl.text.trim());
    await prefs.setString(IzipayService.kPrefPort, _portCtrl.text.trim());
    await prefs.setString(IzipayService.kPrefUser, _userCtrl.text.trim());
    await prefs.setString(IzipayService.kPrefPassword, _passCtrl.text);
    await prefs.setBool(IzipayService.kPrefWithBin, _withBin);
    if (!mounted) return;
    setState(() => _saving = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Configuración de Izipay guardada')),
    );
  }

  Future<void> _test() async {
    if (!_formKey.currentState!.validate()) return;
    // Guardar antes de testear para que IzipayService lea los valores
    // actuales del formulario, no la versión antes del último cambio.
    await _save();
    setState(() => _testing = true);
    final ok = await IzipayService().test();
    if (!mounted) return;
    setState(() => _testing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Pinpad Izipay disponible ✓'
              : 'No fue posible contactar al pinpad',
        ),
        backgroundColor: ok ? Colors.green : Colors.red,
      ),
    );
  }

  String? _required(String? v, String field) {
    if (v == null || v.trim().isEmpty) return '$field es obligatorio';
    return null;
  }

  String? _validateIp(String? v) {
    final r = _required(v, 'IP');
    if (r != null) return r;
    final ip = v!.trim();
    // Validación laxa: acepta IP v4 o hostname (por si es DNS local).
    if (!RegExp(r'^[a-zA-Z0-9.\-]+$').hasMatch(ip)) {
      return 'IP o hostname inválido';
    }
    return null;
  }

  String? _validatePort(String? v) {
    final r = _required(v, 'Puerto');
    if (r != null) return r;
    final n = int.tryParse(v!.trim());
    if (n == null || n <= 0 || n > 65535) return 'Puerto debe ser 1-65535';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        title: Text(
          'Configurar Izipay',
          style: AppTextStyles.title(d).copyWith(color: colorScheme.onSurface),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: d.iconSizeM),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: d.paddingL,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Conexión al PinPad',
                    style: TextStyle(
                        fontSize: d.fontSizeBody,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: d.spacingM),
                TextFormField(
                  controller: _ipCtrl,
                  decoration: const InputDecoration(
                    labelText: 'IP del dispositivo Izipay',
                    hintText: '192.168.1.50',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  validator: _validateIp,
                ),
                SizedBox(height: d.spacingM),
                TextFormField(
                  controller: _portCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Puerto',
                    hintText: '9090',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: _validatePort,
                ),
                SizedBox(height: d.spacingL),
                Text('Credenciales del Web Service',
                    style: TextStyle(
                        fontSize: d.fontSizeBody,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: d.spacingM),
                TextFormField(
                  controller: _userCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Usuario (ecr_usuario)',
                    hintText: 'izipay',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => _required(v, 'Usuario'),
                ),
                SizedBox(height: d.spacingM),
                TextFormField(
                  controller: _passCtrl,
                  obscureText: _obscurePass,
                  decoration: InputDecoration(
                    labelText: 'Contraseña (ecr_password)',
                    hintText: 'izipay',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePass
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () =>
                          setState(() => _obscurePass = !_obscurePass),
                    ),
                  ),
                  validator: (v) => _required(v, 'Contraseña'),
                ),
                SizedBox(height: d.spacingL),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  value: _withBin,
                  onChanged: (v) => setState(() => _withBin = v),
                  title: const Text('Integración con BIN'),
                  subtitle: const Text(
                    'Cuando está activo, antes de cobrar el kiosco '
                    'solicita al pinpad el BIN de la tarjeta y luego '
                    'dispara la compra. Requerido si el pinpad tiene '
                    'la solicitud de BIN habilitada.',
                  ),
                ),
                SizedBox(height: d.spacingL),
                FilledButton.icon(
                  onPressed: _saving ? null : _save,
                  icon: _saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.save),
                  label: Text(_saving ? 'Guardando...' : 'Guardar'),
                ),
                SizedBox(height: d.spacingM),
                OutlinedButton.icon(
                  onPressed: _testing ? null : _test,
                  icon: _testing
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.wifi_tethering),
                  label: Text(_testing
                      ? 'Consultando pinpad...'
                      : 'Probar conexión'),
                ),
                SizedBox(height: d.spacingXL),
                const Divider(),
                SizedBox(height: d.spacingL),
                const IzipayOperationsPanel(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
