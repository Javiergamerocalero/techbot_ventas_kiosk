// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_warning_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$stockWarningHash() => r'c27b4dbe1bca6ee51ac9aa290a0284b436864d05';

/// Notifier para controlar el modal de stock insuficiente
///
/// Copied from [StockWarning].
@ProviderFor(StockWarning)
final stockWarningProvider =
    NotifierProvider<StockWarning, Set<String>>.internal(
      StockWarning.new,
      name: r'stockWarningProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$stockWarningHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$StockWarning = Notifier<Set<String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
