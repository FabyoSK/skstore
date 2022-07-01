import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:store/shared/models/cart_model.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:store/shared/widget/product_card/product_card.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  final List<ProductModel> productList;
  final Function(BuildContext, ProductModel) onCardTap;
  const ProductList(
      {Key? key, required this.productList, required this.onCardTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    return Expanded(
      child: Wrap(
        children: <Widget>[
          for (final product in productList)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductCard(
                key: ValueKey(product.id),
                product: product,
                onTap: () {
                  onCardTap(context, product);
                },
              ),
            )
        ],
      ),
    );
  }
}
