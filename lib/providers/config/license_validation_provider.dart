import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:ventas_kiosko/providers/config/license_provider.dart';

part 'license_validation_provider.g.dart';

@Riverpod(keepAlive: true)
class LicenseValidation extends _$LicenseValidation {
  @override
  Future<bool> build() async {
    final licenseData = await ref.watch(licenseProvider.future);
    return !ref.read(licenseProvider.notifier).isLicenseExpired(licenseData);
  }
}
