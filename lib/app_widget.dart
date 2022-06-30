import 'package:flutter/material.dart';
import 'package:store/modules/home/home_page.dart';
import 'package:store/modules/login/login_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store',
      theme: ThemeData(
        primaryColor: Colors.amberAccent,
      ),
      initialRoute: "/login",
      routes: {
        "/home": (context) => HomePage(),
        "/login": (context) => LoginPage(),
      },
    );
  }
}
