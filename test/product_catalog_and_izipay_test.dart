import 'package:flutter_test/flutter_test.dart';
import 'package:ventas_kiosko/models/products/product.dart';
import 'package:ventas_kiosko/utils/product_catalog.dart';
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
}
