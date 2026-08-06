import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:ventas_kiosko/providers/utils/loading_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/utils/custom_button.dart';
import 'package:ventas_kiosko/widgets/utils/custom_textfield.dart';

class ConfigCashdroScreen extends ConsumerStatefulWidget {
  static const routeName = '/config-cashdro';

  const ConfigCashdroScreen({super.key});

  @override
  ConsumerState<ConfigCashdroScreen> createState() => _ConfigCashdroScreenState();
}

class _ConfigCashdroScreenState extends ConsumerState<ConfigCashdroScreen> {
  // Controllers para los campos de texto
  final _ipAddressController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _timeoutController = TextEditingController();

  // Focus nodes
  final _ipAddressFocusNode = FocusNode();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _timeoutFocusNode = FocusNode();

  // Estado de campos
  bool _obscureUsername = true;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _ipAddressController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _timeoutController.dispose();
    _ipAddressFocusNode.dispose();
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _timeoutFocusNode.dispose();
    super.dispose();
  }

  /// Carga los datos guardados desde SharedPreferences
  Future<void> _loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      setState(() {
        _ipAddressController.text = prefs.getString('cashdro_ip_address') ?? '';
        _usernameController.text = prefs.getString('cashdro_username') ?? '';
        _passwordController.text = prefs.getString('cashdro_password') ?? '';
        _timeoutController.text = (prefs.getInt('cashdro_timeout_seconds') ?? 30).toString();
      });
      
      print('✅ Configuración CashDro cargada');
    } catch (e) {
      print('❌ Error cargando configuración CashDro: $e');
    }
  }

  /// Guarda los datos en SharedPreferences
  Future<void> _saveData() async {
    ref.read(loadingProvider.notifier).state = true;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.setString('cashdro_ip_address', _ipAddressController.text.trim());
      await prefs.setString('cashdro_username', _usernameController.text.trim());
      await prefs.setString('cashdro_password', _passwordController.text);
      
      // Guardar timeout (validar que sea un número válido)
      final timeoutText = _timeoutController.text.trim();
      final timeoutValue = int.tryParse(timeoutText) ?? 30;
      await prefs.setInt('cashdro_timeout_seconds', timeoutValue);
      
      print('✅ Configuración CashDro guardada:');
      print('   IP: ${_ipAddressController.text.trim()}');
      print('   Usuario: ${_usernameController.text.trim()}');
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: Text(
            'Configuración de CashDro guardada correctamente',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('❌ Error guardando configuración CashDro: $e');
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(
            'Error al guardar la configuración',
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } finally {
      ref.read(loadingProvider.notifier).state = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final isLoading = ref.watch(loadingProvider);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: colorScheme.surfaceContainerLowest,
          appBar: AppBar(
            backgroundColor: colorScheme.surface,
            foregroundColor: colorScheme.onSurface,
            title: Text(
              'Configurar CashDro S',
              style: AppTextStyles.title(d).copyWith(color: colorScheme.onSurface),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, size: d.iconSizeM),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Padding(
            padding: d.paddingM,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título de sección
                  _buildSectionTitle('Configuración de CashDro S', d, colorScheme),
                  SizedBox(height: d.spacingS),
                  
                  // Descripción
                  Text(
                    'Ingrese los parámetros de conexión ...',
                    style: AppTextStyles.body(d).copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  SizedBox(height: d.spacingL),

                  // Campo: Dirección IP
                  CustomTextField(
                    controller: _ipAddressController,
                    focusNode: _ipAddressFocusNode,
                    labelText: 'Dirección IP',
                    hintText: 'Ej: 192.168.1.100',
                    dimensions: d,
                    keyboardType: TextInputType.number,
                    prefixIcon: Icon(Icons.router, size: d.iconSizeM),
                  ),
                  SizedBox(height: d.spacingM),

                  // Campo: Usuario
                  CustomTextField(
                    controller: _usernameController,
                    focusNode: _usernameFocusNode,
                    labelText: 'Usuario',
                    hintText: 'Nombre de usuario',
                    dimensions: d,
                    obscureText: _obscureUsername,
                    prefixIcon: Icon(Icons.person_outline, size: d.iconSizeM),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureUsername ? Icons.visibility_off : Icons.visibility,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                        size: d.iconSizeM,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureUsername = !_obscureUsername;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: d.spacingM),

                  // Campo: Contraseña
                  CustomTextField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    labelText: 'Contraseña',
                    hintText: 'Contraseña de acceso',
                    dimensions: d,
                    obscureText: _obscurePassword,
                    prefixIcon: Icon(Icons.lock_outline, size: d.iconSizeM),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off : Icons.visibility,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                        size: d.iconSizeM,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: d.spacingM),

                  // Campo: Tiempo de espera
                  CustomTextField(
                    controller: _timeoutController,
                    focusNode: _timeoutFocusNode,
                    labelText: 'Tiempo de espera (segundos)',
                    hintText: 'Ej: 30',
                    dimensions: d,
                    keyboardType: TextInputType.number,
                    prefixIcon: Icon(Icons.timer_outlined, size: d.iconSizeM),
                  ),
                  SizedBox(height: d.spacingL),

                  // Información de ayuda
                  Container(
                    padding: d.paddingM,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(d.borderRadiusM),
                      border: Border.all(
                        color: colorScheme.primary.withValues(alpha: 0.3),
                        width: d.borderWidth,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: d.iconSizeM,
                          color: colorScheme.primary,
                        ),
                        SizedBox(width: d.spacingS),
                        Expanded(
                          child: Text(
                            'Estos datos serán utilizados para conectarse al dispositivo CashDro S. El tiempo de espera determina cuántos segundos se mostrará la interfaz antes de continuar automáticamente.',
                            style: AppTextStyles.caption(d).copyWith(
                              color: colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: d.spacingL),

                  // Botón Guardar
                  CustomButton(
                    text: isLoading ? 'Guardando...' : 'Guardar',
                    onPressed: isLoading
                        ? () {} // Disabled state
                        : () {
                            FocusScope.of(context).unfocus();
                            _saveData();
                          },
                    dimensions: d,
                    variant: ButtonVariant.primary,
                    icon: isLoading ? null : Icon(Icons.save, size: d.iconSizeM),
                  ),
                ],
              ),
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

  /// Construye un título de sección consistente
  Widget _buildSectionTitle(String title, AppDimensions d, ColorScheme colorScheme) {
    return Text(
      title,
      textAlign: TextAlign.start,
      style: AppTextStyles.subtitle(d).copyWith(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
