import 'package:flutter/material.dart';
import 'package:store/restart_widget.dart';
import 'package:store/shared/auth/auth_controller.dart';
import 'package:store/shared/themes/app_text_styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String name = '';
  String email = '';
  String password = '';

  final authController = AuthController();

  void goToHomePage(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  void goToLoginPage(BuildContext context) {
    Navigator.pushNamed(context, "/login");
  }

  void goBackToPage(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
                  'Create your account',
                  style: TextStyles.bigTextBold,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your name',
                    labelText: 'Name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
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
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () {
                    goToLoginPage(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyles.smallText,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  child: Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Submit'),
                      ],
                    ),
                  ),
                  onPressed: () async {
                    authController
                        .register(name, email, password)
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
