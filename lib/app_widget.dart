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
import 'package:store/shared/auth/auth_controller.dart';
import 'package:store/shared/models/cart_model.dart';
import 'package:store/shared/models/user_model.dart';

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  AuthController authController = AuthController();

  Widget _appWidget(UserModel? user) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartModel(),
        ),
        user != null
            ? ChangeNotifierProvider<UserModel?>(
                create: (context) => user,
              )
            : ChangeNotifierProvider<UserModel?>(
                create: (context) => null,
              )
      ],
      child: MaterialApp(
        title: 'Store',
        theme: ThemeData(
          primaryColor: Colors.amberAccent,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: "/home",
        routes: {
          "/home": (context) => const AppWrapper(
                child: HomePage(),
              ),
          "/login": (context) => const AppWrapper(
                child: LoginPage(),
              ),
          "/register": (context) => const AppWrapper(
                child: RegisterPage(),
              ),
          "/product_detail": (context) => const AppWrapper(
                child: ProductDetailPage(),
              ),
          "/shoppingcart": (context) => const AppWrapper(
                child: ShoppingCartPage(),
              ),
          "/checkout": (context) => const AppWrapper(
                child: CheckoutPage(),
              ),
          "/orders": (context) => const AppWrapper(
                child: OrdersPage(),
              ),
          "/thank_you": (context) => const AppWrapper(
                child: ThankYouPage(),
              ),
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
      future: authController.getUserInfo(),
      builder: (
        BuildContext context,
        AsyncSnapshot<UserModel?> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return _appWidget(snapshot.data!);
          } else {
            return _appWidget(null);
          }
        } else {
          return Text('State: ${snapshot.connectionState}');
        }
      },
    );
  }
}
