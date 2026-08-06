// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashdro_payment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cashdroPaymentServiceHash() =>
    r'4e6ca8f4d7bd5292ac5c95c4ed4743163bd13fa1';

/// Provider del servicio CashDro
///
/// Copied from [cashdroPaymentService].
@ProviderFor(cashdroPaymentService)
final cashdroPaymentServiceProvider =
    AutoDisposeProvider<CashDroPaymentService>.internal(
      cashdroPaymentService,
      name: r'cashdroPaymentServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cashdroPaymentServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CashdroPaymentServiceRef =
    AutoDisposeProviderRef<CashDroPaymentService>;
String _$cashdroPaymentNotifierHash() =>
    r'06c71bd4020ed8ed171a866a5ea4d2bc10dc0870';

/// Provider del estado de la transacción CashDro
///
/// Copied from [CashdroPaymentNotifier].
@ProviderFor(CashdroPaymentNotifier)
final cashdroPaymentNotifierProvider =
    NotifierProvider<CashdroPaymentNotifier, CashDroTransaction>.internal(
      CashdroPaymentNotifier.new,
      name: r'cashdroPaymentNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cashdroPaymentNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CashdroPaymentNotifier = Notifier<CashDroTransaction>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
