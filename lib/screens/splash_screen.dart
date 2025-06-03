import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_management/screens/ChooseYourOptionScreen.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/images_const.dart';
import 'package:school_management/utils/string_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ChooseYourOptionScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: screenHeight * 0.22,
                width: screenWidth,
                child: Image.asset(
                  AppImagesConst.vectorImagePath,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: screenHeight * 0.07,
                left: screenWidth * 0.5 - (screenWidth * 0.12),
                child: Image.asset(
                  AppImagesConst.studentImagePath,
                  height: screenHeight * 0.11,
                  width: screenWidth * 0.24,
                ),
              ),
            ],
          ),

          SizedBox(height: screenHeight * 0.08),

          // Middle rectangle image
          Center(
            child: Image.asset(
              AppImagesConst.rectangleImagePath,
              height: screenHeight * 0.28,
              width: screenWidth * 0.4,
              fit: BoxFit.contain,
            ),
          ),

          const Spacer(),

          // Bottom Stack with black vector and powered by text
          Stack(
            children: [
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.18,
                child: Image.asset(
                  AppImagesConst.blackVectorImagePath,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: screenHeight * 0.06,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    AppStrings.poweredBy,
                    style: AppTextStyles.poweredByText,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
