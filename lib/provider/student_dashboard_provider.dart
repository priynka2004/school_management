import 'package:flutter/material.dart';
import 'package:school_management/model/student_dashboard_model.dart';
import 'package:school_management/services/student_dashboard_service.dart';

class StudentDashboardProvider extends ChangeNotifier {
  List<StudentDetailModel> _students = [];
  bool _isLoading = false;

  List<StudentDetailModel> get students => _students;
  bool get isLoading => _isLoading;

  Future<void> loadStudents() async {
    _isLoading = true;
    notifyListeners();

    final result = await StudentDashboardService.fetchStudentData();

    if (result != null) {
      _students = result.students;
    }

    _isLoading = false;
    notifyListeners();
  }
}
