import 'package:flutter/material.dart';
import 'package:school_management/auth/TeacherLoginScreen.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';
import 'package:school_management/utils/string_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

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
                      Image.asset(AppImagesConst.vectorImagePath2),
                      Padding(
                        padding: const EdgeInsets.only(top: 50, left: 40),
                        child: Image.asset(
                          AppImagesConst.rectangleImagePath,
                          height: 108,
                          width: 133,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: AppStrings.username,
                    hintStyle: AppTextStyles.hintStyle,
                    suffixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: AppStrings.password,
                    hintStyle: AppTextStyles.hintStyle,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TeacherLoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                    backgroundColor: AppColors.black,
                    foregroundColor: AppColors.white,
                  ),
                  child: const Text(
                    AppStrings.login,
                    style: AppTextStyles.loginButton,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  AppStrings.forgotPassword,
                  style: AppTextStyles.forgotPassword,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



// @override
// void initState() {
//   super.initState();
//   Timer(const Duration(seconds: 5), () {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const ChooseYourOptionScreen()),
//     );
//   });
// }