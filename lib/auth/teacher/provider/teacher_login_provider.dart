import 'package:flutter/material.dart';
import 'package:school_management/auth/teacher/model/teacher_model.dart';
import 'package:school_management/auth/teacher/service/teacher_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherLoginProvider with ChangeNotifier {
  final _service = TeacherLoginService();
  TeacherModel? _teacher;
  String? error;
  bool _isLoading = false;

  bool _isCheckingLoginStatus = true;
  bool get isCheckingLoginStatus => _isCheckingLoginStatus;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;


  TeacherModel? get teacher => _teacher;
  bool get isLoading => _isLoading;

  Future<bool> loginTeacher(String mobile, String password) async {
    _isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await _service.login(mobile, password);

      if (result != null && result.auth == 'authenticate') {
        _teacher = result;

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('student_is_logged_in', true);
        await prefs.setInt('teacherId', result.id ?? 0);
        await prefs.setInt('branchId', result.branchId ?? 0);

        return true;
      } else {
        error = 'Invalid credentials';
        return false;
      }
    } catch (e) {
      error = 'Login error: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final teacherId = prefs.getInt('teacherId');

      if (teacherId == null) {
        error = "Teacher ID not found";
        return false;
      }

      final success = await _service.changePassword(
        teacherId: teacherId,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

      if (!success) {
        error = "Failed to change password";
      }

      return success;
    } catch (e) {
      error = "Error: $e";
      return false;
    }
  }


  Future<void> checkLoginStatus() async {
    _isCheckingLoginStatus = true;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('student_is_logged_in') ?? false;

    _isCheckingLoginStatus = false;
    notifyListeners();
  }


  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('student_is_logged_in');
    _isLoggedIn = false;
    notifyListeners();
  }



}


