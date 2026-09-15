/// Convierte el `print_data` que devuelve el PinPad Izipay a texto plano
/// imprimible, línea a línea.
///
/// El formato está en la sección 6 del manual PMP-API REST v2.3. Cada
/// línea termina en `0x0D` y empieza con un byte que dice cómo
/// imprimirla:
///
///  - `0x41` fuente normal, `0x42` doble, `0x43`/`0x44` las mismas en
///    inverso. El manual dice tratar 43 como 41 y 44 como 42, así que
///    para una térmica simple los cuatro son lo mismo: texto.
///  - Línea en blanco: `32 1B 20 0D`.
///  - Línea de imagen: `32 1C ZZ 0D`, donde `ZZ` indica qué logo va
///    (hoy solo el check de Visa DCC). Una térmica simple no lo imprime.
///
/// Las dos últimas empiezan con `0x32`, que es el carácter `2`. Si no se
/// tratan aparte, cada línea en blanco del voucher sale impresa como un
/// `2` suelto y la de imagen como `2B`.
class IzipayVoucherFormatter {
  static const _fuenteNormal = 0x41;
  static const _fuenteDoble = 0x42;
  static const _fuenteNormalInversa = 0x43;
  static const _fuenteDobleInversa = 0x44;
  static const _marcaControl = 0x32;
  static const _lineaEnBlanco = 0x1B;
  static const _lineaDeImagen = 0x1C;

  static String toPlainText(String printData) {
    final salida = <String>[];
    final crudas = printData.split(RegExp(r'[\r\n]'));
    // El voucher siempre termina en separador, así que al partirlo queda
    // un último trozo vacío que no es una línea del comprobante. Se
    // descarta solo ese, para no comerse las líneas en blanco reales,
    // que el pinpad manda como `32 1B 20 0D` y sirven de avance de papel.
    if (crudas.length > 1 && crudas.last.isEmpty) {
      crudas.removeLast();
    }

    for (final linea in crudas) {
      if (linea.isEmpty) {
        salida.add('');
        continue;
      }
      final primero = linea.codeUnitAt(0);

      if (primero == _marcaControl && linea.length > 1) {
        final segundo = linea.codeUnitAt(1);
        // La de imagen no se imprime: se descarta la línea entera.
        if (segundo == _lineaDeImagen) continue;
        if (segundo == _lineaEnBlanco) {
          salida.add('');
          continue;
        }
      }

      if (primero == _fuenteNormal ||
          primero == _fuenteDoble ||
          primero == _fuenteNormalInversa ||
          primero == _fuenteDobleInversa) {
        salida.add(linea.substring(1).trimRight());
        continue;
      }

      salida.add(linea.trimRight());
    }

    return salida.join('\n');
  }
}
