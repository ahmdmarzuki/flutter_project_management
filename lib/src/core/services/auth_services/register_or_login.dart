import 'package:flutter/material.dart';
import 'package:project_management/src/screen/auth/login_screen.dart';
import 'package:project_management/src/screen/auth/register_screen.dart';

class RegisterOrLogin extends StatefulWidget {
  const RegisterOrLogin({super.key});

  @override
  State<RegisterOrLogin> createState() => _RegisterOrLoginState();
}

class _RegisterOrLoginState extends State<RegisterOrLogin> {
  bool showLoginScreen = true;

  void toggle() {
    setState(
      () {
        showLoginScreen = !showLoginScreen;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(onTap: toggle);
    } else {
      return RegisterScreen(onTap: toggle);
    }
  }
}
