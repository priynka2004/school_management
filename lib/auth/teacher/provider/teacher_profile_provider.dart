import 'package:flutter/material.dart';
import 'package:school_management/auth/teacher/model/teacher_profile_model.dart';
import 'package:school_management/auth/teacher/service/teacher_profile_service.dart';

class TeacherProfileProvider with ChangeNotifier {
  final TeacherProfileService _teacherProfileService = TeacherProfileService();

  List<TeacherProfileModel> _teacher = [];
  bool _isLoading = false;

  List<TeacherProfileModel> get teacher => _teacher;
  bool get isLoading => _isLoading;

  Future<void> loadTeacher(int teacherId, int branchId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _teacher = await _teacherProfileService.fetchTeacherProfile(teacherId, branchId);
    } catch (e) {
      print('Error: $e');
      _teacher = [];
    }

    _isLoading = false;
    notifyListeners();
  }
}
