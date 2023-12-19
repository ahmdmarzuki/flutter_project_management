import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_management/firebase_options.dart';
import 'package:project_management/src/core/services/auth_services/auth_service.dart';
import 'package:project_management/src/core/services/auth_services/register_or_login.dart';
import 'package:project_management/src/core/services/project_management_services/project_management_service.dart';
import 'package:project_management/src/screen/auth/splash_screen.dart';
import 'package:project_management/src/screen/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AuthService(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProjectManagementService(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/auth': (context) => const RegisterOrLogin(),
      },
    );
  }
}



