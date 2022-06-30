import 'package:flutter/material.dart';
import 'package:store/shared/models/cart_model.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:store/shared/widget/product_card/product_card.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  final List<ProductModel> productList;
  final Function(BuildContext, ProductModel) onCardTap;
  const ProductList(
      {Key? key, required this.productList, required this.onCardTap})
      : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        final product = widget.productList[index];
        return ProductCard(
          product: product,
          onTap: () {
            widget.onCardTap(context, product);
          },
          onCartButtonTap: () {
            cart.add(product);
          },
        );
      },
    );
  }
}
