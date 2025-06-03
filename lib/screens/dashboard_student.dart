import 'package:flutter/material.dart';
import 'package:school_management/screens/homework_screen.dart';
import 'package:school_management/screens/school_contact_form_screen.dart';
import 'package:school_management/screens/student_attendance.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';
import 'package:school_management/utils/string_constants.dart';
import 'package:school_management/widget/student_drawer.dart';

class DashboardStudent extends StatefulWidget {
  const DashboardStudent({super.key});

  @override
  State<DashboardStudent> createState() => _DashboardStudentState();
}

class _DashboardStudentState extends State<DashboardStudent> {
  bool isLeaveExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: const StudentDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child:   Image.asset(
                    AppImagesConst.vectorImagePath,
                    height: MediaQuery.of(context).size.height * 0.25, // 25% of screen height
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 22),
                  child: Builder(
                    builder: (context) => GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: const Icon(Icons.menu, color: Colors.white, size: 30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 60,left: 75),
                  child: Image.asset(AppImagesConst.vectorImagePath2,
                    height: 260,
                    width: 240,
                    fit: BoxFit.contain,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 112),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 112),
                      child: Image.asset(
                        AppImagesConst.emojiImagePath,
                        width: MediaQuery.of(context).size.width * 0.4,   // 40% of screen width
                        height: MediaQuery.of(context).size.width * 0.4,  // width के proportion में height (square shape)
                        fit: BoxFit.contain,
                      ),

                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    color: AppColors.appColor,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                AppStrings.welcome,
                                style: AppTextStyles.welText,
                              ),
                            ),
                            const Icon(Icons.arrow_forward_rounded, color: AppColors.white),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(AppStrings.passage, style: AppTextStyles.passage),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentAttendanceReport()),
                          );
                        },
                        child: Image.asset(AppImagesConst.guestImagePath),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => HomeworkScreen()),
                        ),
                        child: Image.asset(AppImagesConst.guestImagePath2),
                      ),
                      Image.asset(AppImagesConst.guestImagePath3),
                      Image.asset(AppImagesConst.guestImagePath4),
                      Image.asset(AppImagesConst.guestImagePath5),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => SchoolContactFormScreen()),
                        ),
                        child: Image.asset(AppImagesConst.guestImagePath7),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}