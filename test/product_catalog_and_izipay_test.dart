import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/utils/product_catalog.dart';
import 'package:ventas_kiosko/screens/config/izipay_result_screen.dart';
import 'package:ventas_kiosko/models/config/payment_method.dart';
import 'package:ventas_kiosko/screens/invoice_selection_screen.dart';
import 'package:ventas_kiosko/services/app_log.dart';
import 'package:ventas_kiosko/services/izipay_service.dart';
import 'package:ventas_kiosko/services/izipay_voucher_formatter.dart';

Product _product({required int id, required String sku, String name = 'P'}) {
  return Product(
    id: id,
    name: name,
    description: '',
    price: '1.00',
    discountedPrice: '1.00',
    thumbnail: '',
    categoryId: 1,
    sku: sku,
  );
}

void main() {
  group('ProductCatalog PUB filter', () {
    tearDown(() => ProductCatalog.showAllSkus = false);

    test('solo SKUs con prefijo PUB entran al catálogo', () {
      expect(ProductCatalog.isPublishedSku('PUB-HUEVOS'), isTrue);
      expect(ProductCatalog.isPublishedSku('pub-tira'), isTrue);
      expect(ProductCatalog.isPublishedSku('HUEVOS-30'), isFalse);
      expect(ProductCatalog.isPublishedSku(''), isFalse);
    });

    test('findBySku resuelve productos no publicados', () {
      final products = [
        _product(id: 1, sku: 'PUB-A', name: 'Visible'),
        _product(id: 2, sku: 'TIRAS-PECHUGA', name: 'Oculto'),
      ];
      expect(
        ProductCatalog.findProductBySku(products, 'tiras-pechuga')?.name,
        'Oculto',
      );
      expect(
        ProductCatalog.publishedOnly(products).map((p) => p.sku).toList(),
        ['PUB-A'],
      );
    });

    // El caso del tenant 20: catálogo entero sin un solo SKU marcado.
    // Con el filtro puesto el menú queda vacío; el interruptor de
    // Config lo devuelve completo sin tocar los SKUs en Qapp.
    test('el interruptor devuelve el catálogo sin prefijo', () {
      final products = [
        _product(id: 1, sku: '141415', name: 'HUEVOS 30 UNID'),
        _product(id: 2, sku: '127237', name: 'FILETE DE PECHUGA'),
      ];
      expect(ProductCatalog.publishedOnly(products), isEmpty);

      ProductCatalog.showAllSkus = true;
      expect(ProductCatalog.publishedOnly(products).length, 2);
      expect(ProductCatalog.isPublishedSku('141415'), isTrue);
    });
  });

  group('Izipay: cada operación manda lo que pide el manual', () {
    // Las afirmaciones de este grupo salen de los ejemplos de las
    // Especificaciones Técnicas PMP-API REST v2.3: compra 4.3, anulación
    // 4.4, reimpresión 4.5, reporte detallado 4.6, totales 4.7, cierre
    // 4.8 y QR directo 8.2.

    test('la compra con tarjeta es la 01 con monto y moneda', () {
      expect(IzipayService.purchaseBody(5.20), {
        'ecr_aplicacion': 'POS',
        'ecr_transaccion': '01',
        'ecr_amount': '520',
        'ecr_currency_code': '604',
      });
    });

    test('la compra con QR es la 67 y avisa que no pida BIN', () {
      expect(IzipayService.purchaseBody(5.20, mode: IzipayMode.qr), {
        'ecr_aplicacion': 'POS',
        'ecr_transaccion': '67',
        'ecr_amount': '520',
        'ecr_currency_code': '604',
        'ecr_data_adicional': '0',
      });
    });

    test('la anulación lleva monto, moneda y la referencia original', () {
      expect(IzipayService.voidBody(amount: 5.20, reference: '8075'), {
        'ecr_aplicacion': 'POS',
        'ecr_transaccion': '06',
        'ecr_amount': '520',
        'ecr_currency_code': '604',
        'ecr_data_adicional': '8075',
      });
    });

    test('la reimpresión lleva la referencia del voucher', () {
      expect(
        IzipayService.supervisorBody(IzipayService.txReimpresion,
            reference: '2230'),
        {
          'ecr_aplicacion': 'POS',
          'ecr_transaccion': '11',
          'ecr_data_adicional': '2230',
        },
      );
    });

    test('sin referencia, la reimpresión omite el campo', () {
      // Mandarlo vacío no es lo mismo que no mandarlo: el pinpad lo
      // rechaza. Sin el campo reimprime la última del lote.
      expect(IzipayService.supervisorBody(IzipayService.txReimpresion), {
        'ecr_aplicacion': 'POS',
        'ecr_transaccion': '11',
      });
    });

    test('reportes y cierre viajan solo con aplicación y transacción', () {
      // Este es el error que reportó Javier el 2026-09-15: el reporte
      // detallado fallaba con código 89 porque le agregábamos moneda y
      // un dato adicional vacío que el manual no pide.
      for (final tx in [
        IzipayService.txReporteDetallado,
        IzipayService.txReporteTotales,
        IzipayService.txCierre,
        IzipayService.txReporteDetalladoCierre,
        IzipayService.txReporteTotalesCierre,
      ]) {
        expect(
          IzipayService.supervisorBody(tx),
          {'ecr_aplicacion': 'POS', 'ecr_transaccion': tx},
          reason: 'la transacción $tx salió con campos de más',
        );
      }
    });

    test('los códigos de operación son los de la tabla del manual', () {
      expect(IzipayService.txCompra, '01');
      expect(IzipayService.txAnulacion, '06');
      expect(IzipayService.txReporteDetallado, '09');
      expect(IzipayService.txReporteTotales, '10');
      expect(IzipayService.txReimpresion, '11');
      expect(IzipayService.txCierre, '12');
      expect(IzipayService.txReporteDetalladoCierre, '19');
      expect(IzipayService.txReporteTotalesCierre, '20');
      expect(IzipayService.txQrDirecto, '67');
    });
  });

  group('Izipay amount + voucher', () {
    test('amountToEcr padea céntimos', () {
      expect(IzipayService.amountToEcr(0.10), '010');
      expect(IzipayService.amountToEcr(1.20), '120');
      expect(IzipayService.amountToEcr(12.34), '1234');
    });

    test('el formateador quita el prefijo de fuente', () {
      final raw = String.fromCharCodes([0x41, 0x48, 0x6F, 0x6C, 0x61, 0x0D]);
      expect(IzipayVoucherFormatter.toPlainText(raw).trim(), 'Hola');
    });

    test('las cuatro fuentes se imprimen igual', () {
      for (final fuente in [0x41, 0x42, 0x43, 0x44]) {
        final raw = String.fromCharCodes([fuente, 0x41, 0x42, 0x0D]);
        expect(IzipayVoucherFormatter.toPlainText(raw).trim(), 'AB');
      }
    });

    test('la línea en blanco sale en blanco, no como un 2', () {
      // Formato del manual (sección 6): 32 1B 20 0D. El 0x32 es el
      // carácter '2' y sin tratarlo aparte se imprimía suelto.
      final raw = String.fromCharCodes([
        0x41, 0x48, 0x6F, 0x6C, 0x61, 0x0D, // "Hola"
        0x32, 0x1B, 0x20, 0x0D, //             línea en blanco
        0x41, 0x46, 0x69, 0x6E, 0x0D, //       "Fin"
      ]);
      expect(IzipayVoucherFormatter.toPlainText(raw), 'Hola\n\nFin');
    });

    test('la línea de imagen no se imprime', () {
      // 32 1C ZZ 0D, donde ZZ es el logo. Una térmica simple no lo pinta.
      final raw = String.fromCharCodes([
        0x41, 0x48, 0x6F, 0x6C, 0x61, 0x0D,
        0x32, 0x1C, 0x42, 0x0D,
        0x41, 0x46, 0x69, 0x6E, 0x0D,
      ]);
      expect(IzipayVoucherFormatter.toPlainText(raw), 'Hola\nFin');
    });
  });

  group('Registro de operaciones: nunca guarda credenciales', () {
    test('las claves sensibles salen ocultas', () {
      final limpio = AppLog.enmascarar({
        'ecr_usuario': 'izipay',
        'ecr_password': 'izipay',
        'token': 'eyJhbGciOiJIUzI1NiJ9.abc',
        'ecr_amount': '520',
      }) as Map;

      expect(limpio['ecr_password'], 'oculto');
      expect(limpio['token'], 'oculto');
      // Lo que sirve para diagnosticar se conserva tal cual.
      expect(limpio['ecr_usuario'], 'izipay');
      expect(limpio['ecr_amount'], '520');
    });

    test('también las oculta anidadas y dentro de listas', () {
      final limpio = AppLog.enmascarar({
        'headers': {'Authorization': 'Bearer abc.def'},
        'intentos': [
          {'api_key': 'secreta', 'ok': false},
        ],
      }) as Map;

      expect((limpio['headers'] as Map)['Authorization'], 'oculto');
      expect(((limpio['intentos'] as List).first as Map)['api_key'], 'oculto');
      expect(((limpio['intentos'] as List).first as Map)['ok'], false);
    });

    test('tapa el token cuando viaja dentro de un texto suelto', () {
      expect(
        AppLog.enmascarar('fallo con Authorization: Bearer eyJhbGciOi.JIUzI1'),
        'fallo con Authorization: Bearer oculto',
      );
    });
  });

  group('El voucher entra sin partirse', () {
    /// Mide de verdad: arma una fila de 38 caracteres con el tamaño que
    /// calcula VoucherFit y comprueba que no se pase del ancho.
    double anchoReal(String texto, double tamano) {
      final pintor = TextPainter(
        text: TextSpan(
          text: texto,
          style: TextStyle(fontFamily: 'monospace', fontSize: tamano),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      return pintor.width;
    }

    test('una fila completa cabe en anchos de kiosco habituales', () {
      final fila = 'X' * VoucherFit.columnas;
      for (final ancho in [320.0, 360.0, 480.0, 600.0, 800.0]) {
        final tamano = VoucherFit.tamanoQueEntra(ancho);
        expect(
          anchoReal(fila, tamano),
          lessThanOrEqualTo(ancho),
          reason: 'con $ancho de ancho la fila se pasa y se parte en dos',
        );
      }
    });

    test('un ancho absurdo no rompe nada', () {
      expect(VoucherFit.tamanoQueEntra(0), greaterThan(0));
      expect(VoucherFit.tamanoQueEntra(-5), greaterThan(0));
      expect(VoucherFit.tamanoQueEntra(double.infinity), greaterThan(0));
      // En una pantalla enorme la letra no crece sin control.
      expect(VoucherFit.tamanoQueEntra(5000), VoucherFit.tamanoMaximo);
    });

    test('el cálculo sale de medir la fuente, no de una constante', () {
      // En las pruebas la fuente es cuadrada (cada carácter mide un em),
      // así que la fila de 38 ocupa 38 veces el tamaño de letra. Si el
      // cálculo estuviera atado a una constante pensada para una fuente
      // real, acá daría de más y el texto se partiría.
      expect(VoucherFit.tamanoQueEntra(380), closeTo(10, 0.01));
    });
  });

  group('La elección de QR no se pierde entre pantallas', () {
    const metodo = PaymentMethod(type: PaymentMethodType.izipay);

    test('el modo viaja en los argumentos de la ruta', () {
      final args = {'paymentMethod': metodo, 'izipayMode': 'qr'};
      expect(ArgumentosDePago.metodo(args), metodo);
      expect(ArgumentosDePago.modoIzipay(args), IzipayMode.qr);
    });

    test('con tarjeta, o sin el dato, queda en tarjeta', () {
      expect(
        ArgumentosDePago.modoIzipay(
          {'paymentMethod': metodo, 'izipayMode': 'tarjeta'},
        ),
        IzipayMode.tarjeta,
      );
      expect(
        ArgumentosDePago.modoIzipay({'paymentMethod': metodo}),
        IzipayMode.tarjeta,
      );
      expect(ArgumentosDePago.modoIzipay(null), IzipayMode.tarjeta);
    });

    test('sigue aceptando el formato viejo, el método suelto', () {
      // Esta pantalla se abría pasando solo el método de pago. Si algún
      // camino quedó así, tiene que seguir funcionando.
      expect(ArgumentosDePago.metodo(metodo), metodo);
      expect(ArgumentosDePago.modoIzipay(metodo), IzipayMode.tarjeta);
    });
  });
}
