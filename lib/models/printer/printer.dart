import 'package:freezed_annotation/freezed_annotation.dart';

part 'printer.freezed.dart';
part 'printer.g.dart';

@freezed
abstract class PrinterDevice with _$PrinterDevice {
  const factory PrinterDevice({
    required int vendorId,
    required int productId,
    required String productName,
    @Default(false) bool isConnected,
  }) = _PrinterDevice;

  factory PrinterDevice.fromJson(Map<String, dynamic> json) => _$PrinterDeviceFromJson(json);
}
