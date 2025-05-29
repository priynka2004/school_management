import 'package:flutter/material.dart';
import 'package:school_management/auth/ModelClass/teacher_model.dart';
import 'package:school_management/auth/Service/teacher_login_service.dart';
import 'package:school_management/model/complain_model.dart';
import 'package:school_management/services/complain_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherLoginProvider with ChangeNotifier {
  final _service = TeacherLoginService();
  TeacherModel? _teacher;
  String? error;
  bool _isLoading = false;

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
}


