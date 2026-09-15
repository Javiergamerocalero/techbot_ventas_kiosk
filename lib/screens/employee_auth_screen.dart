import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/config/app_dimensions_provider.dart';
import '../providers/employee/employee_session_provider.dart';
import '../services/employee_validator_service.dart';
import '../styles/app_styles.dart';
import 'products_screen.dart';

/// Pantalla que le pide al empleado su DNI o Código antes de dejarlo
/// entrar al catálogo. Se muestra después del standby en la versión
/// San Fernando del kiosco.
///
/// Al validar contra el servicio de Contabo:
///   - `success:true`  → guarda el empleado en [employeeSessionProvider]
///                       y navega (pushReplacement) a [ProductsScreen].
///   - `success:false` → muestra el mensaje del backend y permite
///                       reintentar (o volver al standby con la flecha).
///   - error de red    → mensaje neutro + reintento.
class EmployeeAuthScreen extends ConsumerStatefulWidget {
  static const routeName = '/employee-auth';

  const EmployeeAuthScreen({super.key});

  @override
  ConsumerState<EmployeeAuthScreen> createState() => _EmployeeAuthScreenState();
}

class _EmployeeAuthScreenState extends ConsumerState<EmployeeAuthScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  EmployeeIdentifierType _type = EmployeeIdentifierType.dni;
  bool _submitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  int get _minLength => switch (_type) {
        EmployeeIdentifierType.dni => 8,
        EmployeeIdentifierType.employeeCode => 3,
      };

  int get _maxLength => switch (_type) {
        EmployeeIdentifierType.dni => 8,
        EmployeeIdentifierType.employeeCode => 32,
      };

  List<TextInputFormatter> get _formatters => switch (_type) {
        EmployeeIdentifierType.dni => [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(8),
          ],
        EmployeeIdentifierType.employeeCode => [
            LengthLimitingTextInputFormatter(32),
          ],
      };

  Future<void> _submit() async {
    final value = _controller.text.trim();
    if (value.length < _minLength) {
      setState(() {
        _errorMessage =
            'Ingrese al menos $_minLength ${_type == EmployeeIdentifierType.dni ? "dígitos" : "caracteres"}.';
      });
      return;
    }
    setState(() {
      _submitting = true;
      _errorMessage = null;
    });

    final service = ref.read(employeeValidatorServiceProvider);
    final result = await service.validate(type: _type, identifier: value);

    if (!mounted) return;
    setState(() => _submitting = false);

    switch (result.state) {
      case EmployeeValidationState.authorized:
        final employee = result.employee!;
        ref
            .read(employeeSessionProvider.notifier)
            .setEmployee(employee);
        // Feedback breve antes de entrar al catálogo.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bienvenido, ${employee.fullName}'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.of(context)
            .pushReplacementNamed(ProductsScreen.routeName);
      case EmployeeValidationState.notAuthorized:
      case EmployeeValidationState.error:
        setState(() => _errorMessage = result.message);
        _controller.clear();
        _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: d.iconSizeM),
          tooltip: 'Volver',
          onPressed: () {
            ref.read(employeeSessionProvider.notifier).clear();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: d.paddingL,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.badge_outlined,
                      size: d.iconSizeL * 2, color: cs.primary),
                  SizedBox(height: d.spacingL),
                  Text(
                    'Identifícate para comprar',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.title(d),
                  ),
                  SizedBox(height: d.spacingS),
                  Text(
                    'Ingresá tu DNI o Código de empleado. La compra '
                    'se registra a tu nombre.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: d.fontSizeBody,
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: d.spacingXL),
                  // Per Javier 2026-08-24: agrandar el toggle DNI/Código
                  // para que se lea con facilidad desde el kiosco.
                  //
                  // El relleno horizontal va en spacingM y no en spacingL:
                  // spacingL es 8% del ancho POR LADO, y sumado al ícono y
                  // a la letra agrandada los dos segmentos no entraban en
                  // pantalla, así que "Código" se partía letra por letra
                  // (reportado por Javier el 2026-09-15). Las etiquetas
                  // además tienen prohibido envolver.
                  SegmentedButton<EmployeeIdentifierType>(
                    style: SegmentedButton.styleFrom(
                      textStyle: TextStyle(
                        fontSize: d.fontSizeBody * 1.3,
                        fontWeight: FontWeight.w600,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: d.spacingM,
                        vertical: d.spacingM,
                      ),
                    ),
                    segments: [
                      ButtonSegment(
                        value: EmployeeIdentifierType.dni,
                        label: const Text('DNI', softWrap: false, maxLines: 1),
                        icon: Icon(Icons.badge, size: d.iconSizeM),
                      ),
                      ButtonSegment(
                        value: EmployeeIdentifierType.employeeCode,
                        label:
                            const Text('Código', softWrap: false, maxLines: 1),
                        icon: Icon(Icons.tag, size: d.iconSizeM),
                      ),
                    ],
                    selected: {_type},
                    onSelectionChanged: (v) => setState(() {
                      _type = v.first;
                      _controller.clear();
                      _errorMessage = null;
                      _focusNode.requestFocus();
                    }),
                  ),
                  SizedBox(height: d.spacingL),
                  TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    autofocus: true,
                    enabled: !_submitting,
                    onSubmitted: (_) => _submit(),
                    keyboardType: _type == EmployeeIdentifierType.dni
                        ? TextInputType.number
                        : TextInputType.text,
                    inputFormatters: _formatters,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: d.fontSizeTitle,
                      letterSpacing: 4,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                    decoration: InputDecoration(
                      hintText: _type == EmployeeIdentifierType.dni
                          ? '12345678'
                          : 'SF000001',
                      counterText: '',
                      border: const OutlineInputBorder(),
                      errorText: _errorMessage,
                    ),
                    maxLength: _maxLength,
                  ),
                  SizedBox(height: d.spacingL),
                  FilledButton.icon(
                    onPressed: _submitting ? null : _submit,
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: d.spacingL, vertical: d.spacingM),
                    ),
                    icon: _submitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child:
                                CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.arrow_forward),
                    label: Text(_submitting ? 'Validando...' : 'Continuar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
