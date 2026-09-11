import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/utils/timer_provider.dart';
import '../providers/config/license_provider.dart';
import '../providers/cart/cart_provider.dart';
import '../models/cart/cart.dart';
import '../screens/time_up_screen.dart';
import '../widgets/utils/linear_timer.dart';
import '../widgets/utils/inactivity_detector.dart';
import '../styles/app_styles.dart';
import '../providers/config/app_dimensions_provider.dart';
import '../models/config/invoice_type.dart';
import '../services/dni_ruc_validation_service.dart';
import '../widgets/invoice/invoice_type_card.dart';
import '../widgets/invoice/invoice_type_with_inputs.dart';
import '../widgets/invoice/invoice_selection_header.dart';
import '../models/config/payment_method.dart';
import '../helpers/payment_navigation_helper.dart';

class InvoiceSelectionScreen extends ConsumerStatefulWidget {
  static const routeName = '/invoice-selection';
  const InvoiceSelectionScreen({super.key});

  @override
  ConsumerState<InvoiceSelectionScreen> createState() =>
      _InvoiceSelectionScreenState();
}

class _InvoiceSelectionScreenState
    extends ConsumerState<InvoiceSelectionScreen> {
  InvoiceType? _selectedType;
  
  // Controllers para los inputs
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _rucController = TextEditingController();
  
  // Focus nodes para controlar el teclado
  final FocusNode _dniFocusNode = FocusNode();
  final FocusNode _rucFocusNode = FocusNode();
  
  // Estado de validación
  bool _isValidating = false;
  bool _isValidated = false;
  String? _validationError;
  
  // Datos validados
  String _dniFullName = '';
  String _razonSocial = '';
  String _direccion = '';
  
  // Últimos valores validados para evitar validaciones duplicadas
  String _lastValidatedDni = '';
  String _lastValidatedRuc = '';
  
  DniRucValidationService? _validationService;

  @override
  void initState() {
    super.initState();
    // Listeners para validación automática
    _dniController.addListener(_onDniChanged);
    _rucController.addListener(_onRucChanged);
    
    // Listeners para reiniciar timer al escribir
    _dniController.addListener(_resetTimerOnInput);
    _rucController.addListener(_resetTimerOnInput);
    
    // Inicializar servicio de validación y logging
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Log payment method received (only once)
      final selectedPaymentMethod = ModalRoute.of(context)?.settings.arguments as PaymentMethod?;
      if (selectedPaymentMethod == null) {
        print('⚠️ No se recibió método de pago');
      } else {
        print('💳 Método de pago recibido: ${selectedPaymentMethod.type.displayName}');
      }

      // Initialize validation service
      final config = ref.read(licenseProvider.notifier).currentConfiguration;
      final apiKey = config?.apisNetPeKey;
      if (apiKey != null && apiKey.isNotEmpty) {
        _validationService = DniRucValidationService(apisNetPeToken: apiKey);
        print('✅ Servicio de validación inicializado');
      } else {
        print('⚠️ No se encontró API key para validación');
      }
    });
  }

  @override
  void dispose() {
    _dniController.dispose();
    _rucController.dispose();
    _dniFocusNode.dispose();
    _rucFocusNode.dispose();
    super.dispose();
  }

  void _resetTimerOnInput() {
    if (mounted) {
      final mainDuration = ref.read(mainDurationProvider);
      ref.read(inactivityTimerProvider.notifier).startInactivityTimer(mainDuration);
    }
  }

  void _closeKeyboard() {
    // Cerrar teclado removiendo el foco de todos los inputs
    _dniFocusNode.unfocus();
    _rucFocusNode.unfocus();
    FocusScope.of(context).unfocus();
  }

  void _onDniChanged() {
    final currentDni = _dniController.text;
    
    if (_selectedType == InvoiceType.boletaWithDNI && currentDni.length == 8) {
      // Solo validar si el DNI cambió y no es el último validado
      if (currentDni != _lastValidatedDni) {
        _validateDni();
      }
    } else if (currentDni.length != 8) {
      setState(() {
        _isValidated = false;
        _validationError = null;
        _dniFullName = '';
        _lastValidatedDni = ''; 
      });
    }
  }

  void _onRucChanged() {
    final currentRuc = _rucController.text;
    
    if (_selectedType == InvoiceType.facturaElectronica && currentRuc.length == 11) {
      // Solo validar si el RUC cambió y no es el último validado
      if (currentRuc != _lastValidatedRuc) {
        _validateRuc();
      }
    } else if (currentRuc.length != 11) {
      setState(() {
        _isValidated = false;
        _validationError = null;
        _razonSocial = '';
        _direccion = '';
        _lastValidatedRuc = ''; 
      });
    }
  }

  Future<void> _validateDni() async {
    if (_validationService == null) {
      setState(() {
        _validationError = 'Servicio de validación no disponible';
      });
      return;
    }

    // Cerrar teclado y bloquear input durante validación
    _closeKeyboard();
    
    setState(() {
      _isValidating = true;
      _validationError = null;
    });

    try {
      final result = await _validationService!.validateDni(_dniController.text);
      if (mounted) {
        setState(() {
          _isValidating = false;
          _isValidated = result.isValid;
          _dniFullName = result.fullName;
          _lastValidatedDni = _dniController.text; // Guardar como último validado
          print('✅ DNI validado: ${result.fullName}');
        });
      }
    } on DniValidationException catch (e) {
      if (mounted) {
        // Si es timeout (408), limpiar el input
        if (e.statusCode == 408) {
          _dniController.clear();
          print('⏱️ Timeout en validación DNI - Input limpiado');
        }
        
        setState(() {
          _isValidating = false;
          _isValidated = false;
          _validationError = e.message;
          print('❌ Error validando DNI: ${e.message} (Status: ${e.statusCode})');
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isValidating = false;
          _isValidated = false;
          _validationError = 'Error al validar DNI';
          print('❌ Error inesperado: $e');
        });
      }
    }
  }

  Future<void> _validateRuc() async {
    if (_validationService == null) {
      setState(() {
        _validationError = 'Servicio de validación no disponible';
      });
      return;
    }
    _closeKeyboard();
    
    setState(() {
      _isValidating = true;
      _validationError = null;
    });

    try {
      final result = await _validationService!.validateRuc(_rucController.text);
      if (mounted) {
        setState(() {
          _isValidating = false;
          _isValidated = result.isValid;
          _razonSocial = result.razonSocial;
          _direccion = result.direccion;
          _lastValidatedRuc = _rucController.text; // Guardar como último validado
          print('✅ RUC validado: ${result.razonSocial}');
        });
      }
    } on RucValidationException catch (e) {
      if (mounted) {
        // Si es timeout (408), limpiar el input
        if (e.statusCode == 408) {
          _rucController.clear();
          print('⏱️ Timeout en validación RUC - Input limpiado');
        }
        
        setState(() {
          _isValidating = false;
          _isValidated = false;
          _validationError = e.message;
          print('❌ Error validando RUC: ${e.message} (Status: ${e.statusCode})');
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isValidating = false;
          _isValidated = false;
          _validationError = 'Error al validar RUC';
          print('❌ Error inesperado: $e');
        });
      }
    }
  }

  bool _isFormValid() {
    if (_selectedType == null) return false;

    switch (_selectedType!) {
      case InvoiceType.simpleBoleta:
        return true;

      case InvoiceType.boletaWithDNI:
        return _dniController.text.length == 8 && _isValidated;

      case InvoiceType.facturaElectronica:
        return _rucController.text.length == 11 && _isValidated;
    }
  }

  void _clearInputs() {
    _dniController.clear();
    _rucController.clear();
    _isValidated = false;
    _validationError = null;
    _dniFullName = '';
    _razonSocial = '';
    _direccion = '';
    _lastValidatedDni = '';
    _lastValidatedRuc = '';
  }
  
  void _changeInvoiceType() {
    setState(() {
      _selectedType = null;
      _clearInputs();
    });
  }
  
  IconData _getIconForType(InvoiceType type) {
    switch (type) {
      case InvoiceType.simpleBoleta:
        return Icons.receipt;
      case InvoiceType.boletaWithDNI:
        return Icons.badge;
      case InvoiceType.facturaElectronica:
        return Icons.business;
    }
  }

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final colorScheme = Theme.of(context).colorScheme;
    final timer = ref.watch(timerProvider);

    // Recibir método de pago seleccionado (sin logging para evitar spam en rebuilds)
    final selectedPaymentMethod = ModalRoute.of(context)?.settings.arguments as PaymentMethod?;

    handleTimer(context, ref, timer);

    return Scaffold(
      body: InactivityDetector(
        child: Stack(
          children: [
            Column(
              children: [
                InvoiceSelectionHeader(
                  d: d,
                  colorScheme: colorScheme,
                  onBack: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(d.horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título de sección
                        Text(
                          '¿Desea algún tipo de comprobante?',
                          style: AppTextStyles.subtitle(d).copyWith(
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: d.spacingS),
                        // Solo mostrar descripción si no hay tipo seleccionado
                        if (_selectedType == null)
                          Text(
                            'Seleccione el tipo de comprobante',
                            style: AppTextStyles.body(d).copyWith(
                              color: colorScheme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        SizedBox(height: d.spacingL),

                        // Mostrar todos los tipos o solo el seleccionado
                        if (_selectedType == null) ...[
                          // Mostrar todos los tipos disponibles
                          InvoiceTypeCard(
                            d: d,
                            colorScheme: colorScheme,
                            type: InvoiceType.simpleBoleta,
                            icon: Icons.receipt,
                            onTap: () => _selectInvoiceType(InvoiceType.simpleBoleta),
                          ),
                          SizedBox(height: d.spacingM),
                          InvoiceTypeCard(
                            d: d,
                            colorScheme: colorScheme,
                            type: InvoiceType.boletaWithDNI,
                            icon: Icons.badge,
                            onTap: () => _selectInvoiceType(InvoiceType.boletaWithDNI),
                          ),
                          SizedBox(height: d.spacingM),
                          InvoiceTypeCard(
                            d: d,
                            colorScheme: colorScheme,
                            type: InvoiceType.facturaElectronica,
                            icon: Icons.business,
                            onTap: () => _selectInvoiceType(InvoiceType.facturaElectronica),
                          ),
                        ] else ...[
                          // Mostrar solo el tipo seleccionado con inputs
                          InvoiceTypeWithInputs(
                            d: d,
                            colorScheme: colorScheme,
                            type: _selectedType!,
                            icon: _getIconForType(_selectedType!),
                            dniController: _selectedType == InvoiceType.boletaWithDNI ? _dniController : null,
                            rucController: _selectedType == InvoiceType.facturaElectronica ? _rucController : null,
                            dniFocusNode: _selectedType == InvoiceType.boletaWithDNI ? _dniFocusNode : null,
                            rucFocusNode: _selectedType == InvoiceType.facturaElectronica ? _rucFocusNode : null,
                            isValidating: _isValidating,
                            isValidated: _isValidated,
                            validationError: _validationError,
                            dniFullName: _dniFullName,
                            razonSocial: _razonSocial,
                            direccion: _direccion,
                          ),
                          SizedBox(height: d.spacingM),
                          // Botón para cambiar tipo de comprobante
                          OutlinedButton.icon(
                            onPressed: _changeInvoiceType,
                            icon: Icon(Icons.swap_horiz, size: d.iconSizeM),
                            label: Text(
                              'Seleccionar otro tipo de comprobante',
                              style: AppTextStyles.body(d),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: d.spacingL,
                                vertical: d.spacingM,
                              ),
                              side: BorderSide(color: colorScheme.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(d.borderRadiusM),
                              ),
                            ),
                          ),
                        ],
                        SizedBox(height: d.spacingL),

                        // Botón de continuar
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isFormValid()
                                  ? colorScheme.primary
                                  : colorScheme.onSurface.withValues(alpha: 0.3),
                              padding: EdgeInsets.symmetric(vertical: d.spacingM),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(d.borderRadiusL),
                              ),
                            ),
                            onPressed: _isFormValid()
                                ? () async {
                                    final invoiceData = InvoiceData(
                                      type: _selectedType!,
                                      dni: _dniController.text,
                                      dniFullName: _dniFullName,
                                      ruc: _rucController.text,
                                      razonSocial: _razonSocial,
                                      direccion: _direccion,
                                      isValidated: _isValidated,
                                    );
                                    
                                    print('📄 Tipo de comprobante seleccionado: ${_selectedType!.displayName}');
                                    print('📄 Datos: $invoiceData');

                                    // Obtener monto total del carrito
                                    final cart = ref.read(cartNotifierProvider);
                                    final totalAmount = cart.computedTotalPrice;
                                    
                                    print('💰 Monto total del carrito: \$${totalAmount.toStringAsFixed(2)}');

                                    // Validar que tenemos método de pago
                                    if (selectedPaymentMethod == null) {
                                      print('❌ Error: No se encontró método de pago seleccionado');
                                      return;
                                    }

                                    // Usar PaymentNavigationHelper para navegación condicional
                                    await PaymentNavigationHelper.navigateToPaymentScreen(
                                      context: context,
                                      paymentMethod: selectedPaymentMethod,
                                      invoiceData: invoiceData.toJson(),
                                      amount: totalAmount,
                                    );
                                  }
                                : null,
                            child: Text(
                              _isFormValid()
                                  ? 'Proceder con el pago'
                                  : _selectedType == null
                                      ? 'Seleccione un tipo de comprobante'
                                      : 'Complete los datos requeridos',
                              style: AppTextStyles.button(d).copyWith(
                                color: _isFormValid()
                                    ? colorScheme.onPrimary
                                    : colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: d.spacingXL),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            LinearTimer(timer: timer),
          ],
        ),
      ),
    );
  }

  void _selectInvoiceType(InvoiceType type) {
    setState(() {
      _selectedType = type;
      _clearInputs();
    });
    print('📄 Tipo seleccionado: ${type.displayName}');
  }

  Future<void> handleTimer(
      BuildContext context, WidgetRef ref, int timer) async {
    if (timer == 0) {
      if (ModalRoute.of(context)?.isCurrent ?? false) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref
              .read(timerProvider.notifier)
              .start(ref.read(secondaryDurationProvider));
          Navigator.pushNamed(context, TimeUpScreen.routeName);
        });
      }
    }
  }
}
