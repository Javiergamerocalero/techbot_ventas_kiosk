/// Convierte el `print_data` que devuelve el PinPad Izipay (formato
/// binario con prefijos de fuente) a texto plano imprimible línea a
/// línea. El spec (sección 6) define:
///
///  - Cada línea empieza con un byte de formato (0x41 fuente normal,
///    0x42 doble, 0x43/0x44 invertidos) y termina con 0x0D.
///  - Líneas en blanco: bytes `32 1B 20 0D`.
///  - Líneas con imagen: `0x32 0x1C 0xZZ 0x0D` — para impresión
///    térmica simple las ignoramos.
///
/// Este parser saca todos los prefijos de formato y devuelve el
/// texto plano — suficiente para una impresora térmica básica que no
/// distingue fuentes.
class IzipayVoucherFormatter {
  static String toPlainText(String printData) {
    final lines = <String>[];
    final buffer = StringBuffer();
    var expectingFormatPrefix = true;

    for (final rune in printData.runes) {
      if (rune == 0x0D || rune == 0x0A) {
        lines.add(buffer.toString());
        buffer.clear();
        expectingFormatPrefix = true;
        continue;
      }
      if (expectingFormatPrefix &&
          (rune == 0x41 || rune == 0x42 || rune == 0x43 || rune == 0x44)) {
        expectingFormatPrefix = false;
        continue;
      }
      if (rune == 0x1B || rune == 0x1D || rune == 0x1C) {
        expectingFormatPrefix = false;
        continue;
      }
      expectingFormatPrefix = false;
      buffer.write(String.fromCharCode(rune));
    }
    if (buffer.isNotEmpty) lines.add(buffer.toString());

    return lines.map((l) => l.trimRight()).join('\n');
  }
}
