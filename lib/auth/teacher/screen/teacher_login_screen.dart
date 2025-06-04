import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/teacher/provider/teacher_login_provider.dart';
import 'package:school_management/screens/dashboard_student.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';
import 'package:school_management/utils/string_constants.dart';

class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({super.key});

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends State<TeacherLoginScreen> {
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<TeacherLoginProvider>(context);

    // Get MediaQuery data
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final paddingHorizontal = screenWidth * 0.06; // ~6% horizontal padding
    final verticalSpacing = screenHeight * 0.025; // ~2.5% vertical spacing
    final buttonHeight = screenHeight * 0.065; // 6.5% of screen height

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
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: Column(
                children: [
                  TextField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: const InputDecoration(
                      labelText: AppStrings.mobile,
                      suffixIcon: Icon(Icons.person),
                      counterText: '', // Hide the character counter
                    ),
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  SizedBox(height: verticalSpacing),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: AppStrings.password,
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
                  SizedBox(height: verticalSpacing * 1.6),
                  loginProvider.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () async {
                      final mobile = _mobileController.text.trim();
                      final password = _passwordController.text.trim();

                      final success = await loginProvider.loginTeacher(
                        mobile,
                        password,
                      );

                      if (context.mounted) {
                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DashboardStudent(),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(loginProvider.error ??
                                  "Invalid mobile number or password"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, buttonHeight),
                      backgroundColor: AppColors.black,
                      foregroundColor: AppColors.white,
                    ),
                    child: const Text(
                      AppStrings.login,
                      style: AppTextStyles.loginButton,
                    ),
                  ),
                  // SizedBox(height: verticalSpacing * 0.4),
                  // const Text(
                  //   AppStrings.forgotPassword,
                  //   style: AppTextStyles.forgotPassword,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
