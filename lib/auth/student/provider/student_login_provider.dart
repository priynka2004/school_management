import 'package:flutter/material.dart';
import 'package:school_management/auth/parent/model/parent_login_response.dart';
import 'package:school_management/auth/student/service/student_login_service.dart';

class StudentLoginProvider extends ChangeNotifier {
  bool isLoading = false;
  String? error;
  ParentModel? _parentData;

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
      return true; // success
    } catch (e) {
      print('Login Error: $e');
      error = e.toString();
      _isLoggedIn = false;
      return false; // failure
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
