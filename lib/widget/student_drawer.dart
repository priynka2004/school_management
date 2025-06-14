import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/student/screen/StudentDashboard_d.dart';
import 'package:school_management/auth/teacher/screen/teacher_change_password_screen.dart';
import 'package:school_management/screens/add_complain_box_screen.dart';
import 'package:school_management/screens/leave_list.dart';
import 'package:school_management/screens/save_attendance_screen.dart';
import 'package:school_management/screens/student_attendance.dart';
import 'package:school_management/screens/view_fee_screen.dart';
import 'package:school_management/screens/view_notice_screen.dart';
import 'package:school_management/utils/colors.dart';
import '../auth/student/provider/student_login_provider.dart';
import '../screens/ChooseYourOptionScreen.dart';
import '../screens/add_leave_screen.dart';

class StudentDrawer extends StatefulWidget {
  const StudentDrawer({super.key});

  @override
  State<StudentDrawer> createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer> {
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
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const StudentDashboardD()),
                );
              },
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

            _buildDrawerTile(Icons.list_alt, 'Attendance', onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SaveAttendanceScreen()),
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
                          MaterialPageRoute(builder: (_) => const LeaveList()),
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
              final provider = Provider.of<StudentLoginProvider>(context, listen: false);
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





// DrawerHeader(
//   decoration: BoxDecoration(
//     gradient: LinearGradient(
//       colors: [AppColors.appColor.withOpacity(0.9), AppColors.appColor],
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//     ),
//     borderRadius: const BorderRadius.only(bottomRight: Radius.circular(30)),
//   ),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       // Row(
//       //   children: [
//       //     Container(
//       //       decoration: BoxDecoration(
//       //         shape: BoxShape.circle,
//       //         border: Border.all(color: Colors.white70, width: 2),
//       //       ),
//       //       child: const CircleAvatar(
//       //         radius: 28,
//       //         backgroundImage: AssetImage('assets/images/Ellipse 1.png'),
//       //       ),
//       //     ),
//       //     const SizedBox(width: 16),
//       //     // Column(
//       //     //   crossAxisAlignment: CrossAxisAlignment.start,
//       //     //   children: const [
//       //     //     Text('Company Name',
//       //     //         style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
//       //     //     SizedBox(height: 6),
//       //     //     Row(
//       //     //       children: [
//       //     //         Icon(Icons.circle, color: Colors.greenAccent, size: 12),
//       //     //         SizedBox(width: 6),
//       //     //         Text('Online', style: TextStyle(color: Colors.white70, fontSize: 13)),
//       //     //       ],
//       //     //     ),
//       //     //   ],
//       //     // ),
//       //   ],
//       // ),
//       const SizedBox(height: 16),
//       // Container(
//       //   padding: const EdgeInsets.symmetric(horizontal: 12),
//       //   decoration: BoxDecoration(
//       //     color: Colors.white.withOpacity(0.9),
//       //     borderRadius: BorderRadius.circular(10),
//       //   ),
//       //   child: const TextField(
//       //     style: TextStyle(color: Colors.black87),
//       //     decoration: InputDecoration(
//       //       hintText: "Search...",
//       //       hintStyle: TextStyle(color: Colors.black38),
//       //       border: InputBorder.none,
//       //       prefixIcon: Icon(Icons.search, color: Colors.black54),
//       //     ),
//       //   ),
//       // ),
//     ],
//   ),
// ),