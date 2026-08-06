import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:qr_flutter/qr_flutter.dart';

class PrinterService {
  static const _channel = MethodChannel('usb_printer_channel');

  Future<List<Map<String, dynamic>>> getDevices() async {
    final List<Object?>? devices = await _channel.invokeMethod('getUsbDevices');
    if (devices == null) return [];
    return devices.map((e) => Map<String, dynamic>.from(e as Map<Object?, Object?>)).toList();
  }

  Future<bool> connectToDevice(int vendorId, int productId) async {
    Map<String, dynamic> arguments = {"vendorId": vendorId, "productId": productId};
    try {
      await _channel.invokeMethod('connectToDevice', arguments);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> disconnectDevice() async {
    try {
      await _channel.invokeMethod('disconnectDevice');
    } catch (e) {
      print('Failed to disconnect device: $e');
    }
  }

  Future<void> sendData({
    required int vendorId,
    required int productId,
    required String text,
    String? qrData,
    bool partialCut = true,
  }) async {
    try {
      final bool isConnected = await connectToDevice(vendorId, productId);
      if (!isConnected) {
        throw Exception('Failed to connect to printer.');
      }

      List<int> printData = [];
      printData.addAll([0x1B, 0x40]); // ESC @ (Initialize printer)
      printData.addAll([0x18]); // CAN
      printData.addAll(utf8.encode(text));
      printData.addAll([0x0A]); // Line feed

      if (qrData != null) {
        printData.addAll([0x1B, 0x61, 0x01]); // Center alignment
        final qrBitmap = await _generateQrBitmap(qrData, 150);
        printData.addAll(qrBitmap);
        printData.addAll([0x0A]); // Line feed after QR
        printData.addAll([0x1B, 0x61, 0x00]); // Reset to left alignment
      }

      printData.addAll([0x0A, 0x0A, 0x0A, 0x0A]);

      if (partialCut) {
        printData.addAll([0x1D, 0x56, 0x01]); // Partial cut
      }

      final bytes = Uint8List.fromList(printData);
      await _channel.invokeMethod('sendData', {'data': bytes});
    } finally {
      await disconnectDevice();
    }
  }

  Future<Uint8List> _generateQrBitmap(
    String qrData,
    double size, {
    int printerWidthDots = 576,
    int luminanceThreshold = 128,
  }) async {
    if (size > printerWidthDots) {
      throw Exception('QR code size ($size) exceeds printer width ($printerWidthDots).');
    }

    final qrPainter = QrPainter(
      data: qrData,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.M,
      gapless: true,
    );

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, size, size));
    final paint = Paint()..color = const ui.Color(0xFFFFFFFF);
    canvas.drawRect(Rect.fromLTWH(0, 0, size, size), paint);
    qrPainter.paint(canvas, Size(size, size));
    final picture = recorder.endRecording();
    final uiImage = await picture.toImage(size.toInt(), size.toInt());

    final byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) {
      throw Exception('Failed to convert QR code image to byte data.');
    }
    final pngBytes = byteData.buffer.asUint8List();

    final image = img.decodePng(pngBytes)!;
    final grayscale = img.grayscale(image);
    final monochrome = img.Image(width: grayscale.width, height: grayscale.height);
    for (var y = 0; y < grayscale.height; y++) {
      for (var x = 0; x < grayscale.width; x++) {
        final pixel = grayscale.getPixel(x, y);
        final luminance = img.getLuminance(pixel);
        monochrome.setPixel(
          x,
          y,
          luminance < luminanceThreshold ? img.ColorRgb8(0, 0, 0) : img.ColorRgb8(255, 255, 255),
        );
      }
    }

    final imageWidthDots = monochrome.width;
    final imageHeightDots = monochrome.height;
    final imageWidthBytes = (imageWidthDots + 7) ~/ 8;
    final leftPaddingDots = ((printerWidthDots - imageWidthDots) / 2).floor().clamp(0, printerWidthDots);
    final leftPaddingBytes = (leftPaddingDots / 8).floor();
    final rowWidthBytes = leftPaddingBytes + imageWidthBytes;
    final bytes = <int>[];

    bytes.addAll([0x1D, 0x76, 0x30, 0x00]);
    bytes.addAll([rowWidthBytes & 0xFF, (rowWidthBytes >> 8) & 0xFF]);
    bytes.addAll([imageHeightDots & 0xFF, (imageHeightDots >> 8) & 0xFF]);

    for (var y = 0; y < imageHeightDots; y++) {
      for (var i = 0; i < leftPaddingBytes; i++) {
        bytes.add(0x00);
      }

      int byte = 0;
      int bitPos = 7;

      for (var x = 0; x < imageWidthDots; x++) {
        final pixel = monochrome.getPixel(x, y);
        final isBlack = img.getLuminance(pixel) == 0;

        if (isBlack) {
          byte |= (1 << bitPos);
        }

        bitPos--;

        if (bitPos < 0) {
          bytes.add(byte);
          byte = 0;
          bitPos = 7;
        }
      }

      if (bitPos != 7) {
        bytes.add(byte);
      }
    }

    return Uint8List.fromList(bytes);
  }
}
