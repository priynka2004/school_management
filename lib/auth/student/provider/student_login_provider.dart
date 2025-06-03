import 'package:flutter/material.dart';
import 'package:school_management/auth/parent/model/parent_login_response.dart';
import 'package:school_management/auth/student/service/student_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentLoginProvider extends ChangeNotifier {
  bool isLoading = false;
  String? error;
  ParentModel? _parentData;

  bool _isCheckingLoginStatus = true;
  bool get isCheckingLoginStatus => _isCheckingLoginStatus;

  ParentModel? get parentData => _parentData;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  final StudentLoginService _authService = StudentLoginService();

  Future<bool> login({required String mobile, required String password}) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      _parentData = await _authService.login(mobile, password);
      _isLoggedIn = true;

      // ✅ Save login state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('student_is_logged_in', true);

      return true;
    } catch (e) {
      print('Login Error: $e');
      error = e.toString();
      _isLoggedIn = false;
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
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
    _parentData = null;
    notifyListeners();
  }


}
