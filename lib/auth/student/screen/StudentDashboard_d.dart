import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/student/screen/student_view_profile.dart';
import 'package:school_management/provider/student_dashboard_provider.dart';
import 'package:school_management/utils/colors.dart';

class StudentDashboardD extends StatefulWidget {
  const StudentDashboardD({super.key});

  @override
  State<StudentDashboardD> createState() => _StudentDashboardDState();
}

class _StudentDashboardDState extends State<StudentDashboardD> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<StudentDashboardProvider>(context, listen: false).loadStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery for screen size
    final media = MediaQuery.of(context);
    final screenWidth = media.size.width;
    final screenHeight = media.size.height;

    // Adjust sizes based on screen width
    final avatarRadius = screenWidth * 0.07; // ~7% of screen width
    final paddingAll = screenWidth * 0.03; // ~3% padding
    final buttonWidth = screenWidth * 0.4; // ~40% of screen width
    final fontSizeTitle = screenWidth * 0.045; // title font size
    final fontSizeButton = screenWidth * 0.038; // button text font size
    final spacingVertical = screenHeight * 0.015;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Student Dashboard'),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.west, color: AppColors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: Consumer<StudentDashboardProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.students.isEmpty) {
            return const Center(child: Text("No students found"));
          }

          return ListView.builder(
            padding: EdgeInsets.all(paddingAll),
            itemCount: provider.students.length,
            itemBuilder: (context, index) {
              final student = provider.students[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: spacingVertical),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: EdgeInsets.all(paddingAll),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: avatarRadius,
                            backgroundColor: Colors.blueGrey,
                            child: Icon(
                              Icons.person,
                              size: avatarRadius * 1.2,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student.name,
                                  style: TextStyle(
                                    fontSize: fontSizeTitle,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: spacingVertical * 0.6),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.03,
                                    vertical: screenHeight * 0.005,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: const Text(
                                    'Active',
                                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: spacingVertical * 1.5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetail('Class & Section', student.classSection, fontSizeTitle * 0.85),
                          _buildDetail('Admission No.', student.admissionNumber, fontSizeTitle * 0.85),
                        ],
                      ),
                      SizedBox(height: spacingVertical),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetail('Mobile No.', student.mobileNumber, fontSizeTitle * 0.85),
                          _buildDetail('Date of Birth', student.dob, fontSizeTitle * 0.85),
                        ],
                      ),
                      SizedBox(height: spacingVertical * 1.5),
                      SizedBox(
                        width: buttonWidth,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StudentViewProfile(student: student),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.appColor,
                            padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.015,
                              horizontal: screenWidth * 0.03,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'View Profile',
                            style: TextStyle(fontSize: fontSizeButton, color: AppColors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDetail(String title, String value, double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize)),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: fontSize * 0.9)),
      ],
    );
  }
}
