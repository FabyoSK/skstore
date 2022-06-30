import 'package:flutter/material.dart';
import 'package:store/modules/home/home_page.dart';
import 'package:store/modules/login/login_page.dart';
import 'package:store/modules/product_detail/product_detail_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store',
      theme: ThemeData(
        primaryColor: Colors.amberAccent,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/product_detail",
      routes: {
        "/home": (context) => HomePage(),
        "/login": (context) => LoginPage(),
        "/product_detail": (context) => ProductDetailPage(),
      },
    );
  }
}
