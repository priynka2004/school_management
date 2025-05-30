import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/parent/model/parent_profile.dart';
import 'package:school_management/auth/parent/provider/parent_profile_provider.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';
import 'package:school_management/utils/string_constants.dart';

class EditParentProfileSheet extends StatefulWidget {
  final ParentProfile? profile;

  const EditParentProfileSheet({super.key, required this.profile});

  @override
  State<EditParentProfileSheet> createState() => _EditParentProfileSheetState();
}

class _EditParentProfileSheetState extends State<EditParentProfileSheet> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController addressController;
  late TextEditingController mobileController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile?.name);
    emailController = TextEditingController(text: widget.profile?.email);
    passwordController = TextEditingController(text: widget.profile?.password);
    addressController = TextEditingController(text: widget.profile?.address);
    mobileController = TextEditingController(text: widget.profile?.mobile);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ParentProfileProvider>(context);

    return Material(
      child: SingleChildScrollView(
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
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 20,
                left: 20,
                right: 20,
              ),
              child: Column(
                children: [
                  TextField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: "Name")),
                  TextField(
                      controller: emailController,
                      decoration: InputDecoration(labelText: "Email")),
                  TextField(
                      controller: passwordController,
                      decoration: InputDecoration(labelText: "Password")),
                  TextField(
                      controller: addressController,
                      decoration: InputDecoration(labelText: "Address")),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(45),
                      backgroundColor: AppColors.black,
                      foregroundColor: AppColors.white,
                    ),
                    onPressed: () async {
                      final updated = ParentProfile(
                        id: widget.profile!.id,
                        name: nameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        address: addressController.text,
                        mobile: mobileController.text,
                      );
                      final success = await provider.updateProfile(updated);
                      if (success && context.mounted) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Profile updated successfully")));
                      }
                    },
                    child: Text(
                      AppStrings.save,
                      style: AppTextStyles.loginButton,
                    ),
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
