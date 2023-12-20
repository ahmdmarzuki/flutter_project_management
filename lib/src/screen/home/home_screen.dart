import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_management/src/core/models/project_model.dart';
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
    final CollectionReference _projectDb = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('projects');

    // StreamController<ProjectModel> _projectStream = StreamController();

    final _project =
        _projectDb.doc(_projectDb.id).get().then((DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
    });

    //   then(
    // (DocumentSnapshot doc) {
    //   final data = doc.data() as Map<String, dynamic>;

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
                      CostumText(
                        text: user.displayName.toString(),
                        color: secondaryTextColor,
                        fontSize: 18,
                      )
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
                  CostumText(
                    text: "My Project",
                    color: whiteColor,
                    fontSize: 24,
                  ),
                  CostumText(
                    text: "view All",
                    color: secondaryTextColor,
                    fontSize: 14,
                  )
                ],
              ),
              SizedBox(height: defaultMargin),
              StreamBuilder(
                  stream: _projectDb.snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          DocumentSnapshot doc = snapshot.data!.docs[index];
                          return ProjectCard(
                            title: doc['title'],
                            description: doc['description'], totalTimeline: doc['timeline'].length,
                            // createdAt: doc['createdAt'],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 12,
                          );
                        },
                      );
                    } else {
                      return CostumText(text: "No Data", color: whiteColor);
                    }
                  })
            ],
          ),
        ));
  }
}
