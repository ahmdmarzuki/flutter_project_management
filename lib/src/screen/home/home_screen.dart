import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_management/src/core/services/auth_services/auth_service.dart';
import 'package:project_management/src/screen/project/add_project.dart';
import 'package:project_management/utils/color.dart';
import 'package:project_management/utils/costum_text.dart';
import 'package:project_management/utils/fontweight.dart';
import 'package:project_management/utils/margin.dart';
import 'package:project_management/utils/theme.dart';
import 'package:provider/provider.dart';

import 'widget/project_card.dart';

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
        backgroundColor: bgColor1,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(150),
            child: Container(
              height: 150,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CostumText(
                        text: "Hello,",
                        color: whiteColor,
                        fontSize: 24,
                        fontWeight: medium,
                      ),
                      CostumText(text: user.displayName.toString(), color: secondaryTextColor, fontSize: 18,)
                    ],
                  ),
                  const CircleAvatar(),
                ],
              ),
            )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddProjectScreen()));
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                CostumText(text: "My Project", color: whiteColor, fontSize: 24,),
                CostumText(text: "view All", color: secondaryTextColor, fontSize: 14,)
              ],),

              SizedBox(height: defaultMargin),
              // project card
              const ProjectCard()
            ],
          ),
        ));
  }
}
