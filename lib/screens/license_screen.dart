import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/config/license_provider.dart';
import 'package:ventas_kiosko/screens/home_screen.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';

class LicenseScreen extends ConsumerStatefulWidget {
  static const routeName = '/license';

  const LicenseScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LicenseScreenState();
}

class _LicenseScreenState extends ConsumerState<LicenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _licenseController = TextEditingController();
  final _deviceNameController = TextEditingController();
  final _licenseFocusNode = FocusNode();
  final _deviceNameFocusNode = FocusNode();

  bool _isLoading = false;
  bool _obscureLicense = true;

  @override
  void dispose() {
    _licenseController.dispose();
    _deviceNameController.dispose();
    _licenseFocusNode.dispose();
    _deviceNameFocusNode.dispose();
    super.dispose();
  }

  /// Activa la licencia usando el provider
  Future<void> _activateLicense() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final licenseKey = _licenseController.text.trim();
    final deviceName = _deviceNameController.text.trim();

    print('🔑 Iniciando activación de licencia...');
    print('📱 Licencia: ${licenseKey.substring(0, (licenseKey.length * 0.3).round())}...');
    print('🏷️ Dispositivo: $deviceName');

    try {
      // Llamar al método del provider (el device ID se genera automáticamente en el service)
      final response = await ref
          .read(licenseProvider.notifier)
          .activateLicense(licenseKey: licenseKey, deviceName: deviceName);

      print('📡 Respuesta del servidor: ${response.success ? "success" : response.errorMessage}');

      if (response.success) {
        print('✅ Licencia activada exitosamente');
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        _showSuccessDialog();
      } else {
        print('❌ Error en activación: ${response.errorMessage}');
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        _showErrorDialog(response.errorMessage ?? 'Error desconocido');
      }
    } catch (e) {
      print('💥 Excepción durante activación: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      _showErrorDialog('Error de conexión. Verifique su conexión a internet e intente nuevamente.');
    }
  }

  /// Navegación DIRECTA al HomeScreen
  void _showSuccessDialog() {
    print('🎉 Licencia activada exitosamente');

    if (!mounted) {
      return;
    }

    Navigator.of(context).pushNamedAndRemoveUntil(
      HomeScreen.routeName, // Usar la constante en lugar de string hardcodeado
      (route) => false, // Remover todas las rutas anteriores
    );
  }

  /// Muestra el diálogo de error con el mensaje específico
  void _showErrorDialog(String message) {
    print('❌ Mostrando diálogo de error: $message');

    if (!mounted) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        final d = ref.read(appDimensionsProvider(context));
        final colorScheme = Theme.of(context).colorScheme;

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(d.borderRadiusM)),
          title: Row(
            children: [
              Icon(Icons.error_outline, color: colorScheme.error, size: d.iconSizeL),
              SizedBox(width: d.spacingM),
              const Text('Error de Activación'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text(message)],
          ),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Entendido'))],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isTablet = d.screenWidth > d.screenHeight;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: d.horizontalPadding, vertical: d.verticalPadding),
            child: Container(
              width: d.screenWidth * 0.9,
              constraints: BoxConstraints(
                maxWidth: isTablet ? d.screenWidth * 0.6 : double.infinity,
                minWidth: d.screenWidth * 0.8,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header con logo y título
                    _buildHeader(d, colorScheme),

                    SizedBox(height: d.spacingL),

                    // Card principal del formulario
                    _buildFormCard(d, colorScheme),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppDimensions d, ColorScheme colorScheme) {
    final logoSize = d.imageSizeL;
    final iconSize = d.iconSizeL;

    return Column(
      children: [
        // Logo o icono principal
        Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: colorScheme.primary.withValues(alpha: 0.3), width: d.borderWidth),
          ),
          child: Icon(Icons.security, size: iconSize, color: colorScheme.primary),
        ),

        SizedBox(height: d.spacingM),

        // Título principal
        Text(
          'Activación de Licencia',
          style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: d.fontSizeTitle),
          textAlign: TextAlign.center,
        ),

        SizedBox(height: d.spacingS),

        // Subtítulo
        Text(
          'Ingrese los datos de su licencia para activar el dispositivo',
          style: TextStyle(color: colorScheme.onSurface.withValues(alpha: 0.7), fontSize: d.fontSizeBody),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFormCard(AppDimensions d, ColorScheme colorScheme) {
    return Card(
      elevation: d.blurRadius * 0.5,
      shadowColor: Color.fromRGBO(0, 0, 0, 0.3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(d.borderRadiusM)),
      child: Padding(
        padding: d.paddingM,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Campo de número de licencia
            _buildLicenseField(d, colorScheme),

            SizedBox(height: d.spacingM),

            // Campo de nombre del dispositivo
            _buildDeviceNameField(d, colorScheme),

            SizedBox(height: d.spacingL),

            // Botón de activar
            _buildActivateButton(d, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildLicenseField(AppDimensions d, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Número de Licencia',
          style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.w600, fontSize: d.fontSizeSubtitle),
        ),

        SizedBox(height: d.spacingS),

        TextFormField(
          controller: _licenseController,
          focusNode: _licenseFocusNode,
          obscureText: _obscureLicense,
          textInputAction: TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9-]')),
            LengthLimitingTextInputFormatter(50), // Longitud fija más generosa
          ],
          style: TextStyle(fontSize: d.fontSizeBody),
          decoration: InputDecoration(
            hintText: 'XXXXX-XXXXX-XXXXX-XXXXX',
            hintStyle: TextStyle(fontSize: d.fontSizeCaption),
            contentPadding: EdgeInsets.symmetric(horizontal: d.spacingM, vertical: d.spacingS),
            prefixIcon: Icon(Icons.vpn_key, color: colorScheme.primary, size: d.iconSizeM),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureLicense ? Icons.visibility : Icons.visibility_off,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              onPressed: () {
                setState(() {
                  _obscureLicense = !_obscureLicense;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(d.borderRadiusS),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(d.borderRadiusS),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(d.borderRadiusS),
              borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(d.borderRadiusS),
              borderSide: BorderSide(color: colorScheme.error, width: 2.0),
            ),
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Campo requerido';
            }
            if (value.trim().length < 10) {
              return 'Ingrese un número de licencia válido';
            }
            return null;
          },
          onFieldSubmitted: (_) {
            _deviceNameFocusNode.requestFocus();
          },
        ),
      ],
    );
  }

  Widget _buildDeviceNameField(AppDimensions d, ColorScheme colorScheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nombre del Dispositivo',
          style: TextStyle(color: colorScheme.onSurface, fontWeight: FontWeight.w600, fontSize: d.fontSizeSubtitle),
        ),

        SizedBox(height: d.spacingS),

        TextFormField(
          controller: _deviceNameController,
          focusNode: _deviceNameFocusNode,
          textInputAction: TextInputAction.done,
          textCapitalization: TextCapitalization.words,
          inputFormatters: [LengthLimitingTextInputFormatter(30)], // Longitud fija
          style: TextStyle(fontSize: d.fontSizeBody),
          decoration: InputDecoration(
            hintText: 'Ej. Quiosco 01',
            hintStyle: TextStyle(fontSize: d.fontSizeCaption),
            contentPadding: EdgeInsets.symmetric(horizontal: d.spacingM, vertical: d.spacingS),
            prefixIcon: Icon(Icons.devices, color: colorScheme.primary, size: d.iconSizeM),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(d.borderRadiusS),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(d.borderRadiusS),
              borderSide: BorderSide(color: colorScheme.outline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(d.borderRadiusS),
              borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(d.borderRadiusS),
              borderSide: BorderSide(color: colorScheme.error, width: 2.0),
            ),
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Campo requerido';
            }
            if (value.trim().length < 3) {
              return 'El nombre debe tener al menos 3 caracteres';
            }
            return null;
          },
          onFieldSubmitted: (_) {
            _activateLicense();
          },
        ),
      ],
    );
  }

  Widget _buildActivateButton(AppDimensions d, ColorScheme colorScheme) {
    return SizedBox(
      height: d.buttonHeight,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _activateLicense,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: d.blurRadius * 0.25,
          shadowColor: colorScheme.primary.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(d.borderRadiusS)),
          disabledBackgroundColor: colorScheme.primary.withValues(alpha: 0.6),
        ),
        child: _isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: d.iconSizeM,
                    height: d.iconSizeM,
                    child: CircularProgressIndicator(
                      strokeWidth: d.borderWidth * 2,
                      valueColor: AlwaysStoppedAnimation<Color>(colorScheme.onPrimary),
                    ),
                  ),
                  SizedBox(width: d.spacingM),
                  Text('Activando...', style: TextStyle(fontSize: d.fontSizeBody)),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_open, size: d.iconSizeM),
                  SizedBox(width: d.spacingS),
                  Text(
                    'Activar Licencia',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: d.fontSizeBody),
                  ),
                ],
              ),
      ),
    );
  }
}
