import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_management/src/core/models/timeline_model.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final uid = _auth.currentUser!.uid;

class ProjectManagementService extends ChangeNotifier {
  final CollectionReference _project = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('projects');
  Future<void> addProject(
    String title,
    String description,
    List<TimelineModel> timeline,
  ) async {
    try {
      final List<Map<String, dynamic>> timelineData =
          timeline.map((timelineModel) => timelineModel.toMap()).toList();

      await _project.add({
        'title': title,
        'description': description,
        'createdAt': DateTime.now(),
        'timeline': timelineData
      });
    } catch (e) {
      throw e.toString();
    }
  }
}
