import 'package:flutter/material.dart';
import 'package:store/restart_widget.dart';
import 'package:store/shared/auth/auth_controller.dart';
import 'package:store/shared/themes/app_text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';

  final authController = AuthController();

  void goToHomePage(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  void goToRegisterPage(BuildContext context) {
    Navigator.pushNamed(context, "/register");
  }

  void goToPage(BuildContext context, String page) {
    print(page);
    Navigator.pushNamed(context, page);
  }

  @override
  Widget build(BuildContext context) {
    final prevRoute = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      body: Card(
        child: Center(
          child: SizedBox(
            width: 600,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter your credentials to Login',
                  style: TextStyles.bigTextBold,
                  textAlign: TextAlign.start,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                    labelText: 'Email',
                  ),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    goToRegisterPage(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyles.smallText,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Submit'),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    authController
                        .login(email, password)
                        .then((r) => {
                              goToHomePage(context),
                              RestartWidget.restartApp(context),
                            })
                        .catchError((error) => {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(error),
                              ))
                            });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
