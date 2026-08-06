// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$remoteConfigServiceHash() =>
    r'db4c2be99d66e9a16beac78973ddc2273c0ca834';

/// Provider para acceder al servicio de configuración
///
/// Copied from [remoteConfigService].
@ProviderFor(remoteConfigService)
final remoteConfigServiceProvider =
    AutoDisposeProvider<RemoteConfigService>.internal(
      remoteConfigService,
      name: r'remoteConfigServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$remoteConfigServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RemoteConfigServiceRef = AutoDisposeProviderRef<RemoteConfigService>;
String _$appThemeNotifierHash() => r'8f623b731e7152a26f8d48238b316bf3f394ae40';

/// See also [AppThemeNotifier].
@ProviderFor(AppThemeNotifier)
final appThemeNotifierProvider =
    AsyncNotifierProvider<AppThemeNotifier, ThemeData>.internal(
      AppThemeNotifier.new,
      name: r'appThemeNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$appThemeNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AppThemeNotifier = AsyncNotifier<ThemeData>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
