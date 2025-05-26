import 'package:flutter/material.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';
import 'package:school_management/utils/string_constants.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  void _showSubjectPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                  color: AppColors.appColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildDropdownField(
                      label: AppStrings.className,
                      items: ['1 A', '2 B', '3 C']),
                  const SizedBox(height: 12),
                  _buildDropdownField(
                      label: AppStrings.section, items: ['A', 'B', 'C']),
                  const SizedBox(height: 12),
                  _buildDropdownField(label: AppStrings.subject, items: [
                    AppStrings.math,
                    AppStrings.science,
                    AppStrings.english,
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildDropdownField(
      {required String label, required List<String> items}) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[200],
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      items: items
          .map((e) => DropdownMenuItem(
                value: e,
                child: Text(e),
              ))
          .toList(),
      onChanged: (value) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(AppImagesConst.homeworkImagePath),
        title: const Text(AppStrings.homework, style: AppTextStyles.homework),
        backgroundColor: AppColors.appColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  AppStrings.standard,
                  style: AppTextStyles.hintStyle,
                ),
                Text(
                  AppStrings.passage2,
                  style: AppTextStyles.passage2,
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _showSubjectPopup(context),
                  child: const Text(
                    AppStrings.subject,
                    style: AppTextStyles.subject,
                  ),
                ),
                // const SizedBox(height: 8),
                // DropdownButtonFormField<String>(
                //   items: [
                //     AppStrings.math,
                //     AppStrings.science,
                //     AppStrings.english,
                //   ]
                //       .map((subject) => DropdownMenuItem(
                //             value: subject,
                //             child: Text(subject),
                //           ))
                //       .toList(),
                //   onChanged: (value) {},
                //   decoration: const InputDecoration(
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                const SizedBox(height: 30),
                const Text(
                  AppStrings.addHomework,
                  style: AppTextStyles.labelsText,
                ),
                const SizedBox(height: 8),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  height: 51,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.black,
                    ),
                    child: Text(
                      AppStrings.submit,
                      style:AppTextStyles.loginButton,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: Text(
                    AppStrings.fileUploaded,
                    style: AppTextStyles.forgotPassword,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            color: AppColors.appColor,
            height: 51,
            width: 375,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(AppStrings.subject,style: AppTextStyles.subjects,),
                  Spacer(),
                  Text(AppStrings.subject,style: AppTextStyles.subjects,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
