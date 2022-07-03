import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/shared/models/cart_model.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:store/shared/models/user_model.dart';
import 'package:store/shared/themes/app_text_styles.dart';
import 'package:store/shared/utils/format_currency.dart';
import 'package:store/shared/widget/page_wrapper/page_wrapper.dart';
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

  void goToRegisterPage(BuildContext context) {
    Navigator.pushNamed(context, "/register", arguments: true);
  }

  void goToLoginPage(BuildContext context) {
    Navigator.pushNamed(context, "/login", arguments: "/shoppingcart");
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
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
    );
  }

  Widget _buildTotalSummary(CartModel cart, UserModel? user) {
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
                            if (user != null) {
                              goToCheckoutPage(context, cart.getProducts());
                            } else {
                              _showUserNotLoginAlert();
                            }
                          },
                          child: const Text('Checkout')),
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

  Future<void> _showUserNotLoginAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Please login to continue'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Ops, you are not logged in'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Login'),
              onPressed: () {
                goToLoginPage(context);
              },
            ),
            TextButton(
              child: const Text('Create My Account'),
              onPressed: () {
                goToRegisterPage(context);
              },
            ),
          ],
        );
      },
    );
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();
    final user = context.watch<UserModel?>();

    var cartProductCount = cart.getProducts().length;

    return PageWrapper(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
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
          ),
          _buildTotalSummary(cart, user),
        ],
      ),
    );
  }
}
