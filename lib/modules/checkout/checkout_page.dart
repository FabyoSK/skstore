import 'package:flutter/material.dart';
import 'package:store/modules/checkout/checkout_controller.dart';
import 'package:store/shared/models/cart_model.dart';
import 'package:store/shared/models/product_model.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final controller = CheckoutController();

  void goToThankYouPage(BuildContext context) {
    Navigator.pushNamed(context, "/thank_you");
  }

  Widget orderSummary() {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Text("Review your order"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text("Total"),
                Text("100\$"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final products =
        ModalRoute.of(context)!.settings.arguments as List<ProductModel>;

    final cart = context.watch<CartModel>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              orderSummary(),
              // CheckoutSteps(),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        await controller.checkout(products, cart, () {
                          goToThankYouPage(context);
                        });
                      },
                      child: const Text('Confirm and Checkout'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
