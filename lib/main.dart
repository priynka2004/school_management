import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:school_management/auth/parent/provider/parent_profile_provider.dart';
import 'package:school_management/auth/teacher/provider/teacher_login_provider.dart';
import 'package:school_management/auth/student/provider/student_login_provider.dart';
import 'package:school_management/auth/teacher/provider/teacher_profile_provider.dart';
import 'package:school_management/provider/complain_provider.dart';
import 'package:school_management/provider/fee_provider.dart';
import 'package:school_management/provider/leave_list_provider.dart';
import 'package:school_management/provider/student_addendance_report_provider.dart';
import 'package:school_management/provider/student_dashboard_provider.dart';
import 'package:school_management/provider/view_notice_provider.dart';

import 'package:school_management/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentLoginProvider()),
        ChangeNotifierProvider(create: (_) => FeeProvider()),
        ChangeNotifierProvider(create: (_) => TeacherLoginProvider()),
        ChangeNotifierProvider(create: (_) => ComplainProvider()),
        ChangeNotifierProvider(create: (_) => ParentProfileProvider()),
        ChangeNotifierProvider(create: (_) => LeaveListProvider()),
        ChangeNotifierProvider(create: (_) => StudentDashboardProvider()),
        ChangeNotifierProvider(create: (_) => ViewNoticeProvider()),
        ChangeNotifierProvider(create: (_) => StudentAttendanceReportProvider()),
        ChangeNotifierProvider(create: (_) => TeacherProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'School Management',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}