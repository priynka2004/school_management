import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/student/screen/StudentDashboard_d.dart';
import 'package:school_management/auth/teacher/provider/teacher_login_provider.dart';
import 'package:school_management/auth/teacher/screen/teacher_change_password_screen.dart';
import 'package:school_management/auth/teacher/screen/teacher_profile_screen.dart';
import 'package:school_management/screens/ChooseYourOptionScreen.dart';
import 'package:school_management/screens/add_complain_box_screen.dart';
import 'package:school_management/screens/add_leave_screen.dart';
import 'package:school_management/screens/leave_list.dart';
import 'package:school_management/screens/student_attendance.dart';
import 'package:school_management/screens/teacher/dashboard_teacher_screen.dart';
import 'package:school_management/screens/teacher/teacher_live_list_screen.dart';
import 'package:school_management/screens/view_fee_screen.dart';
import 'package:school_management/screens/view_notice_screen.dart';
import 'package:school_management/utils/colors.dart';

class TeacherDrawer extends StatefulWidget {
  const TeacherDrawer({super.key});

  @override
  State<TeacherDrawer> createState() => _TeacherDrawerState();
}

class _TeacherDrawerState extends State<TeacherDrawer> {
  bool isLeaveExpanded = false;

  Widget _buildDrawerTile(
      IconData icon,
      String title, {
        VoidCallback? onTap,
        bool isExpandable = false,
        bool isExpanded = false,
      }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: isExpandable
          ? Icon(
        isExpanded ? Icons.expand_less : Icons.expand_more,
        color: Colors.white,
      )
          : null,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: AppColors.appColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 26),

            _buildDrawerTile(
              Icons.home,
              'Dashboard',
                onTap: () {
                  final loginProvider = Provider.of<TeacherLoginProvider>(context, listen: false);
                  final teacher = loginProvider.teacher;
                  print("Teacher object: $teacher");

                  if (teacher != null && teacher.id != null && teacher.branchId != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TeacherProfileScreen(
                          teacherId: teacher.id!,
                          branchId: teacher.branchId!,
                        ),
                      ),
                    );
                  } else {
                    print('Teacher object is null or missing IDs');
                  }
                }


            ),

            _buildDrawerTile(Icons.receipt, 'View Fee',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ViewFeeScreen()),
                );
              },),
            _buildDrawerTile(
              Icons.menu_book,
              'View Notice',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ViewNoticeScreen()),
                );
              },
            ),

            _buildDrawerTile(Icons.chat_bubble_outline, 'Complain Box',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddComplainBoxScreen()),
                );
              },),
            _buildDrawerTile(Icons.vpn_key, 'Change Password',
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TeacherChangePasswordScreen()),
                );
              },),
            _buildDrawerTile(Icons.view_list, 'Attendance Report', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StudentAttendanceReport()),
              );
            }),


            _buildDrawerTile(
              Icons.calendar_today,
              'Apply For Leave',
              isExpandable: true,
              isExpanded: isLeaveExpanded,
              onTap: () {
                setState(() {
                  isLeaveExpanded = !isLeaveExpanded;
                });
              },
            ),

            if (isLeaveExpanded)
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.add, color: Colors.white),
                      title: const Text('Add Leave', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const AddLeaveScreen()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.list, color: Colors.white),
                      title: const Text('Leave List', style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TeacherLeaveListScreen(
                              teacherID: 1,
                              branchID: 1,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

            const Divider(
              color: Colors.white38,
              thickness: 1,
              indent: 16,
              endIndent: 16,
              height: 32,
            ),

            _buildDrawerTile(Icons.logout, 'Sign Out', onTap: () async {
              final provider = Provider.of<TeacherLoginProvider>(context, listen: false);
              await provider.logout();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const ChooseYourOptionScreen()),
                    (route) => false,
              );
            }),

          ],
        ),
      ),
    );
  }
}


