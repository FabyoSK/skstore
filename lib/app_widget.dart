import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/app_wrapper.dart';
import 'package:store/modules/cart/shopping_cart_page.dart';
import 'package:store/modules/checkout/checkout_page.dart';
import 'package:store/modules/home/home_page.dart';
import 'package:store/modules/login/login_page.dart';
import 'package:store/modules/order/orders_page.dart';
import 'package:store/modules/product_detail/product_detail_page.dart';
import 'package:store/modules/register/register.dart';
import 'package:store/modules/thank_you/thank_you.dart';
import 'package:store/shared/models/cart_model.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        title: 'Store',
        theme: ThemeData(
          primaryColor: Colors.amberAccent,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/home",
        builder: (context, child) {
          return Overlay(
            initialEntries: [
              OverlayEntry(
                builder: (context) => AppWrapper(child: child!),
              ),
            ],
          );
        },
        routes: {
          "/home": (context) => const HomePage(),
          "/login": (context) => const LoginPage(),
          "/register": (context) => const RegisterPage(),
          "/product_detail": (context) => const ProductDetailPage(),
          "/shoppingcart": (context) => const ShoppingCartPage(),
          "/checkout": (context) => const CheckoutPage(),
          "/orders": (context) => const OrdersPage(),
          "/thank_you": (context) => const ThankYouPage(),
        },
      ),
    );
  }
}
