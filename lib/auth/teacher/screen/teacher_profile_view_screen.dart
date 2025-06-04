import 'package:flutter/material.dart';
import 'package:school_management/auth/teacher/model/teacher_profile_model.dart';
import 'package:school_management/utils/colors.dart';

class TeacherViewProfileScreen extends StatelessWidget {
  final TeacherProfileModel teacherProfileModel;

  const TeacherViewProfileScreen({super.key, required this.teacherProfileModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    final double horizontalPadding = screenWidth * 0.04;
    final double verticalPadding = screenHeight * 0.02;
    final double avatarRadius = screenWidth * 0.1;
    final double titleFontSize = screenWidth * 0.06;
    final double sectionTitleFontSize = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Teacher View Profile'),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(horizontalPadding),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(horizontalPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundImage: teacherProfileModel.photo.isNotEmpty
                        ? NetworkImage(teacherProfileModel.photo) as ImageProvider
                        : const AssetImage('assets/images/user.png'),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          teacherProfileModel.name,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.008),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * 0.005,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Active',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.035,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Teacher Details",
                style: TextStyle(
                  fontSize: sectionTitleFontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appColor,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),

            Container(
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding,
                horizontal: horizontalPadding * 0.5,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildInfoRow("Admission Number", teacherProfileModel.admissionNumber, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Class & Section", teacherProfileModel.classSection, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Admission Date", teacherProfileModel.admissionDate, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Session", teacherProfileModel.session, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Email Address", teacherProfileModel.emailAddress, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Mobile Number", teacherProfileModel.mobileNumber, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Father Name", teacherProfileModel.fatherName, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Mother Name", teacherProfileModel.motherName, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Date of Birth", teacherProfileModel.dob, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Branch", teacherProfileModel.branch, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Gender", teacherProfileModel.gender, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Alternate Mobile", teacherProfileModel.altMobileNumber, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("House", teacherProfileModel.house, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Parent Occupation", teacherProfileModel.parentOccupation, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Blood Group", teacherProfileModel.bloodGroup, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Category", teacherProfileModel.category, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Religion", teacherProfileModel.religion, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Aadhar Number", teacherProfileModel.aadharNumber, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Current Address", teacherProfileModel.currentAddress, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Permanent Address", teacherProfileModel.permanentAddress, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Previous School", teacherProfileModel.previousSchoolInfo.previousSchool, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Previous Class", teacherProfileModel.previousSchoolInfo.previousClass, screenWidth),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.015),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              "$title:",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: TextStyle(fontSize: screenWidth * 0.035),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      color: Colors.grey.shade300,
      thickness: 1,
      height: 10,
    );
  }
}
