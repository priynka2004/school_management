import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/student/provider/student_login_provider.dart';
import 'package:school_management/auth/student/screen/student_login_screen.dart';
import 'package:school_management/auth/parent/screen/parent_profile_screen.dart';
import 'package:school_management/auth/teacher/provider/teacher_login_provider.dart';
import 'package:school_management/auth/teacher/screen/teacher_login_screen.dart';
import 'package:school_management/screens/dashboard_student.dart';
import 'package:school_management/screens/teacher/dashboard_teacher_screen.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';
import 'package:school_management/utils/string_constants.dart';

class ChooseYourOptionScreen extends StatefulWidget {
  const ChooseYourOptionScreen({super.key});

  @override
  State<ChooseYourOptionScreen> createState() => _ChooseYourOptionScreenState();
}

class _ChooseYourOptionScreenState extends State<ChooseYourOptionScreen> {

  @override
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StudentLoginProvider>(context, listen: false).checkLoginStatus();
      Provider.of<TeacherLoginProvider>(context, listen: false).checkLoginStatus();
    });
  }



  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImagesConst.vectorImagePath,
                  width: screenWidth,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.04),
                  child: Center(
                    child: Stack(
                      children: [
                        Image.asset(
                          AppImagesConst.vectorImagePath2,
                          width: screenWidth * 0.6,
                          fit: BoxFit.contain,
                        ),
                        Positioned(
                          top: screenHeight * 0.06,
                          left: screenWidth * 0.1,
                          child: Image.asset(
                            AppImagesConst.rectangleImagePath,
                            height: screenHeight * 0.15,
                            width: screenWidth * 0.4,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.025),
            Text(AppStrings.choose, style: AppTextStyles.appText),
            SizedBox(height: screenHeight * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _OptionCard(
                  imagePath: AppImagesConst.maleImagePath,
                  label: AppStrings.student,
                  width: screenWidth * 0.25,
                  height: screenHeight * 0.12,
                  onTap: () {
                    final studentProvider = Provider.of<StudentLoginProvider>(
                        context,
                        listen: false);

                    if (studentProvider.isLoggedIn) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DashboardStudent()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const StudentLoginScreen()),
                      );
                    }
                  },
                ),
                SizedBox(width: screenWidth * 0.1),
                _OptionCard(
                  imagePath: AppImagesConst.tuitionImagePath,
                  label: AppStrings.teacher,
                  width: screenWidth * 0.25,
                  height: screenHeight * 0.12,
                  onTap: () {
                    final teacherProvider = Provider.of<TeacherLoginProvider>(
                        context,
                        listen: false);

                    if (teacherProvider.isLoggedIn) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const DashboardTeacherScreen()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TeacherLoginScreen()),
                      );
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.025),
            // Center(
            //   child: _OptionCard(
            //     imagePath: AppImagesConst.personImagePath,
            //     label: AppStrings.parent,
            //     width: screenWidth * 0.25,
            //     height: screenHeight * 0.12,
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (_) => ParentProfileScreen(
            //             parentId: 1,
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback? onTap;
  final double width;
  final double height;

  const _OptionCard({
    required this.imagePath,
    required this.label,
    this.onTap,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: AppColors.appColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.2),
              child: Image.asset(
                imagePath,
                height: height * 0.5,
                width: width * 0.5,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: height * 0.08),
          Text(
            label,
            style: AppTextStyles.labelsText,
          ),
        ],
      ),
    );
  }
}