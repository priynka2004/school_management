import 'package:flutter/material.dart';
import 'package:school_management/model/student_dashboard_model.dart';
import 'package:school_management/utils/colors.dart';

class StudentViewProfile extends StatelessWidget {
  final StudentDetailModel student;

  const StudentViewProfile({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    // Fetch screen size info
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    // Define scaling factors based on screen size (adjust as needed)
    final double horizontalPadding =
        screenWidth * 0.04; // ~4% padding horizontally
    final double verticalPadding =
        screenHeight * 0.02; // ~2% padding vertically
    final double avatarRadius =
        screenWidth * 0.1; // Avatar radius 10% of screen width
    final double titleFontSize =
        screenWidth * 0.06; // Title font size ~6% of screen width
    final double sectionTitleFontSize =
        screenWidth * 0.05; // Section title font size

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Student Profile'),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.west, color: AppColors.white),
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
                    backgroundImage: student.photo.isNotEmpty
                        ? NetworkImage(student.photo) as ImageProvider
                        : const AssetImage('assets/images/user.png'),
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name,
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

            // Section Title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Student Details",
                style: TextStyle(
                  fontSize: sectionTitleFontSize,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appColor,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.015),

            // Detail Fields
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
                  _buildInfoRow(
                      "Admission Number", student.admissionNumber, screenWidth),
                  _buildDivider(),
                  _buildInfoRow(
                      "Class & Section", student.classSection, screenWidth),
                  _buildDivider(),
                  _buildInfoRow(
                      "Admission Date", student.admissionDate, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Session", student.session, screenWidth),
                  _buildDivider(),
                  _buildInfoRow(
                      "Email Address", student.emailAddress, screenWidth),
                  _buildDivider(),
                  _buildInfoRow(
                      "Mobile Number", student.mobileNumber, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Father Name", student.fatherName, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Mother Name", student.motherName, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Date of Birth", student.dob, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Branch", student.branch, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Gender", student.gender, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Alternate Mobile", student.altMobileNumber, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("House", student.house, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Parent Occupation", student.parentOccupation,
                      screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Blood Group", student.bloodGroup, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Category", student.category, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Religion", student.religion, screenWidth),
                  _buildDivider(),
                  _buildInfoRow(
                      "Aadhar Number", student.aadharNumber, screenWidth),
                  _buildDivider(),
                  _buildInfoRow(
                      "Current Address", student.currentAddress, screenWidth),
                  _buildDivider(),
                  _buildInfoRow("Permanent Address", student.permanentAddress,
                      screenWidth),
                  _buildDivider(),
                  _buildInfoRow(
                      "Previous School", student.previousSchool, screenWidth),
                  _buildDivider(),
                  _buildInfoRow(
                      "Previous Class", student.previousClass, screenWidth),
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
