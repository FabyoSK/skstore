import 'package:flutter/material.dart';
import 'package:store/shared/widget/header/header.dart';

class AppWrapper extends StatelessWidget {
  final Widget child;

  const AppWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Header(),
      ),
      body: child,
    );
  }
}
