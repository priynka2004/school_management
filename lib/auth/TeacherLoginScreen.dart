import 'package:flutter/material.dart';
import 'package:school_management/screens/SchoolContactFormApp.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';
import 'package:school_management/utils/string_constants.dart';

class TeacherLoginScreen extends StatelessWidget {
  const TeacherLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(AppImagesConst.vectorImagePath),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Center(
                    child: Stack(
                      children: [
                        Image.asset(AppImagesConst.vectorImagePath2),
                      ],
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
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: AppColors.white,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppStrings.passage,
                              style: AppTextStyles.passage,
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(height: 16),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      Image.asset(AppImagesConst.guestImagePath),
                      Image.asset(AppImagesConst.guestImagePath2),
                      Image.asset(AppImagesConst.guestImagePath3),
                      Image.asset(AppImagesConst.guestImagePath4),
                      Image.asset(AppImagesConst.guestImagePath5),
                      Image.asset(
                        AppImagesConst.guestImagePath6,
                        height: 130,
                        width: 100,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ContactFormScreen();
                            }));
                          },
                          child: Image.asset(AppImagesConst.guestImagePath7)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
