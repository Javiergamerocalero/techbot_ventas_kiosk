import 'dart:async' as async;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/providers/utils/timer_provider.dart';
import 'package:ventas_kiosko/utils/debug_session_log.dart';

/// Widget reusable que detecta actividad del usuario (touch, scroll, etc.)
/// y maneja el timer de inactividad automáticamente.
class InactivityDetector extends ConsumerStatefulWidget {
  final Widget child;
  final VoidCallback? onActivity;

  const InactivityDetector({
    super.key,
    required this.child,
    this.onActivity,
  });

  @override
  ConsumerState<InactivityDetector> createState() => _InactivityDetectorState();
}

class _InactivityDetectorState extends ConsumerState<InactivityDetector> {
  async.Timer? _restartTimer;

  @override
  void initState() {
    super.initState();
    // Iniciar el timer inmediatamente al montar el widget
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // #region agent log
      agentDebugLog(
        location: 'inactivity_detector.dart:initState',
        message: 'InactivityDetector mounted, forcing timer restart',
        hypothesisId: 'A',
        data: {
          'inactivityRunning': ref.read(inactivityTimerProvider),
          'timerValue': ref.read(timerProvider),
          'mainDuration': ref.read(mainDurationProvider),
        },
      );
      // #endregion
      _startInactivityTimer();
    });
  }

  @override
  void dispose() {
    _restartTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        // Cualquier desplazamiento detiene el timer inmediatamente
        _handleUserActivity();
        return false; // permitir que la notificación siga propagándose
      },
      child: Listener(
        onPointerDown: (_) => _handleUserActivity(), // Detectar taps
        onPointerSignal: (_) => _handleUserActivity(), // Scroll de rueda
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanStart: (_) => _handleUserActivity(),
          onPanUpdate: (_) => _handleUserActivity(),
          onTap: () => _handleUserActivity(), // Detectar taps también aquí
          child: widget.child,
        ),
      ),
    );
  }

  /// Maneja cualquier actividad del usuario - detiene el timer y programa reinicio
  void _handleUserActivity() {
    // Llamar callback personalizado si existe
    widget.onActivity?.call();
    
    // Detener timer inmediatamente
    ref.read(inactivityTimerProvider.notifier).onUserActivity();
    
    // Cancelar reinicio previo si existe
    _restartTimer?.cancel();
    
    // Programar reinicio del timer después de un breve delay
    _restartTimer = async.Timer(const Duration(milliseconds: 100), () {
      _startInactivityTimer();
    });
  }

  /// Inicia el timer de inactividad
  void _startInactivityTimer() {
    final mainDuration = ref.read(mainDurationProvider);
    ref.read(inactivityTimerProvider.notifier).startInactivityTimer(mainDuration);
  }
}
