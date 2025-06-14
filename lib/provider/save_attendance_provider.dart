import 'package:flutter/material.dart';
import 'package:school_management/model/save_attendance_model.dart';
import 'package:school_management/services/save_attendance_service.dart';


class SaveAttendanceProvider extends ChangeNotifier {
  final SaveAttendanceService _service = SaveAttendanceService();

  List<SaveAttendanceModel> _students = [];
  List<SaveAttendanceModel> get students => _students;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> fetchAttendanceList({
    required int classID,
    required int sectionID,
    required int branchID,
    required int sessionID,
    required String date,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _students = await _service.fetchAttendanceList(
        classID: classID,
        sectionID: sectionID,
        branchID: branchID,
        sessionID: sessionID,
        date: date,
      );
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
