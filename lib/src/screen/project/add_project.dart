
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_management/src/core/models/timeline_model.dart';
import 'package:project_management/src/core/services/project_management_services/project_management_service.dart';
import 'package:project_management/src/screen/auth/widget/expanded_button.dart';
import 'package:project_management/utils/color.dart';
import 'package:project_management/utils/costum_text.dart';
import 'package:project_management/utils/fontweight.dart';
import 'package:project_management/utils/margin.dart';
import 'package:project_management/utils/text_style.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

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

  List<TimelineModel> _timeline = [];

  // menambahkan timeline
  List<TimelineModel> fetch(String title, String description) {
    final List<TimelineModel> timeline = _timeline;

    timeline.add(TimelineModel(title: title, description: description));
    return timeline;
  }

  // hapus timeline sesuai index
  List<TimelineModel> delete(int index) {
    final List<TimelineModel> timeline = _timeline;

    timeline.removeAt(index);
    return timeline;
  }

  // ini untuk menambah kan project ke database
  void addProject() async {
    final projectService =
        Provider.of<ProjectManagementService>(context, listen: false);

    await projectService.addProject(
        titleController.text, descController.text, _timeline);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor2,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          titleTimelineController.clear();
          descTimelineController.clear();
          showModalBottomSheet(
              backgroundColor: bgColor2,
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
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
                      const SizedBox(height: 30),
                      CostumText(
                        text: "Add Timeline",
                        color: whiteColor,
                        fontSize: 18,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: bgColor4.withOpacity(.3)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: titleTimelineController,
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: whiteColor,
                                    fontWeight: light),
                                decoration: InputDecoration.collapsed(
                                    hintText: "Title",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: secondaryTextColor,
                                        fontWeight: light)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: bgColor4.withOpacity(.3)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: descTimelineController,
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: whiteColor,
                                    fontWeight: light),
                                decoration: InputDecoration.collapsed(
                                    hintText: "Description",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: secondaryTextColor,
                                        fontWeight: light)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      ExpandedButton(
                          text: "Add Timeline",
                          isLoading: false,
                          textColor: whiteColor,
                          buttonColor: primaryColor,
                          loadingButtonColor: primaryColor.withOpacity(.8),
                          textStyle: poppinsWhite,
                          onTap: () {
                            // addTimeline(titleTimelineController.text,
                            //     descTimelineController.text);

                            setState(() {
                              _timeline = fetch(titleTimelineController.text,
                                  descTimelineController.text);
                            });
                            Navigator.pop(context);
                          })
                    ],
                  ),
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        
        child: Expanded(
          child: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
              child: Column(
                children: [
                  TextFormField(
                    style: GoogleFonts.poppins(
                        fontSize: 28, color: whiteColor, fontWeight: light),
                    decoration: InputDecoration.collapsed(
                        hintText: "Project Title",
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 28,
                            color: secondaryTextColor,
                            fontWeight: light)),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    style: GoogleFonts.poppins(
                        fontSize: 20, color: whiteColor, fontWeight: light),
                    decoration: InputDecoration.collapsed(
                        hintText: "Description",
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 20,
                            color: secondaryTextColor,
                            fontWeight: light)),
                  ),
                  const SizedBox(height: 30),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _timeline.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          child: TimelineTile(
                            isFirst: _timeline.length - index == _timeline.length
                                ? true
                                : false,
                            isLast: _timeline.length - index == 1 ? true : false,
                            indicatorStyle: IndicatorStyle(color: primaryColor, ),
                            afterLineStyle:
                                LineStyle(color: primaryColor.withAlpha(50)),
                            beforeLineStyle:
                                LineStyle(color: primaryColor.withAlpha(50)),
                            endChild: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (contex) {
                                      return AlertDialog(
                                        title: CostumText(
                                          text: "Edit Timeline",
                                          color: whiteColor,
                                          fontWeight: light,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        actionsPadding: EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: defaultMargin * 2,
                                            bottom: 20),
                                        backgroundColor: bgColor4,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 30),
                                        actions: [
                                          InkWell(
                                            onTap: () => Navigator.pop(context),
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 16),
                                              decoration: BoxDecoration(
                                                  color: secondaryTextColor,
                                                  borderRadius:
                                                      BorderRadius.circular(12)),
                                              child: CostumText(
                                                  text: "Cancel",
                                                  color: whiteColor),
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                _timeline = delete(index);
                                              });
                        
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 16, vertical: 16),
                                              decoration: BoxDecoration(
                                                  color: allertColor,
                                                  borderRadius:
                                                      BorderRadius.circular(12)),
                                              child: CostumText(
                                                  text: "Delete Timeline",
                                                  color: whiteColor),
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              },
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: defaultMargin, bottom: 20, top: 20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 20),
                                  decoration: BoxDecoration(
                                      color: bgColor4,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: whiteColor)),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CostumText(
                                        text: _timeline[index].title,
                                        color: whiteColor,
                                        fontSize: 20,
                                        fontWeight: light,
                                      ),
                                      const SizedBox(height: 8),
                                      CostumText(
                                        text: _timeline[index].description,
                                        color: secondaryTextColor,
                                        fontSize: 14,
                                        fontWeight: light,
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        );
                      }),
                  Visibility(
                    visible: _timeline.isEmpty ? false : true,
                    child: ExpandedButton(
                        text: "Save",
                        isLoading: false,
                        textColor: whiteColor,
                        buttonColor: primaryColor,
                        loadingButtonColor: primaryColor.withOpacity(.8),
                        textStyle: poppinsWhite,
                        onTap: () {
                          addProject();
              
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
