import 'package:flutter/material.dart';

///
/// Created by Auro on 24/06/24 at 8:55 pm
///

class LoginPage extends StatefulWidget {
  static const routeName = "/login";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Login Screen"),
      ),
    );
  }
}
