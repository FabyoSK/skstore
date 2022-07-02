import 'package:flutter/material.dart';
import 'package:store/shared/auth/auth_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Register'),
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
              TextButton(
                child: const Text('Login'),
                onPressed: () async {
                  await authController
                      .register(name, email, password)
                      .then((r) => {Navigator.pushNamed(context, "/home")});
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