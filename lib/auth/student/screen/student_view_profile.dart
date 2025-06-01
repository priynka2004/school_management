import 'package:flutter/material.dart';
import 'package:school_management/model/student_dashboard_model.dart';
import 'package:school_management/utils/colors.dart';

class StudentViewProfile extends StatelessWidget {
  final StudentDetailModel student;

  const StudentViewProfile({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
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
                    radius: 40,
                    backgroundImage: student.photo.isNotEmpty
                        ? NetworkImage(student.photo) as ImageProvider
                        : const AssetImage('assets/images/user.png'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Active',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Section Title
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Student Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.appColor,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Detail Fields
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildInfoRow("Email Address", student.emailAddress),
                  _buildDivider(),
                  _buildInfoRow("Mobile Number", student.mobileNumber),
                  _buildDivider(),
                  _buildInfoRow("Alternate Mobile", student.altMobileNumber),
                  _buildDivider(),
                  _buildInfoRow("Admission Number", student.admissionNumber),
                  _buildDivider(),
                  _buildInfoRow("Admission Date", student.admissionDate),
                  _buildDivider(),
                  _buildInfoRow("Branch", student.branch),
                  _buildDivider(),
                  _buildInfoRow("Session", student.session),
                  _buildDivider(),
                  _buildInfoRow("Class & Section", student.classSection),
                  _buildDivider(),
                  _buildInfoRow("House", student.house),
                  _buildDivider(),
                  _buildInfoRow("Father Name", student.fatherName),
                  _buildDivider(),
                  _buildInfoRow("Mother Name", student.motherName),
                  _buildDivider(),
                  _buildInfoRow("Parent Occupation", student.parentOccupation),
                  _buildDivider(),
                  _buildInfoRow("Date of Birth", student.dob),
                  _buildDivider(),
                  _buildInfoRow("Gender", student.gender),
                  _buildDivider(),
                  _buildInfoRow("Blood Group", student.bloodGroup),
                  _buildDivider(),
                  _buildInfoRow("Category", student.category),
                  _buildDivider(),
                  _buildInfoRow("Religion", student.religion),
                  _buildDivider(),
                  _buildInfoRow("Aadhar Number", student.aadharNumber),
                  _buildDivider(),
                  _buildInfoRow("Current Address", student.currentAddress),
                  _buildDivider(),
                  _buildInfoRow("Permanent Address", student.permanentAddress),
                  _buildDivider(),
                  _buildInfoRow("Previous School", student.previousSchool),
                  _buildDivider(),
                  _buildInfoRow("Previous Class", student.previousClass),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              "$title:",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
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
