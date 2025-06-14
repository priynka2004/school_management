import 'package:flutter/material.dart';
import 'package:school_management/auth/teacher/model/view_student_leave_model.dart';
import 'package:school_management/services/view_student_leave_service.dart';

class ViewStudentLeaveProvider with ChangeNotifier {
  final ViewStudentLeaveService _service = ViewStudentLeaveService();

  ViewStudentLeaveModel? _leaveData;
  bool _isLoading = false;

  ViewStudentLeaveModel? get leaveData => _leaveData;
  bool get isLoading => _isLoading;

  Future<void> loadLeaveList({required int teacherId, required int branchId}) async {
    _isLoading = true;
    notifyListeners();

    _leaveData = await _service.fetchLeaveList(
      teacherId: teacherId,
      branchId: branchId,
    );

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> approveLeave(int leaveId) async {
    _isLoading = true;
    notifyListeners();

    final result = await _service.approveLeave(leaveId);

    if (result) {
      // Optional: refresh the leave list after approval
      // await loadLeaveList(teacherId: ..., branchId: ...);
    }

    _isLoading = false;
    notifyListeners();
    return result;
  }
}
