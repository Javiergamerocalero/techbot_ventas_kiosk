import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventas_kiosko/models/cart/cart.dart';
import 'package:ventas_kiosko/providers/config/app_dimensions_provider.dart';
import 'package:ventas_kiosko/widgets/cart/cart_item_card.dart';
import 'package:ventas_kiosko/widgets/cart/combo_cart_item_card.dart';

/// Lista de productos y combos del carrito
class CartItemsList extends ConsumerWidget {
  final Cart cart;

  const CartItemsList({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final d = ref.watch(appDimensionsProvider(context));

    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.all(d.horizontalPadding),
        itemCount: cart.items.length + cart.comboItems.length,
        separatorBuilder: (context, index) => SizedBox(height: d.spacingM),
        itemBuilder: (context, index) {
          if (index < cart.items.length) {
            // Mostrar producto
            final item = cart.items[index];
            return CartItemCard(item: item);
          } else {
            // Mostrar combo
            final comboIndex = index - cart.items.length;
            final comboItem = cart.comboItems[comboIndex];
            return ComboCartItemCard(item: comboItem);
          }
        },
      ),
    );
  }
}
