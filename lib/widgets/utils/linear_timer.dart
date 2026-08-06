import 'package:flutter/material.dart';
import 'package:ventas_kiosko/utils/helpers.dart';

class LinearTimer extends StatefulWidget {
  const LinearTimer({super.key, required this.timer});

  final int timer;

  @override
  State<LinearTimer> createState() => _LinearTimerState();
}

class _LinearTimerState extends State<LinearTimer> {
  int? _initialTimer;

  @override
  void initState() {
    super.initState();
    _initialTimer = widget.timer > 0 ? widget.timer : 1; // Evitar división por cero
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    // return Text('${_initialTimer.toString()} | ${widget.timer} | ${1 - (widget.timer / _initialTimer!)}');

    // Calcular el progreso de manera segura
    double progress = 0.0;
    if (_initialTimer! > 0 && widget.timer >= 0) {
      progress = (widget.timer / _initialTimer!).clamp(0.0, 1.0);
    }
    
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.black12,
      color: yellow,
      // color: cyan,
      minHeight: screenHeight * 0.01,
    );
  }
}
