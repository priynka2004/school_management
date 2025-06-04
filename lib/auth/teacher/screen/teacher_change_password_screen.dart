import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/teacher/provider/teacher_login_provider.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';

class TeacherChangePasswordScreen extends StatefulWidget {
  const TeacherChangePasswordScreen({super.key});

  @override
  State<TeacherChangePasswordScreen> createState() => _TeacherChangePasswordScreenState();
}

class _TeacherChangePasswordScreenState extends State<TeacherChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeacherLoginProvider>(context);
    final media = MediaQuery.of(context);

    final screenWidth = media.size.width;
    final screenHeight = media.size.height;
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

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
            SizedBox(height: size.height * 0.03),  // responsive spacing
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06), // responsive horizontal padding
              child: Column(
                children: [
                  TextField(
                    controller: _oldPasswordController,
                    obscureText: _obscureOld,
                    decoration: InputDecoration(
                      labelText: 'Old Password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureOld ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() => _obscureOld = !_obscureOld);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextField(
                    controller: _newPasswordController,
                    obscureText: _obscureNew,
                    decoration: InputDecoration(
                      labelText: 'New Password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureNew ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() => _obscureNew = !_obscureNew);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirm,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                        icon: Icon(_obscureConfirm ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() => _obscureConfirm = !_obscureConfirm);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  ElevatedButton(
                    onPressed: () async {
                      final oldPass = _oldPasswordController.text.trim();
                      final newPass = _newPasswordController.text.trim();
                      final confirmPass = _confirmPasswordController.text.trim();

                      if (newPass != confirmPass) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Passwords do not match")),
                        );
                        return;
                      }

                      final success = await provider.changePassword(oldPass, newPass);
                      if (success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Password changed successfully")),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(provider.error ?? "Failed to change password")),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, size.height * 0.06),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      "Change Password",
                      style: TextStyle(fontSize: size.height * 0.022),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),  // bottom padding
          ],
        ),
      ),
    );
  }
}
