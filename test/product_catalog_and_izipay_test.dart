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

  group('Izipay: datos que exige cada operación', () {
    // Javier, 2026-09-14: Duplicado respondía "MONEDA NO EXISTE". El
    // cuerpo viajaba sin ecr_currency_code porque la operación no mueve
    // dinero. El pinpad la exige igual, en todas.
    test('toda operación lleva moneda y aplicación', () {
      final cuerpos = <String, Map<String, dynamic>>{
        'compra': IzipayService.purchaseBody(12.34),
        'anulación': IzipayService.voidBody(amount: 12.34, reference: '000123'),
        'reimpresión': IzipayService.supervisorBody(IzipayService.txReimpresion),
        'reporte detallado':
            IzipayService.supervisorBody(IzipayService.txReporteDetallado),
        'reporte totales':
            IzipayService.supervisorBody(IzipayService.txReporteTotales),
        'cierre': IzipayService.supervisorBody(IzipayService.txCierre),
      };

      for (final entry in cuerpos.entries) {
        expect(
          entry.value['ecr_currency_code'],
          '604',
          reason: '${entry.key} salió sin moneda',
        );
        expect(entry.value['ecr_aplicacion'], 'POS', reason: entry.key);
        expect(
          (entry.value['ecr_transaccion'] as String).isNotEmpty,
          isTrue,
          reason: entry.key,
        );
      }
    });

    test('compra y anulación llevan monto; las de supervisor no', () {
      expect(IzipayService.purchaseBody(12.34)['ecr_amount'], '1234');
      expect(
        IzipayService.voidBody(amount: 0.10, reference: 'REF1')['ecr_amount'],
        '010',
      );
      expect(
        IzipayService.supervisorBody(IzipayService.txReimpresion)
            .containsKey('ecr_amount'),
        isFalse,
      );
    });

    test('la anulación exige la referencia de la compra original', () {
      expect(
        IzipayService.voidBody(amount: 1, reference: '000123')['ecr_data_adicional'],
        '000123',
      );
    });

    test('reimpresión y reportes llevan dato adicional; el cierre no', () {
      expect(
        IzipayService.supervisorBody(IzipayService.txReimpresion,
            reference: '000123')['ecr_data_adicional'],
        '000123',
      );
      // Sin referencia, el pinpad reimprime la última del lote.
      expect(
        IzipayService.supervisorBody(IzipayService.txReimpresion)['ecr_data_adicional'],
        '',
      );
      expect(
        IzipayService.supervisorBody(IzipayService.txReporteDetallado)
            .containsKey('ecr_data_adicional'),
        isTrue,
      );
      expect(
        IzipayService.supervisorBody(IzipayService.txCierre)
            .containsKey('ecr_data_adicional'),
        isFalse,
      );
    });

    test('los códigos de operación son los de la PMP-API', () {
      expect(IzipayService.txCompra, '01');
      expect(IzipayService.txAnulacion, '06');
      expect(IzipayService.txReporteDetallado, '09');
      expect(IzipayService.txReporteTotales, '10');
      expect(IzipayService.txReimpresion, '11');
      expect(IzipayService.txCierre, '12');
    });
  });

  group('Izipay amount + voucher', () {
    test('amountToEcr padea céntimos', () {
      expect(IzipayService.amountToEcr(0.10), '010');
      expect(IzipayService.amountToEcr(1.20), '120');
      expect(IzipayService.amountToEcr(12.34), '1234');
    });

    test('voucher formatter drops format prefixes', () {
      final raw = String.fromCharCodes([0x41, 0x48, 0x6F, 0x6C, 0x61, 0x0D]);
      expect(IzipayVoucherFormatter.toPlainText(raw).trim(), 'Hola');
    });
  });
}
