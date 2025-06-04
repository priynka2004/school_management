import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/student/screen/student_view_profile.dart';
import 'package:school_management/auth/teacher/provider/teacher_login_provider.dart';
import 'package:school_management/auth/teacher/provider/teacher_profile_provider.dart';
import 'package:school_management/auth/teacher/screen/teacher_profile_view_screen.dart';
import 'package:school_management/provider/student_dashboard_provider.dart';
import 'package:school_management/utils/colors.dart';

class TeacherProfileScreen extends StatefulWidget {
  final int teacherId;
  final int branchId;

  const TeacherProfileScreen({
    super.key,
    required this.teacherId,
    required this.branchId,
  });

  @override
  State<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {

  @override
  void initState() {
    super.initState();

    // Use the parameters passed to this screen, not from loginProvider again
    final teacherId = widget.teacherId;
    final branchId = widget.branchId;

    if (teacherId != 0 && branchId != 0) {
      Provider.of<TeacherProfileProvider>(context, listen: false).loadTeacher(teacherId, branchId);
    } else {
      // Handle error - IDs not available
      print('TeacherId or BranchId is zero');
    }
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
        title: const Text('Teacher Dashboard'),
        backgroundColor: AppColors.appColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.west, color: AppColors.white),
        ),
        foregroundColor: Colors.white,
      ),
      body: Consumer<TeacherProfileProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.teacher.isEmpty) {
            return const Center(child: Text("No Teacher found"));
          }

          return ListView.builder(
            padding: EdgeInsets.all(paddingAll),
            itemCount: provider.teacher.length,
            itemBuilder: (context, index) {
              final teacher = provider.teacher[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: spacingVertical),
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
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
                                  teacher.name,
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
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
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
                          _buildDetail('Class & Section', teacher.classSection,
                              fontSizeTitle * 0.85),
                          _buildDetail('Admission No.', teacher.admissionNumber,
                              fontSizeTitle * 0.85),
                        ],
                      ),
                      SizedBox(height: spacingVertical),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetail('Mobile No.', teacher.mobileNumber,
                              fontSizeTitle * 0.85),
                          _buildDetail('Date of Birth', teacher.dob,
                              fontSizeTitle * 0.85),
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
                                builder: (context) => TeacherViewProfileScreen(
                                  teacherProfileModel: teacher,
                                ),
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
                            style: TextStyle(
                                fontSize: fontSizeButton,
                                color: AppColors.black),
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
        Text(title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize)),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: fontSize * 0.9)),
      ],
    );
  }
}
