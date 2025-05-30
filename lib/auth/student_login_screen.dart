import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:school_management/screens/add_complain_box_screen.dart';
import 'package:school_management/screens/view_fee_screen.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';
import 'package:school_management/utils/string_constants.dart';
import 'provider/login_provider.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
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

                  const SizedBox(height: 20),
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
                  const SizedBox(height: 40),
                  loginProvider.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () async {
                      final mobile = _mobileController.text.trim();
                      final password = _passwordController.text.trim();

                      final success = await loginProvider.login(mobile: mobile, password: password);

                      if (context.mounted) {
                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => const ViewFeeScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(loginProvider.error ?? "Invalid mobile number or password"),
                              backgroundColor: Colors.red,
                            ),
                          );

                        }
                      }
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
      ),
    );
  }

}
