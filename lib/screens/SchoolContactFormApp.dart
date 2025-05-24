import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';
import 'package:school_management/utils/string_constants.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({super.key});

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController1 = TextEditingController();
  final TextEditingController classController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController rollNoController = TextEditingController();
  final TextEditingController emailController2 = TextEditingController();

  File? _selectedImage;

  Future<void> _pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                           Positioned(
                            top: 60,
                            left: 75,
                            child: Image.asset(
                              AppImagesConst.unionImagePath,
                              height: 60,
                              width: 60,
                            ),
                          ),
                          Positioned(
                            top: 90,
                            left: 40,
                            child: GestureDetector(
                              onTap: _pickImageFromCamera,
                              child: _selectedImage == null
                                  ? Image.asset(
                                AppImagesConst.photoImagePath,
                                height: 108,
                                width: 133,
                              )
                                  : ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  _selectedImage!,
                                  height: 108,
                                  width: 133,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildTextField(AppStrings.fullName, nameController),
              const SizedBox(height: 12),
              _buildTextField(AppStrings.email, emailController1),
              const SizedBox(height: 12),
              _buildTextField(AppStrings.className, classController),
              const SizedBox(height: 12),
              _buildTextField(AppStrings.section, sectionController),
              const SizedBox(height: 12),
              _buildTextField(AppStrings.rollNo, rollNoController),
              const SizedBox(height: 12),
              _buildTextField(AppStrings.alternateEmail, emailController2),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Add contact logic here
                    },
                    child: const Text(
                      AppStrings.addToContact,
                      style: AppTextStyles.buttonText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.labelText),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: AppStrings.enterSomething,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }
}
