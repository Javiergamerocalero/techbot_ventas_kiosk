import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_kiosko/providers/utils/loading_provider.dart';
import 'package:ventas_kiosko/services/niubiz_service.dart';
import 'package:ventas_kiosko/providers/printer/printer_provider.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/widgets/utils/custom_button.dart';
import 'package:ventas_kiosko/widgets/utils/custom_dropdown.dart';
import 'package:ventas_kiosko/widgets/utils/custom_textfield.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';

class ConfigNiubizLane3000Screen extends ConsumerStatefulWidget {
  static const routeName = '/config-niubiz-lane3000';

  const ConfigNiubizLane3000Screen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConfigNiubizLane3000ScreenState();
}

class _ConfigNiubizLane3000ScreenState extends ConsumerState<ConfigNiubizLane3000Screen> {
  final _ipPinpadController = TextEditingController();
  final _ipPinpadFocusNode = FocusNode();

  int? _reportType;

  @override
  void initState() {
    super.initState();
    _loadIpAddress();
  }

  @override
  void dispose() {
    _ipPinpadController.dispose();
    _ipPinpadFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadIpAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final ipAddress = prefs.getString('ipPinpad') ?? '';
    setState(() {
      _ipPinpadController.text = ipAddress;
    });
  }

  Future<void> _saveIpAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final currentIp = prefs.getString('ipPinpad') ?? '';
    final newIp = _ipPinpadController.text.trim();

    // If there's an existing IP and it's different, ask for confirmation
    if (currentIp.isNotEmpty && currentIp != newIp) {
      final confirmed = await _showConfirmationDialog(
        title: 'Confirmar cambio de IP',
        message: newIp.isEmpty
            ? '¿Está seguro que desea eliminar la IP del PinPad?\n\nIP actual: $currentIp'
            : '¿Está seguro que desea cambiar la IP del PinPad?\n\nIP actual: $currentIp\nNueva IP: $newIp',
      );

      if (confirmed != true) {
        return; // User cancelled
      }
    }

    // Save or delete the IP
    if (newIp.isEmpty) {
      await prefs.remove('ipPinpad');
    } else {
      await prefs.setString('ipPinpad', newIp);
    }

    if (!mounted) return;

    // Unfocus keyboard
    FocusScope.of(context).unfocus();

