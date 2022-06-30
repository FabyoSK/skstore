import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:store/shared/widget/product_card/product_card.dart';

class ProductList extends StatefulWidget {
  final List<ProductModel> productList;
  final Function(String) onCardTap;
  const ProductList(
      {Key? key, required this.productList, required this.onCardTap})
      : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: widget.productList.length,
        itemBuilder: (context, index) {
          return ProductCard(
            product: widget.productList[index],
            onTap: widget.onCardTap(widget.productList[index].id),
          );
        },
      ),
    );
  }
}
