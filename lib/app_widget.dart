import 'package:flutter/material.dart';
import 'package:store/modules/home/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store',
      theme: ThemeData(
        primaryColor: Colors.amberAccent,
      ),
      initialRoute: "/home",
      routes: {
        "/home": (context) => HomePage(),
      },
    );
  }
}
