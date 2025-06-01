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
      body:Consumer<StudentDashboardProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.students.isEmpty) {
            return const Center(child: Text("No students found"));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: provider.students.length,
            itemBuilder: (context, index) {
              final student = provider.students[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blueGrey,
                            child: Icon(
                              Icons.person,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),

                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  student.name,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 6),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetail('Class & Section', student.classSection),
                          _buildDetail('Admission No.', student.admissionNumber),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetail('Mobile No.', student.mobileNumber),
                          _buildDetail('Date of Birth', student.dob),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: 150,
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
                            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'View Profile',
                            style: TextStyle(fontSize: 14, color: AppColors.black),
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
      )


    );
  }
  Widget _buildDetail(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value),
      ],
    );
  }

}

