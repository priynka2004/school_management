import 'package:flutter/material.dart';
import 'package:school_management/screens/school_contact_form_screen.dart';
import 'package:school_management/screens/homework_screen.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';
import 'package:school_management/utils/string_constants.dart';

class FormFillScreen extends StatelessWidget {
  const FormFillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  AppImagesConst.vectorImagePath,
                  width: screenWidth,
                  height: screenHeight * 0.22,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.04),
                  child: Center(
                    child: Stack(
                      children: [
                        Image.asset(
                          AppImagesConst.vectorImagePath2,
                          width: screenWidth * 0.5,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
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
                              padding: EdgeInsets.all(screenWidth * 0.02),
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
                          padding: EdgeInsets.all(screenWidth * 0.02),
                          child: Text(
                            AppStrings.passage,
                            style: AppTextStyles.passage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    mainAxisSpacing: screenWidth * 0.03,
                    crossAxisSpacing: screenWidth * 0.03,
                    children: [
                      Image.asset(AppImagesConst.guestImagePath),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return HomeworkScreen();
                              }));
                        },
                        child: Image.asset(AppImagesConst.guestImagePath2),
                      ),
                      Image.asset(AppImagesConst.guestImagePath3),
                      Image.asset(AppImagesConst.guestImagePath4),
                      Image.asset(AppImagesConst.guestImagePath5),
                      Image.asset(
                        AppImagesConst.guestImagePath6,
                        height: screenHeight * 0.17,
                        width: screenWidth * 0.25,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                                return SchoolContactFormScreen();
                              }));
                        },
                        child: Image.asset(AppImagesConst.guestImagePath7),
                      ),
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
