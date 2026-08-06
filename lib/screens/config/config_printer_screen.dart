import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/printer/printer.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/providers/printer/printer_provider.dart';

class ConfigPrinterScreen extends ConsumerWidget {
  const ConfigPrinterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final printerState = ref.watch(printerManagerProvider);
    final d = ref.watch(appDimensionsProvider(context));

    return Padding(
      padding: d.paddingM,
      child: Column(
        children: [
          Expanded(
            child: printerState.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (devices) {
                if (devices.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('No printers found. Please connect a USB printer.'),
                        SizedBox(height: d.spacingM),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: const Text('Scan for Printers'),
                          onPressed: () => ref.read(printerManagerProvider.notifier).refreshDevices(),
                        ),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () => ref.read(printerManagerProvider.notifier).refreshDevices(),
                  child: ListView.separated(
                    itemCount: devices.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      return PrinterDeviceTile(device: device);
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: d.spacingM),
          ElevatedButton.icon(
            icon: const Icon(Icons.print),
            label: const Text('Print Test Page'),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, d.buttonHeight),
            ),
            onPressed: printerState.value?.any((d) => d.isConnected) ?? false
                ? () {
                    ref.read(printerManagerProvider.notifier).printTest('Test print from Kiosk App');
                  }
                : null,
          ),
        ],
      ),
    );
  }
}

class PrinterDeviceTile extends ConsumerWidget {
  const PrinterDeviceTile({super.key, required this.device});

  final PrinterDevice device;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // The 'isConnected' flag now represents the selected printer
    final isSelected = device.isConnected;

    return ListTile(
      title: Text(device.productName),
      subtitle: Text('VID: ${device.vendorId} - PID: ${device.productId}'),
      trailing: ElevatedButton(
        onPressed: () => ref.read(printerManagerProvider.notifier).selectDevice(device),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.green : null,
        ),
        child: Text(isSelected ? 'Selected' : 'Select'),
      ),
    );
  }
}
