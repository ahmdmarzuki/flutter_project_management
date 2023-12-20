import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_management/utils/color.dart';
import 'package:project_management/utils/costum_text.dart';
import 'package:project_management/utils/fontweight.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final int totalTimeline;
  // final DateTime createdAt;
  const ProjectCard({
    super.key,
    required this.title,
    required this.description, required this.totalTimeline,
    // required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 26),
      decoration: BoxDecoration(
          color: bgColor2, borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          // row title desc
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // title desc column
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CostumText(
                    text: title,
                    color: whiteColor,
                    fontSize: 22,
                    fontWeight: light,
                  ),
                  CostumText(text: description, color: secondaryTextColor)
                ],
              ),
              // datetime progress column
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CostumText(text: '', color: whiteColor),
                  CostumText(text: "0/${totalTimeline}", color: secondaryTextColor)
                ],
              )
            ],
          ),
          const SizedBox(height: 12),
          // indicator
          LinearProgressIndicator(
            valueColor: AlwaysStoppedAnimation(primaryColor),
            backgroundColor: primaryColor.withOpacity(.5),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
            value: 0 / totalTimeline,
          )
        ],
      ),
    );
  }
}
