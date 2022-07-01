import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/modules/home/home_page.dart';
import 'package:store/modules/login/login_page.dart';
import 'package:store/modules/product_detail/product_detail_page.dart';
import 'package:store/shared/models/cart_model.dart';
import 'package:store/shared/models/product_model.dart';

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
        routes: {
          "/home": (context) => HomePage(),
          "/login": (context) => LoginPage(),
          "/product_detail": (context) => ProductDetailPage(),
        },
      ),
    );
  }
}
