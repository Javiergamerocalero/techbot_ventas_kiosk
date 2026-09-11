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
