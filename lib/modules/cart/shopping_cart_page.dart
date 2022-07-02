import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/shared/header/header.dart';
import 'package:store/shared/models/cart_model.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:store/shared/themes/app_text_styles.dart';
import 'package:store/shared/utils/format_currency.dart';
import 'package:store/shared/widget/shopping_cart_product_list/shopping_cart_product_list.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  String totalSum = "0";

  Future<List<ProductModel>> getShoppingCartProduct(CartModel cart) async {
    return cart.getProducts();
  }

  void goToCheckoutPage(BuildContext context, List<ProductModel> products) {
    Navigator.pushNamed(context, "/checkout", arguments: products);
  }

  void calculateTotal(List<ProductModel> products) {
    double sum = 0;
    for (ProductModel product in products) {
      final price = double.parse(product.price);
      final totalPrice = price * product.quantity;
      sum += totalPrice;
    }

    setState(() {
      totalSum = FormatCurrency.format(sum);
    });
  }

  Widget _buildHeader(cartProductCount) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Shopping Card ($cartProductCount)",
              style: TextStyles.title,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSummary(CartModel cart) {
    calculateTotal(cart.getProducts());
    return Expanded(
      flex: 2,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Total",
                  style: TextStyles.title,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyles.text,
                  ),
                  Text(
                    totalSum,
                    style: TextStyles.text,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Expanded(
                  child: Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            goToCheckoutPage(context, cart.getProducts());
                          },
                          child: Text('Checkout')),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    var cartProductCount = cart.getProducts().length;

    return Scaffold(
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
              children: [
                _buildHeader(cartProductCount),
                ShoppingCartProductList(
                  productList: cart.getProducts(),
                  notifyParent: refresh,
                  onCardTap: (context, b) {},
                ),
              ],
            ),
          ),
          _buildTotalSummary(cart),
        ],
      ),
    );
  }
}
