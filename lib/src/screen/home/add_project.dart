import 'package:flutter/material.dart';
import 'package:project_management/src/core/models/timeline_model.dart';
import 'package:project_management/src/core/services/project_management_services/project_management_service.dart';
import 'package:project_management/src/screen/auth/widget/costum_text_form_field.dart';
import 'package:project_management/src/screen/auth/widget/expanded_button.dart';
import 'package:project_management/utils/color.dart';
import 'package:project_management/utils/costum_text.dart';
import 'package:project_management/utils/text_style.dart';
import 'package:project_management/utils/theme.dart';
import 'package:provider/provider.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  final titleTimelineController = TextEditingController();
  final descTimelineController = TextEditingController();

  final List<TimelineModel> _timeline = [];

  void addProject() async {
    final projectService =
        Provider.of<ProjectManagementService>(context, listen: false);

    await projectService.addProject(
        titleController.text, descController.text, _timeline);
  }

  void addTimeline(String title, String description) {
    _timeline.add(TimelineModel(title: title, description: description));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          titleTimelineController.clear();
          descTimelineController.clear();
          showModalBottomSheet(
              backgroundColor: bgColor2,
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  height: 338,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 12),
                          height: 6,
                          width: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(3)),
                        ),
                      ),
                      SizedBox(height: 30),
                      CostumText(
                        text: "Add Timeline",
                        color: whiteColor,
                        fontSize: 18,
                      ),
                      const SizedBox(height: 20),
                      // CostumTextFormField(
                      //     bgColor: bgColor2,
                      //     textStyle: googlePoppins,
                      //     controller: titleTimelineController,
                      //     obscureText: false,
                      //     hintStyle: googlePoppins,
                      //     hintText: "Timeline Title"),
                      // const SizedBox(height: 30),
                      // CostumTextFormField(
                      //     bgColor: bgColor2,
                      //     textStyle: googlePoppins,
                      //     controller: descTimelineController,
                      //     obscureText: false,
                      //     hintStyle: googlePoppins,
                      //     hintText: "Timeline Description"),
                      const SizedBox(height: 30),
                      ExpandedButton(
                          text: "Save",
                          isLoading: false,
                          textColor: whiteColor,
                          buttonColor: primaryColor,
                          loadingButtonColor: primaryColor.withOpacity(.8),
                          textStyle: googlePoppins,
                          onTap: () {
                            addTimeline(titleTimelineController.text,
                                descTimelineController.text);

                            Navigator.pop(context);
                          })
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Column(
            children: [
              // CostumTextFormField(
              //     bgColor: bgColor2,
              //     textStyle: googlePoppins,
              //     controller: titleController,
              //     obscureText: false,
              //     hintStyle: googlePoppins,
              //     hintText: "Title"),
              // const SizedBox(height: 30),
              // CostumTextFormField(
              //     bgColor: bgColor2,
              //     textStyle: googlePoppins,
              //     controller: descController,
              //     obscureText: false,
              //     hintStyle: googlePoppins,
              //     hintText: "Description"),
              // const SizedBox(height: 30),
              // ExpandedButton(
              //     text: "Save",
              //     isLoading: false,
              //     textColor: whiteColor,
              //     buttonColor: primaryColor,
              //     loadingButtonColor: primaryColor.withOpacity(.8),
              //     textStyle: googlePoppins,
              //     onTap: () {
              //       addProject();

              //       Navigator.pop(context);
              //     }),
              // ListView.builder(
              //     shrinkWrap: true,
              //     itemCount: _timeline.length,
              //     itemBuilder: (context, index) {
              //       return Column(
              //         children: [
              //           Text(_timeline[index].title),
              //           const SizedBox(height: 12),
              //           Text(_timeline[index].description),
              //         ],
              //       );
              //     })
            ],
          ),
        ),
      ),
    );
  }
}