    // Show success message
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text(
          newIp.isEmpty ? 'Dirección IP eliminada correctamente' : 'Dirección IP guardada correctamente',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog({required String title, required String message}) {
    final d = ref.read(appDimensionsProvider(context));

    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Cancelar',
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  dimensions: d,
                  variant: ButtonVariant.neutral,
                  isOutlined: true,
                  isFullWidth: true,
                ),
              ),
              SizedBox(width: d.spacingM),
              Expanded(
                child: CustomButton(
                  text: 'Confirmar',
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  dimensions: d,
                  variant: ButtonVariant.primary,
                  isFullWidth: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Button handler methods
  Future<void> _handleDuplicateProcess() async {
    ref.read(loadingProvider.notifier).update((state) => true);

    final niubizService = NiubizService();
    final response = await niubizService.duplicateProcess();

    ref.read(loadingProvider.notifier).update((state) => false);

    if (response is Exception) {
      await _showResultDialog(response.toString().replaceAll('Exception: ', ''), title: 'Error', enablePrinting: false);
    } else {
      await _showResultDialog(response.toString());
    }
  }

  Future<void> _handleCancelProcess() async {
    ref.read(loadingProvider.notifier).update((state) => true);

    final niubizService = NiubizService();
    final response = await niubizService.cancelProcess();

    ref.read(loadingProvider.notifier).update((state) => false);

    if (response is Exception) {
      await _showResultDialog(response.toString().replaceAll('Exception: ', ''), title: 'Error', enablePrinting: false);
    } else {
      await _showResultDialog(response.toString());
    }
  }

  Future<void> _handlePrintReport() async {
    ref.read(loadingProvider.notifier).update((state) => true);

    print(_reportType);
    final niubizService = NiubizService();
    final response = await niubizService.printReport(_reportType!);
    print(response);

    ref.read(loadingProvider.notifier).update((state) => false);

    if (response is Exception) {
      await _showResultDialog(response.toString().replaceAll('Exception: ', ''), title: 'Error', enablePrinting: false);
    } else {
      await _showResultDialog(response.toString());
    }
  }

  Future<void> _handleBatchProcess() async {
    ref.read(loadingProvider.notifier).update((state) => true);

    final niubizService = NiubizService();
    final response = await niubizService.batchProcess();

    ref.read(loadingProvider.notifier).update((state) => false);

    if (response is Exception) {
      await _showResultDialog(response.toString().replaceAll('Exception: ', ''), title: 'Error', enablePrinting: false);
    } else {
      await _showResultDialog(response.toString());
    }
  }

  Future<void> _handleListTerminals() async {
    ref.read(loadingProvider.notifier).update((state) => true);

    final niubizService = NiubizService();
    final response = await niubizService.listTerminals();

    ref.read(loadingProvider.notifier).update((state) => false);

    if (response is Exception) {
      await _showResultDialog(response.toString().replaceAll('Exception: ', ''), title: 'Error', enablePrinting: false);
    } else {
      await _showResultDialog(response.toString(), enablePrinting: false);
    }
  }

  Future<void> _handleEchoTerminal() async {
    ref.read(loadingProvider.notifier).update((state) => true);

    final niubizService = NiubizService();
    final response = await niubizService.echoTerminal();

    ref.read(loadingProvider.notifier).update((state) => false);

    if (response is Exception) {
      await _showResultDialog(response.toString().replaceAll('Exception: ', ''), title: 'Error', enablePrinting: false);
    } else {
      await _showResultDialog(response.toString(), enablePrinting: false);
    }
  }

  Future<void> _handleInitTerminal() async {
    ref.read(loadingProvider.notifier).update((state) => true);

    final niubizService = NiubizService();
    final response = await niubizService.initTerminal();

    ref.read(loadingProvider.notifier).update((state) => false);

    if (response is Exception) {
      await _showResultDialog(response.toString().replaceAll('Exception: ', ''), title: 'Error', enablePrinting: false);
    } else {
      await _showResultDialog(response.toString());
    }
  }

  void _handleSetParamsPinPad() {
    NiubizService().setParamsPinPad();
  }

  // Helper to get the print report callback - returns no-op if no report type selected
  void _handlePrintReportIfSelected() {
    if (_reportType != null) {
      _handlePrintReport();
    }
  }

  Future<bool?> _showResultDialog(String data, {String? title, bool enablePrinting = true}) {
    final d = ref.read(appDimensionsProvider(context));

    // Unfocus keyboard to prevent it from reopening when dialog is dismissed
    FocusScope.of(context).unfocus();

    void handlePrint() {
      _printData(data)
          .then((_) {
            if (!mounted) return;
            Navigator.of(context).pop(true);
          })
          .catchError((error) {
            // Error already handled in _printData
            if (mounted) {
              Navigator.of(context).pop(false);
            }
          });
    }

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: title != null ? Text(title) : null,
        content: Padding(padding: d.paddingS, child: Text(data)),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          if (enablePrinting)
            CustomButton(
              text: 'Cancelar',
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              dimensions: d,
              variant: ButtonVariant.neutral,
              isOutlined: true,
              widthFactor: 0.3,
            ),
          if (enablePrinting)
            CustomButton(
              text: 'Imprimir',
              onPressed: handlePrint,
              dimensions: d,
              variant: ButtonVariant.primary,
              widthFactor: 0.3,
            ),
          if (!enablePrinting)
            CustomButton(
              text: 'Ok',
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              dimensions: d,
              variant: ButtonVariant.primary,
              widthFactor: 0.3,
            ),
        ],
      ),
    );
  }

  Future<void> _printData(String data) async {
    try {
      print('🖨️ Starting print job...');

      // Use the provider's print method
      await ref.read(printerManagerProvider.notifier).print(
        data,
        partialCut: true,
      );

      print('✅ Print successful');
    } catch (e) {
      print('❌ Print error: $e');
      // Show error to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al imprimir: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
      rethrow; // Re-throw so the dialog can handle it if needed
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
            title: Text('Configurar Niubiz/Lane3000', style: AppTextStyles.title(d).copyWith(color: colorScheme.onSurface)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, size: d.iconSizeM),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Padding(
            padding: d.paddingM,
            child: GestureDetector(
              onTap: () {
                // Unfocus keyboard when tapping outside text field
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ////////// Configuración de PinPad //////////
                    Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Configuración de PinPad:',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.subtitle(d).copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: d.spacingL),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: _ipPinpadController,
                        focusNode: _ipPinpadFocusNode,
                        labelText: 'Dirección IP del PinPad',
                        hintText: 'Ej: 192.168.1.100',
                        dimensions: d,
                        keyboardType: TextInputType.text,
                        unfocusOnTap: true,
                        prefixIcon: Icon(Icons.router, size: d.iconSizeM),
                      ),
                    ),
                    SizedBox(width: d.spacingM),
                    Container(
                      height: d.buttonHeight,
                      width: d.buttonHeight,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(d.borderRadiusS),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.save, color: colorScheme.onPrimary, size: d.iconSizeM),
                        onPressed: _saveIpAddress,
                        tooltip: 'Guardar IP',
                      ),
                    ),
                  ],
                ),

                ////////// Divider //////////
                Divider(height: d.spacingXL),

                ////////// Pagos //////////
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pagos:',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.subtitle(d).copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: d.spacingM),
                ////////// Button Reimpresión //////////
                CustomButton(
                  text: 'Reimpresión',
                  onPressed: _handleDuplicateProcess,
                  dimensions: d,
                  variant: ButtonVariant.primary,
                  widthFactor: 0.5,
                ),
                SizedBox(height: d.spacingM),
                ////////// Button Anular Pago //////////
                CustomButton(
                  text: 'Anular Pago',
                  onPressed: _handleCancelProcess,
                  dimensions: d,
                  variant: ButtonVariant.primary,
                  widthFactor: 0.5,
                ),
                ////////// Reportes //////////
                Divider(height: d.spacingXL),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Reportes:',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.subtitle(d).copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: d.spacingL),
                CustomDropdownMenu<int>(
                  initialSelection: _reportType,
                  items: const [0, 1, 2, 3, 4],
                  onSelected: (value) {
                    setState(() {
                      _reportType = value;
                    });
                  },
                  labelText: 'Tipo de Reporte',
                  dimensions: d,
                  width: d.screenWidth * 0.75,
                  itemLabel: (int value) {
                    switch (value) {
                      case 0:
                        return 'Reporte Detallado';
                      case 1:
                        return 'Reporte Totales';
                      case 2:
                        return 'Transacciones POS servicios';
                      case 3:
                        return 'Impr. Parámetros generales';
                      case 4:
                        return 'Params. Configuración EMV';
                      default:
                        return '';
                    }
                  },
                ),
                SizedBox(height: d.spacingM),
                ////////// Button Imprimir Reportes //////////
                CustomButton(
                  text: 'Imprimir Reportes',
                  onPressed: _handlePrintReportIfSelected,
                  dimensions: d,
                  variant: ButtonVariant.primary,
                  widthFactor: 0.5,
                ),
                ////////// Cierre de Lote //////////
                Divider(height: d.spacingXL),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Lote:',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.subtitle(d).copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: d.spacingM),
                ////////// Button Cierre de Lote //////////
                CustomButton(
                  text: 'Cierre de Lote',
                  onPressed: _handleBatchProcess,
                  dimensions: d,
                  variant: ButtonVariant.primary,
                  widthFactor: 0.5,
                ),
                ////////// Operaciones de Terminal //////////
                Divider(height: d.spacingXL),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Operaciones de Terminal:',
                    textAlign: TextAlign.start,
                    style: AppTextStyles.subtitle(d).copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: d.spacingL),
                ////////// Button Listar Terminales //////////
                CustomButton(
                  text: 'Listar Terminales',
                  onPressed: _handleListTerminals,
                  dimensions: d,
                  variant: ButtonVariant.primary,
                  widthFactor: 0.5,
                ),
                SizedBox(height: d.spacingM),
                ////////// Button Echo //////////
                CustomButton(
                  text: 'Echo',
                  onPressed: _handleEchoTerminal,
                  dimensions: d,
                  variant: ButtonVariant.primary,
                  widthFactor: 0.5,
                ),
                SizedBox(height: d.spacingM),
                ////////// Button Inicializar //////////
                CustomButton(
                  text: 'Inicializar',
                  onPressed: _handleInitTerminal,
                  dimensions: d,
                  variant: ButtonVariant.primary,
                  widthFactor: 0.5,
                ),
                SizedBox(height: d.spacingL),

                ////////// Set paramsPinPad manually //////////
                CustomButton(
                  text: 'Set paramsPinPad',
                  onPressed: _handleSetParamsPinPad,
                  dimensions: d,
                  variant: ButtonVariant.neutral,
                  widthFactor: 0.5,
                ),
                SizedBox(height: d.spacingL),
              ],
            ),
          ),
        ))),
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
}
