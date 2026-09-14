import 'dart:async' as async;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'timer_provider.g.dart';

@Riverpod(keepAlive: true)
class Timer extends _$Timer {
  @override
  int build() => 0;

  async.StreamSubscription? _subscription;

  void start(int seconds) {
    _subscription?.cancel();

    state = seconds;

    _subscription = async.Stream.periodic(const Duration(seconds: 1), (x) => x).listen((_) {
      if (state > 0) {
        state--;
      } else {
        _subscription?.cancel();
      }
    });
  }

  void stop() {
    _subscription?.cancel();
  }

  void reset() {
    _subscription?.cancel();
    state = 0;
  }
}

@Riverpod(keepAlive: true)
class InactivityTimer extends _$InactivityTimer {
  @override
  bool build() => false; // false = activo, true = timer principal corriendo

  /// Detecta actividad del usuario - detiene el timer inmediatamente
  void onUserActivity() {
    // Detener el timer principal inmediatamente
    ref.read(timerProvider.notifier).stop();
    
    // Marcar como activo (usuario interactuando)
    state = false;
  }

  /// Inicia (o reinicia) el timer principal de inactividad.
  ///
  /// Siempre vuelve a arrancar: si no se reinicia al montar una
  /// pantalla nueva, el kiosco hereda un timer ya en 0 (p.ej. después
  /// de DNI) y dispara TimeUp al instante.
  void startInactivityTimer(int mainDuration) {
    state = true;
    ref.read(timerProvider.notifier).start(mainDuration);
  }

  /// Detiene completamente el sistema de inactividad
  void stopInactivity() {
    ref.read(timerProvider.notifier).stop();
    state = false;
  }
}

@Riverpod(keepAlive: true)
class TimerConfig extends _$TimerConfig {
  @override
  Future<TimerConfigState> build() async {
    final prefs = await SharedPreferences.getInstance();
    final mainDuration = prefs.getInt('mainDuration') ?? 30;
    final secondaryDuration = prefs.getInt('secondaryDuration') ?? 10;

    return TimerConfigState(main: mainDuration, secondary: secondaryDuration);
  }

   void updateDurations({int? mainDuration, int? secondaryDuration}) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Obtener valores actuales de forma segura
    final currentState = state.value;
    final currentMain = currentState?.main ?? 30;
    final currentSecondary = currentState?.secondary ?? 10;

    if (mainDuration != null) {
      prefs.setInt('mainDuration', mainDuration);
      state = AsyncData(TimerConfigState(main: mainDuration, secondary: currentSecondary));
    }

    if (secondaryDuration != null) {
      prefs.setInt('secondaryDuration', secondaryDuration);
      state = AsyncData(TimerConfigState(main: currentMain, secondary: secondaryDuration));
    }
  }
}

class TimerConfigState {
  final int main;
  final int secondary;

   TimerConfigState({required this.main, required this.secondary});
}

final mainDurationProvider = Provider<int>((ref) {
  final timerConfig = ref.watch(timerConfigProvider);
  return timerConfig.value?.main ?? 30;
});

final secondaryDurationProvider = Provider<int>((ref) {
  final timerConfig = ref.watch(timerConfigProvider);
  return timerConfig.value?.secondary ?? 10;
});
