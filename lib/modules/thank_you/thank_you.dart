import 'package:flutter/material.dart';
import 'package:store/shared/themes/app_text_styles.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({Key? key}) : super(key: key);

  void goToHomePage(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Thank you for your purchase!!!",
              style: TextStyles.title,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        goToHomePage(context);
                      },
                      child: const Text('Continue Shopping')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
