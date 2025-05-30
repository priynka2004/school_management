import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/auth/parent/provider/parent_profile_provider.dart';
import 'package:school_management/auth/provider/teacher_login_provider.dart';
import 'package:school_management/provider/complain_provider.dart';
import 'package:school_management/provider/fee_provider.dart';
import 'package:school_management/screens/add_complain_box_screen.dart';
import 'package:school_management/screens/splash_screen.dart';
import 'auth/provider/login_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => FeeProvider()),
          ChangeNotifierProvider(create: (_) => TeacherLoginProvider()),
          ChangeNotifierProvider(create: (_) => ComplainProvider()),
          ChangeNotifierProvider(create: (_) => ParentProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
