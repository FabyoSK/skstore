import 'package:flutter/material.dart';
import 'package:store/shared/models/cart_model.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:provider/provider.dart';
import 'package:store/shared/widget/shopping_cart_product_card/shopping_cart_product_card.dart';

class ShoppingCartProductList extends StatefulWidget {
  final List<ProductModel> productList;
  final Function(BuildContext, ProductModel) onCardTap;
  final Function() notifyParent;
  const ShoppingCartProductList(
      {Key? key,
      required this.productList,
      required this.onCardTap,
      required this.notifyParent})
      : super(key: key);

  @override
  State<ShoppingCartProductList> createState() =>
      _ShoppingCartProductListState();
}

class _ShoppingCartProductListState extends State<ShoppingCartProductList> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget.productList.length,
      itemBuilder: (BuildContext context, int index) {
        ProductModel product = widget.productList[index];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShoppingCartProductCard(
            key: ValueKey(product.id),
            product: product,
            onTap: () {
              widget.onCardTap(context, product);
            },
            onCartButtonTap: () {
              cart.add(product);
            },
            onCartAddButtonTap: () {
              cart.setQuantity(index, product.quantity + 1);
              setState(() {});
              widget.notifyParent();
            },
            onCartRemoveButtonTap: () {
              cart.setQuantity(index, product.quantity - 1);
              setState(() {});
              widget.notifyParent();
            },
          ),
        );
      },
    );
  }
}
