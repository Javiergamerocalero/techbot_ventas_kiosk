import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ventas_kiosko/providers/config/license_provider.dart';
import 'package:ventas_kiosko/providers/products/master_data_provider.dart';
import 'package:ventas_kiosko/providers/combos/combo_provider.dart';
import 'package:ventas_kiosko/providers/images/image_preloader_provider.dart';

part 'products_sync_provider.g.dart';

@Riverpod(keepAlive: true)
class ProductsSync extends _$ProductsSync {
  static const String _kLastRefreshKey = 'last_products_refresh_at_ms';

  bool _isRefreshing = false;
  Completer<bool>? _inflight;

  @override
  Future<void> build() async {}

  Future<DateTime?> getLastRefreshAt() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ms = prefs.getInt(_kLastRefreshKey);
      if (ms == null) return null;
      return DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true).toUtc();
    } catch (e) {
      print('⚠️ ProductsSync: Error leyendo última actualización: $e');
      return null;
    }
  }

  Future<void> markRefreshedNow() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final nowMs = DateTime.now().toUtc().millisecondsSinceEpoch;
      await prefs.setInt(_kLastRefreshKey, nowMs);
      print('🕒 ProductsSync: Marcada última actualización en ${DateTime.now().toUtc()}');
    } catch (e) {
      print('⚠️ ProductsSync: Error marcando última actualización: $e');
    }
  }

  Future<bool> ensureFreshData({Duration maxAge = const Duration(hours: 1), bool force = false}) async {
    if (_isRefreshing && _inflight != null) {
      print('⏳ ProductsSync: Refresh en progreso, esperando...');
      try {
        return await _inflight!.future;
      } catch (_) {
        return false;
      }
    }

    _isRefreshing = true;
    final completer = Completer<bool>();
    _inflight = completer;

    try {
      final last = await getLastRefreshAt();
      final now = DateTime.now().toUtc();
      final needsRefresh = force || last == null || now.difference(last) >= maxAge;

      if (!needsRefresh) {
        print('ℹ️ ProductsSync: Datos vigentes (<= ${maxAge.inMinutes} min), no se refresca. Última: $last');
        completer.complete(false);
        return false;
      }

      try {
        final tenantId = ref.read(licenseProvider.notifier).requireTenantId();
        print('🏢 ProductsSync: tenantId=$tenantId');
      } catch (e) {
        print('⚠️ ProductsSync: Tenant ID no disponible, abortando refresh: $e');
        completer.complete(false);
        return false;
      }

      print('🔄 ProductsSync: Iniciando refresh de masterData y combos');

      ref.invalidate(masterDataProvider);
      final categoriesFuture = ref.read(masterDataProvider.future);

      ref.invalidate(allCombosProvider);
      final combosFuture = ref.read(allCombosProvider.future);

      final categories = await categoriesFuture;
      final combos = await combosFuture;

      print('✅ ProductsSync: masterData=${categories.length} categorías, combos=${combos.length}');

      try {
        final allProducts = await ref.read(allProductsProvider.future);
        unawaited(ref.read(imagePreloaderProvider.notifier).preloadProductImages(allProducts));
        unawaited(ref.read(imagePreloaderProvider.notifier).preloadComboImages(combos));
      } catch (e) {
        print('⚠️ ProductsSync: Error preloading images: $e');
      }

      await markRefreshedNow();
      print('✅ ProductsSync: Refresh completado y timestamp guardado');
      completer.complete(true);
      return true;
    } catch (e) {
      print('💥 ProductsSync: Error durante refresh: $e');
      if (!completer.isCompleted) completer.complete(false);
      return false;
    } finally {
      _isRefreshing = false;
      _inflight = null;
    }
  }
}
