import 'package:flutter/material.dart';
import 'package:store/shared/auth/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = 'fabio.alves@chuva.io';
  String password = 'password';

  final authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Login'),
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
              TextButton(
                child: const Text('Login'),
                onPressed: () async {
                  await authController.login(email, password);
                  // .then((r) => {Navigator.pushNamed(context, "/")})
                  // .catchError((error) => {
                  //       // handle Error
                  //       print(error)
                  //     });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
