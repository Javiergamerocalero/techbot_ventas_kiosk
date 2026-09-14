import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:ventas_kiosko/providers/config/license_provider.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/models/config/app_dimensions.dart';
import 'package:ventas_kiosko/providers/utils/timer_provider.dart';
import 'package:ventas_kiosko/styles/app_styles.dart';
import 'package:ventas_kiosko/widgets/utils/custom_button.dart';
import 'package:ventas_kiosko/widgets/utils/custom_textfield.dart';
import 'package:ventas_kiosko/providers/images/image_cache_provider.dart';
import 'package:ventas_kiosko/providers/products/master_data_provider.dart';
import 'package:ventas_kiosko/providers/utils/products_sync_provider.dart';
import 'package:ventas_kiosko/providers/combos/combo_provider.dart';
import 'package:ventas_kiosko/providers/images/image_preloader_provider.dart';
import 'package:ventas_kiosko/providers/products/products_provider.dart';
import 'package:ventas_kiosko/widgets/config/update_options_dialog.dart';
import 'package:ventas_kiosko/providers/config/invoice_settings_provider.dart';
import 'package:ventas_kiosko/utils/product_catalog.dart';

class ConfigGlobalsScreen extends ConsumerStatefulWidget {
  const ConfigGlobalsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConfigGlobalsScreenState();
}

class _ConfigGlobalsScreenState extends ConsumerState<ConfigGlobalsScreen> {
  static const String _kStandbyVideoPathKey = 'standby_video_path';

  late int _licenseId;

  final _nombreQuioscoController = TextEditingController();
  final _nombreQuioscoFocusNode = FocusNode();
  bool _isRefreshing = false;
  String? _standbyVideoPath;

