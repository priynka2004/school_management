// screens/view_fee_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/provider/fee_provider.dart';
import 'package:school_management/utils/app_text_styles.dart';
import 'package:school_management/utils/colors.dart';
import 'package:school_management/utils/images_const.dart';
import 'package:school_management/utils/string_constants.dart';

class ViewFeeScreen extends StatefulWidget {
  const ViewFeeScreen({super.key});

  @override
  State<ViewFeeScreen> createState() => _ViewFeeScreenState();
}

class _ViewFeeScreenState extends State<ViewFeeScreen> {
  @override
  void initState() {
    super.initState();
    final feeProvider = Provider.of<FeeProvider>(context, listen: false);
    final parentId = 1;

    feeProvider.loadSessions();
    feeProvider.loadStudentNames(parentId);

    feeProvider.setParentId(parentId);

  }


  @override
  Widget build(BuildContext context) {
    final feeProvider = Provider.of<FeeProvider>(context);
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 30),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: AppStrings.session,
                    labelStyle: AppTextStyles.labelsText,
                    filled: true,
                    fillColor: AppColors.grey,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: AppColors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color:AppColors.appColor, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    prefixIcon: Icon(Icons.calendar_today_outlined, color: AppColors.appColor),
                  ),
                  dropdownColor: AppColors.white,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  borderRadius: BorderRadius.circular(12),
                  elevation: 6,
                  value: feeProvider.selectedSession,
                  items: feeProvider.sessions.map((session) {
                    return DropdownMenuItem(
                      value: session,
                      child: Text(
                        session,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      feeProvider.setSelectedSession(value);
                    }
                  },
                ),

                const SizedBox(height: 20),


                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: AppStrings.selectStudent,
                    labelStyle: AppTextStyles.labelsText,
                    filled: true,
                    fillColor: AppColors.grey,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color:AppColors.grey, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: AppColors.appColor, width: 1.5),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    prefixIcon: Icon(Icons.person_outline, color: AppColors.appColor),
                  ),
                  dropdownColor: AppColors.white,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                  borderRadius: BorderRadius.circular(12),
                  elevation: 6,
                  value: feeProvider.selectedStudent,
                  items: feeProvider.students.map((student) {
                    return DropdownMenuItem(
                      value: student,
                      child: Text(
                        student,
                        style: const TextStyle(fontSize: 16),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      feeProvider.setSelectedStudent(value);
                    }
                  },
                ),



              ],
            ),
          ),
        ],
      ),
    );
  }
}
