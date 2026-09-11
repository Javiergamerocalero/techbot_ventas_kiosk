import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/widgets/barcode/barcode_scan_handler.dart';
import 'package:ventas_kiosko/widgets/barcode/hid_barcode_listener.dart';

/// Activa el lector HID solo en el flujo pre-pago.
class PrePaymentBarcodeScope extends ConsumerWidget {
  final Widget child;

  const PrePaymentBarcodeScope({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return HidBarcodeListener(
      onScan: (code) => BarcodeScanHandler.handle(context, ref, code),
      child: child,
    );
  }
}
