import 'package:flutter/material.dart';
import 'package:school_management/model/teacher_leave_list_model.dart';
import 'package:school_management/services/teacher_leave_api_service.dart';

class TeacherLeaveProvider with ChangeNotifier {
  final TeacherLeaveApiService _apiService = TeacherLeaveApiService();

  List<TeacherLeaveModel> _leaveList = [];
  bool _isLoading = false;

  List<TeacherLeaveModel> get leaveList => _leaveList;
  bool get isLoading => _isLoading;

  Future<void> fetchLeaves(int teacherID, int branchID) async {
    try {
      _isLoading = true;
      notifyListeners();

      _leaveList = await TeacherLeaveApiService().fetchLeaves(teacherID, branchID);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      print("Error fetching leave list: $e");
      rethrow;
    }
  }

}
