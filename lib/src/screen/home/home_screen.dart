import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_management/src/core/services/auth_services/auth_service.dart';
import 'package:project_management/src/screen/home/add_project.dart';
import 'package:project_management/utils/costum_text.dart';
import 'package:project_management/utils/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    void signOut() async {
      final authService =
          await Provider.of<AuthService>(context, listen: false);

      authService.signOut();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddProjectScreen()));
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CostumText(
              text: user.displayName.toString(),
              color: blackColor,
            ),
            ElevatedButton(
                onPressed: () {
                  signOut();
                },
                child: CostumText(text: 'Log out', color: whiteColor))
          ],
        ),
      ),
    );
  }
}