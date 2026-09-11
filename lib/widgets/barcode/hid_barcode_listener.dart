import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Escucha keystrokes de un lector USB HID (modo teclado) y dispara
/// [onScan] cuando recibe un Enter.
///
/// Solo debe montarse antes de "Ir a pagar" (productos / detalle / carrito).
class HidBarcodeListener extends StatefulWidget {
  final Widget child;
  final ValueChanged<String> onScan;
  final bool autofocus;

  const HidBarcodeListener({
    super.key,
    required this.onScan,
    required this.child,
    this.autofocus = true,
  });

  @override
  State<HidBarcodeListener> createState() => _HidBarcodeListenerState();
}

class _HidBarcodeListenerState extends State<HidBarcodeListener> {
  final FocusNode _focus = FocusNode(
    skipTraversal: true,
    debugLabel: 'hidBarcodeListener',
  );
  final StringBuffer _buffer = StringBuffer();

  @override
  void initState() {
    super.initState();
    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focus.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final key = event.logicalKey;
    if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.numpadEnter) {
      final code = _buffer.toString().trim();
      _buffer.clear();
      if (code.isNotEmpty) {
        widget.onScan(code);
      }
      return KeyEventResult.handled;
    }
    final char = event.character;
    if (char != null && char.isNotEmpty) {
      _buffer.write(char);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focus,
      onKeyEvent: _onKey,
      child: widget.child,
    );
  }
}
