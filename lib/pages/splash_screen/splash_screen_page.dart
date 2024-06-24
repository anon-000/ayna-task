import 'dart:developer';

import 'package:ayna_task/pages/auth/login_page.dart';
import 'package:ayna_task/pages/chats/chats_page.dart';
import 'package:ayna_task/utils/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///
/// Created by Auro on 24/06/24
///

class SplashScreen extends StatefulWidget {
  static const routeName = "/";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkConditionAndNavigate();
  }

  void _checkConditionAndNavigate() async {
    try {
      final GoRouter router = GoRouter.of(context);

      log(router.configuration.toString());
      if (AuthHelper.isLoggedIn) {
        /// will go to chats page
        GoRouter.of(context).pushNamed('/login');
      } else {
        /// will go to login page
        router.pushNamed(LoginPage.routeName);
      }
    } catch (err) {
      log("$err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Splash Screen"),
      ),
    );
  }
}
