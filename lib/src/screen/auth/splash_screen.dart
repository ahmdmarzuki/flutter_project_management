import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_management/src/core/services/auth_services/auth_gate.dart';
import 'package:project_management/utils/costum_text.dart';
import 'package:project_management/utils/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AuthGate())));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CostumText(text: 'Splashhhh', color: blackColor)),
    );
  }
}
