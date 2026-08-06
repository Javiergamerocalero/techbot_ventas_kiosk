// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'license_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$licenseServiceHash() => r'0247e6bd107b56cb674d3b3fbd50017d834738af';

/// Provider para el servicio de licencias
///
/// Copied from [licenseService].
@ProviderFor(licenseService)
final licenseServiceProvider = Provider<LicenseService>.internal(
  licenseService,
  name: r'licenseServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$licenseServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LicenseServiceRef = ProviderRef<LicenseService>;
String _$licenseHash() => r'f619ccc11f569e7fc909d455507b1dc7b5e14b91';

/// See also [License].
@ProviderFor(License)
final licenseProvider = AsyncNotifierProvider<License, LicenseData>.internal(
  License.new,
  name: r'licenseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$licenseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$License = AsyncNotifier<LicenseData>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
