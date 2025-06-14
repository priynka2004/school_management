import 'package:flutter/material.dart';
import 'package:school_management/auth/teacher/model/teacher_model.dart';
import 'package:school_management/auth/teacher/service/teacher_service.dart';

class TeacherProvider with ChangeNotifier {
  final TeacherService _service = TeacherService();

  TeacherProfileModel? _profile;
  bool _isLoading = false;
  String? _error;

  TeacherProfileModel? get profile => _profile;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProfile(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _profile = await _service.fetchTeacherProfile(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
