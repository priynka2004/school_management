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
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(AppImagesConst.vectorImagePath),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Center(
                  child: Image.asset(
                    AppImagesConst.studentImagePath,
                    height: 90,
                    width: 90,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Image.asset(AppImagesConst.rectangleImagePath,
              height: 212, width: 172),
          const Spacer(),
          Stack(
            children: [
              Image.asset(AppImagesConst.blackVectorImagePath),
              const Padding(
                padding: EdgeInsets.only(top: 40),
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
