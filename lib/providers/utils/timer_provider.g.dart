// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$timerHash() => r'3944b9e06ec1a08769918ca5912b40841e48c181';

/// See also [Timer].
@ProviderFor(Timer)
final timerProvider = NotifierProvider<Timer, int>.internal(
  Timer.new,
  name: r'timerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$timerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Timer = Notifier<int>;
String _$inactivityTimerHash() => r'a12592dfe4efe0b488a8d872947e4adfac3bf659';

/// See also [InactivityTimer].
@ProviderFor(InactivityTimer)
final inactivityTimerProvider =
    NotifierProvider<InactivityTimer, bool>.internal(
      InactivityTimer.new,
      name: r'inactivityTimerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$inactivityTimerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$InactivityTimer = Notifier<bool>;
String _$timerConfigHash() => r'44049a430cef85e42ef2549c64e90a18f89be6d1';

/// See also [TimerConfig].
@ProviderFor(TimerConfig)
final timerConfigProvider =
    AsyncNotifierProvider<TimerConfig, TimerConfigState>.internal(
      TimerConfig.new,
      name: r'timerConfigProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$timerConfigHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TimerConfig = AsyncNotifier<TimerConfigState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
