import 'package:flutter/material.dart';
import 'package:school_management/auth/student_login_screen.dart';
import 'package:school_management/auth/parent/screen/parent_profile_screen.dart';
import 'package:school_management/auth/provider/teacher_login_provider.dart';
import 'package:school_management/auth/teacher_login_screen.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(AppImagesConst.vectorImagePath),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Stack(
                    children: [
                      Image.asset(
                        AppImagesConst.vectorImagePath2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, left: 40),
                        child: Image.asset(AppImagesConst.rectangleImagePath,
                            height: 108, width: 133),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(AppStrings.choose, style: AppTextStyles.appText),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _OptionCard(
                imagePath: AppImagesConst.maleImagePath,
                label: AppStrings.student,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const StudentLoginScreen()),
                  );
                },
              ),
              const SizedBox(width: 80),
              _OptionCard(
                imagePath: AppImagesConst.tuitionImagePath,
                label: AppStrings.teacher,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TeacherLoginScreen()),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _OptionCard(
                imagePath: AppImagesConst.personImagePath,
                label: AppStrings.guest,
              ),
              const SizedBox(width: 80),
              _OptionCard(
                imagePath: AppImagesConst.maleImagePath,
                label: AppStrings.profile,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ParentProfileScreen(
                        parentId: 1,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),

          // const Center(
          //   child: _OptionCard(
          //     imagePath:AppImagesConst.personImagePath,
          //     label: AppStrings.guest,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback? onTap;

  const _OptionCard({
    required this.imagePath,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppColors.appColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset(
                imagePath,
                height: 60,
                width: 60,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppTextStyles.labelsText,
          ),
        ],
      ),
    );
  }
}
