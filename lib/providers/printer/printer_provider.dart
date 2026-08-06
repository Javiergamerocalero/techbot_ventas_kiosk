import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventas_kiosko/models/printer/printer.dart';
import 'package:ventas_kiosko/services/printer_service.dart';

part 'printer_provider.g.dart';

// A key for storing the selected printer's info in SharedPreferences
const _selectedPrinterVendorIdKey = 'selected_printer_vendor_id';
const _selectedPrinterProductIdKey = 'selected_printer_product_id';

@Riverpod(keepAlive: true)
class PrinterManager extends _$PrinterManager {
  final PrinterService _printerService = PrinterService();

  @override
  Future<List<PrinterDevice>> build() async {
    return _fetchDevicesAndApplySelection();
  }

  Future<List<PrinterDevice>> _fetchDevicesAndApplySelection() async {
    final prefs = await SharedPreferences.getInstance();
    final savedVendorId = prefs.getInt(_selectedPrinterVendorIdKey);
    final savedProductId = prefs.getInt(_selectedPrinterProductIdKey);

    final devices = await _printerService.getDevices();

    return devices.map((device) {
      final isSelected = device['vendorId'] == savedVendorId && device['productId'] == savedProductId;
      return PrinterDevice(
        vendorId: device['vendorId'],
        productId: device['productId'],
        productName: device['productName'],
        isConnected: isSelected, // Use isConnected to represent selection
      );
    }).toList();
  }

  Future<void> selectDevice(PrinterDevice device) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_selectedPrinterVendorIdKey, device.vendorId);
    await prefs.setInt(_selectedPrinterProductIdKey, device.productId);

    // Re-fetch and apply the new selection to update the state
    state = await AsyncValue.guard(() => _fetchDevicesAndApplySelection());
  }

  Future<void> printTest(String text) async {
    // Wait for async build() to complete if still loading
    final devices = await future;

    final selectedDevice = devices.firstWhere(
      (d) => d.isConnected,
      orElse: () => throw Exception('No selected printer found'),
    );

    await _printerService.sendData(
      vendorId: selectedDevice.vendorId,
      productId: selectedDevice.productId,
      text: text,
    );
  }

  /// Generic print method with configurable options
  Future<void> print(String text, {bool partialCut = false}) async {
    // Wait for async build() to complete if still loading
    final devices = await future;

    final selectedDevice = devices.firstWhere(
      (d) => d.isConnected,
      orElse: () => throw Exception('No hay impresora seleccionada'),
    );

    await _printerService.sendData(
      vendorId: selectedDevice.vendorId,
      productId: selectedDevice.productId,
      text: text,
      partialCut: partialCut,
    );
  }

  Future<void> refreshDevices() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchDevicesAndApplySelection());
  }
}