  Future<void> _pickStandbyVideo() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
      );
      if (result == null || result.files.isEmpty) return;
      final src = result.files.single.path;
      if (src == null || src.isEmpty) return;

      // Copiar a app private storage — el path original del picker
      // puede quedar inaccesible después (permisos scoped storage).
      final dir = await getApplicationDocumentsDirectory();
      final ext = src.contains('.') ? src.substring(src.lastIndexOf('.')) : '.mp4';
      final destPath = '${dir.path}/standby_video$ext';
      final destFile = File(destPath);
      if (destFile.existsSync()) {
        await destFile.delete();
      }
      await File(src).copy(destPath);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kStandbyVideoPathKey, destPath);

      if (!mounted) return;
      setState(() => _standbyVideoPath = destPath);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: Text(
            'Video de standby guardado.',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(
            'No se pudo cargar el video: $e',
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  Future<void> _removeStandbyVideo() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(_kStandbyVideoPathKey);
    if (path != null && path.isNotEmpty) {
      try {
        final f = File(path);
        if (f.existsSync()) await f.delete();
      } catch (_) {}
    }
    await prefs.remove(_kStandbyVideoPathKey);
    if (!mounted) return;
    setState(() => _standbyVideoPath = null);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text(
          'Video eliminado. Volverá el carrusel de imágenes.',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          textAlign: TextAlign.center,
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
  bool _showAllSkus = ProductCatalog.showAllSkus;

  Future<void> _refreshThemeOnly() async {
    try {
      setState(() => _isRefreshing = true);
      final licenseResponse = await ref.read(licenseProvider.notifier).refreshFromServer();
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      if (licenseResponse.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: Text(
              'Tema y licencia actualizados correctamente!',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              textAlign: TextAlign.center,
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.error,
            content: Text(
              licenseResponse.errorMessage ?? 'Error al actualizar tema/licencia',
              style: TextStyle(color: Theme.of(context).colorScheme.onError),
              textAlign: TextAlign.center,
            ),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(
            'Error al actualizar tema/licencia: $e',
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) setState(() => _isRefreshing = false);
    }
  }

  Future<void> _refreshProductsOnly() async {
    try {
      setState(() => _isRefreshing = true);

      // 1) Limpiar caché de imágenes (disco y memoria)
      final imageCacheService = ref.read(imageCacheServiceProvider);
      await imageCacheService.clearCache();
      try {
        PaintingBinding.instance.imageCache.clear();
        PaintingBinding.instance.imageCache.clearLiveImages();
      } catch (_) {}

      // 2) Invalidar y recargar datos de productos (categorías/subcategorías/productos)
      ref.invalidate(masterDataProvider);
      await ref.read(masterDataProvider.future);

      // 3) Invalidar y recargar combos
      ref.invalidate(allCombosProvider);
      final combos = await ref.read(allCombosProvider.future);

      // 4) Limpiar overrides locales de stock
      ref.read(productStockMapProvider.notifier).state = {};

      // 5) Precargar imágenes (productos y combos)
      try {
        final allProducts = await ref.read(allProductsProvider.future);
        await ref.read(imagePreloaderProvider.notifier).preloadProductImages(allProducts);
        await ref.read(imagePreloaderProvider.notifier).preloadComboImages(combos);
      } catch (_) {}

      // 6) Marcar timestamp de última actualización
      try {
        await ref.read(productsSyncProvider.notifier).markRefreshedNow();
      } catch (_) {}

      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: Text(
            'Productos actualizados correctamente!',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.error,
          content: Text(
            'Error al actualizar productos: $e',
            style: TextStyle(color: Theme.of(context).colorScheme.onError),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      if (mounted) setState(() => _isRefreshing = false);
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nombreQuiosco', _nombreQuioscoController.text);

    ref
        .read(licenseProvider.notifier)
        .updateServerLicenseData(licenseId: _licenseId, deviceName: _nombreQuioscoController.text);

    if (!mounted) return;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        content: Text(
          'Información guardada correctamente!',
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          textAlign: TextAlign.center,
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _licenseId = ref.read(licenseProvider).value!.id;
      _nombreQuioscoController.text = prefs.getString('nombreQuiosco') ?? '';
      _standbyVideoPath = prefs.getString(_kStandbyVideoPathKey);
    });
  }

  Future<void> _launchDownloadApp() async {
    // Get the download link.
    final downloadLink = ref.read(licenseProvider).value?.downloadLink ?? '';

    // Check for empty/invalid string
    if (downloadLink.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: Text(
            'Enlace de descarga inválido o vacío.',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 3),
        ),
      );
      return; // Stop the function execution
    }

    // Parse the URI
    final Uri uri = Uri.parse(downloadLink);

    // Attempt to launch the valid URI
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final d = ref.watch(appDimensionsProvider(context));
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final appVersion = ref.watch(licenseProvider).value!.appVersion;
    final mainTime = ref.watch(mainDurationProvider);
    final secondaryTime = ref.watch(secondaryDurationProvider);
    final invoiceSuspended = ref.watch(electronicInvoiceSuspendedProvider);

    return Stack(
      children: [
        Padding(
          padding: d.paddingM,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            /////////////// Información del Dispositivo ///////////////
            _buildSectionTitle('Información del Dispositivo:', d, colorScheme),
            SizedBox(height: d.spacingM),
            CustomTextField(
              controller: _nombreQuioscoController,
              focusNode: _nombreQuioscoFocusNode,
              labelText: 'Nombre del Quiosco',
              dimensions: d,
            ),
            SizedBox(height: d.spacingL),
            CustomButton(
              text: 'Guardar Información',
              onPressed: () {
                FocusScope.of(context).unfocus();
                _saveData();
              },
              dimensions: d,
              variant: ButtonVariant.primary,
            ),
            _buildDivider(d),

            /////////////// Temporizador ///////////////
            _buildSectionTitle('Temporizador:', d, colorScheme),
            SizedBox(height: d.spacingS),
            _buildTimerCard(mainTime: mainTime, secondaryTime: secondaryTime, d: d, colorScheme: colorScheme),

            /////////////// Facturación Electrónica ///////////////
            _buildDivider(d),
            _buildSectionTitle('Facturación Electrónica:', d, colorScheme),
            SizedBox(height: d.spacingS),
            _buildInvoiceSuspendCard(suspended: invoiceSuspended, d: d, colorScheme: colorScheme),

            /////////////// Video de Standby ///////////////
            _buildDivider(d),
            _buildSectionTitle('Video de Standby:', d, colorScheme),
            SizedBox(height: d.spacingS),
            _buildStandbyVideoCard(d: d, colorScheme: colorScheme),
            /////////////// Catálogo ///////////////
            _buildDivider(d),
            _buildSectionTitle('Catálogo:', d, colorScheme),
            SizedBox(height: d.spacingS),
            _buildCatalogFilterCard(d: d, colorScheme: colorScheme),

            /////////////// Aplicación ///////////////
            _buildDivider(d),
            _buildSectionTitle('Aplicación ($appVersion):', d, colorScheme),
            SizedBox(height: d.spacingL),

            /////////////// Botón Actualizar Aplicación ///////////////
            CustomButton(
              text: 'Actualización',
              onPressed: () async {
                if (_isRefreshing) return;
                FocusScope.of(context).unfocus();
                await showUpdateOptionsDialog(
                  context: context,
                  dimensions: d,
                  onUpdateApp: _launchDownloadApp,
                  onUpdateTheme: _refreshThemeOnly,
                  onUpdateProducts: _refreshProductsOnly,
                );
              },
              dimensions: d,
              variant: ButtonVariant.primary,
            ),

            /////////////// Botón Cerrar Aplicación ///////////////
            SizedBox(height: d.spacingL),
            CustomButton(
              text: 'Cerrar Aplicación',
              onPressed: () async {
                SystemNavigator.pop();
              },
              dimensions: d,
              variant: ButtonVariant.neutral,
              isOutlined: true,
            ),
          ],
            ),
          ),
        ),
        if (_isRefreshing)
          Positioned.fill(
            child: Container(
              color: colorScheme.scrim.withValues(alpha: 0.5),
              child: Center(
                child: SizedBox(
                  width: d.iconSizeL * 1.4,
                  height: d.iconSizeL * 1.4,
                  child: CircularProgressIndicator(
                    strokeWidth: d.borderWidth * 3,
                    color: colorScheme.primary,
                  ),
                ),
              ),
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
      style: AppTextStyles.subtitle(d).copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.bold),
    );
  }

  /// Construye un divisor consistente
  Widget _buildDivider(AppDimensions d) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: d.spacingL),
      child: Divider(color: Colors.black12),
    );
  }

  /// Tarjeta para elegir/quitar el video local que se reproduce en el
  /// standby en lugar del carrusel de imágenes. Per Javier 2026-08-24.
  Widget _buildStandbyVideoCard({
    required AppDimensions d,
    required ColorScheme colorScheme,
  }) {
    final hasVideo = _standbyVideoPath != null && _standbyVideoPath!.isNotEmpty;
    final fileName = hasVideo
        ? _standbyVideoPath!.split(RegExp(r'[/\\]')).last
        : null;
    return Card(
      color: colorScheme.surfaceContainerLowest,
      elevation: d.blurRadius * 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(d.borderRadiusM)),
      child: Padding(
        padding: d.paddingM,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  hasVideo ? Icons.movie : Icons.movie_outlined,
                  color: hasVideo ? colorScheme.primary : colorScheme.onSurfaceVariant,
                  size: d.iconSizeM,
                ),
                SizedBox(width: d.spacingS),
                Expanded(
                  child: Text(
                    hasVideo ? 'Video actual: $fileName' : 'Sin video (se usa el carrusel).',
                    style: AppTextStyles.body(d).copyWith(
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: d.spacingM),
            Text(
              'MP4 en loop, sin audio. Se copia al almacenamiento privado de la app.',
              style: AppTextStyles.caption(d).copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: d.spacingM),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: hasVideo ? 'Cambiar video' : 'Elegir video',
                    onPressed: _pickStandbyVideo,
                    dimensions: d,
                    variant: ButtonVariant.primary,
                  ),
                ),
                if (hasVideo) ...[
                  SizedBox(width: d.spacingM),
                  Expanded(
                    child: CustomButton(
                      text: 'Quitar',
                      onPressed: _removeStandbyVideo,
                      dimensions: d,
                      variant: ButtonVariant.neutral,
                      isOutlined: true,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Construye la tarjeta con el switch para suspender la facturación electrónica
  Widget _buildInvoiceSuspendCard({
    required bool suspended,
    required AppDimensions d,
    required ColorScheme colorScheme,
  }) {
    return Card(
      color: colorScheme.surfaceContainerLowest,
      elevation: d.blurRadius * 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(d.borderRadiusM)),
      child: SwitchListTile(
        value: suspended,
        contentPadding: d.paddingS,
        title: Text(
          'Suspender facturación electrónica',
          style: AppTextStyles.body(d).copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          'El kiosko solo imprimirá el comprobante, sin enviarlo a TechFact.',
          style: AppTextStyles.caption(d).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7)),
        ),
        onChanged: (value) {
          ref.read(invoiceSettingsProvider.notifier).setSuspended(value);
        },
      ),
    );
  }

  /// Switch del filtro de catálogo. Por defecto el kiosco solo lista
  /// los SKUs con prefijo `PUB`; apagarlo muestra todo el catálogo del
  /// tenant, que es lo que hace falta mientras se marcan los productos
  /// en Qapp. Los productos sin prefijo siempre se pueden agregar
  /// escaneando su código de barras.
  Widget _buildCatalogFilterCard({
    required AppDimensions d,
    required ColorScheme colorScheme,
  }) {
    return Card(
      color: colorScheme.surfaceContainerLowest,
      elevation: d.blurRadius * 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(d.borderRadiusM)),
      child: SwitchListTile(
        value: _showAllSkus,
        contentPadding: d.paddingS,
        title: Text(
          'Mostrar todos los productos',
          style: AppTextStyles.body(d).copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          _showAllSkus
              ? 'Se lista todo el catálogo del tenant, con prefijo PUB o sin él.'
              : 'Solo se listan los productos con prefijo PUB en el SKU. El resto se agrega escaneando.',
          style: AppTextStyles.caption(d).copyWith(color: colorScheme.onSurface.withValues(alpha: 0.7)),
        ),
        onChanged: _isRefreshing
            ? null
            : (value) async {
                await ProductCatalog.setShowAllSkus(value);
                if (!mounted) return;
                setState(() => _showAllSkus = value);
                // El filtro se aplica dentro de los providers, así que
                // hay que recalcularlos para que el menú cambie.
                ref.invalidate(masterDataProvider);
                ref.invalidate(allProductsProvider);
              },
      ),
    );
  }

  /// Construye la tarjeta del temporizador
  Widget _buildTimerCard({
    required int mainTime,
    required int secondaryTime,
    required AppDimensions d,
    required ColorScheme colorScheme,
  }) {
    return Card(
      color: colorScheme.surfaceContainerLowest,
      elevation: d.blurRadius * 0.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(d.borderRadiusM)),
      child: Padding(
        padding: d.paddingS,
        child: Column(
          children: [
            _buildTimerRow(
              label: 'Principal',
              value: mainTime,
              onDecrement: () {
                ref
                    .read(timerConfigProvider.notifier)
                    .updateDurations(mainDuration: (ref.read(mainDurationProvider) - 10).clamp(10, 300));
              },
              onIncrement: () {
                ref
                    .read(timerConfigProvider.notifier)
                    .updateDurations(mainDuration: (ref.read(mainDurationProvider) + 10).clamp(10, 300));
              },
              d: d,
              colorScheme: colorScheme,
            ),
            Divider(color: colorScheme.outline.withValues(alpha: 0.3)),
            _buildTimerRow(
              label: 'Secundario',
              value: secondaryTime,
              onDecrement: () {
                ref
                    .read(timerConfigProvider.notifier)
                    .updateDurations(secondaryDuration: (secondaryTime - 10).clamp(10, 300).toInt());
              },
              onIncrement: () {
                ref
                    .read(timerConfigProvider.notifier)
                    .updateDurations(secondaryDuration: (secondaryTime + 10).clamp(10, 300).toInt());
              },
              d: d,
              colorScheme: colorScheme,
            ),
          ],
        ),
      ),
    );
  }

  /// Construye una fila del temporizador
  Widget _buildTimerRow({
    required String label,
    required int value,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
    required AppDimensions d,
    required ColorScheme colorScheme,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.body(d).copyWith(color: colorScheme.onSurface)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onDecrement,
              icon: Icon(Icons.remove, color: colorScheme.primary, size: d.iconSizeM),
            ),
            Container(
              alignment: Alignment.center,
              width: d.screenWidth * 0.12,
              child: Text(
                '$value s',
                style: AppTextStyles.body(d).copyWith(color: colorScheme.onSurface, fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              onPressed: onIncrement,
              icon: Icon(Icons.add, color: colorScheme.primary, size: d.iconSizeM),
            ),
          ],
        ),
      ],
    );
  }
}
