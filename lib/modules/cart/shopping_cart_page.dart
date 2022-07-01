import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/shared/header/header.dart';
import 'package:store/shared/models/cart_model.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:store/shared/utils/format_currency.dart';
import 'package:store/shared/widget/shopping_cart_product_card/shopping_cart_product_card.dart';
import 'package:store/shared/widget/shopping_cart_product_list/shopping_cart_product_list.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  Future<List<ProductModel>> getShoppingCartProduct(CartModel cart) async {
    return cart.getProducts();
  }

  String calculateTotal(List<ProductModel> products) {
    double sum = 0;
    products.forEach((product) {
      final price = double.parse(product.price);

      sum += price;
    });

    return FormatCurrency.format(sum);
  }

  Widget header(cartProductCount) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Shopping Card"),
            Text(cartProductCount.toString()),
          ],
        ),
      ),
    );
  }

  Widget total(CartModel cart) {
    return Expanded(
      flex: 2,
      child: Card(
        elevation: 2.0,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text("Total"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("total"),
                  Text(calculateTotal(cart.getProducts())),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Checkout'))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget renderList(CartModel cart) {
    // cart.bootstrapInitialProducts();
    return Container(
      child: ShoppingCartProductList(
        productList: cart.getProducts(),
        onCardTap: (context, b) {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    var cartProductCount = cart.getProducts().length;

    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Header(),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [header(cartProductCount), renderList(cart)],
            ),
          ),
          total(cart),
        ],
      ),
    );
  }
}
