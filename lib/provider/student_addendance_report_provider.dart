import 'package:flutter/material.dart';
import 'package:school_management/model/select_student_model.dart';
import 'package:school_management/model/student_addendance_report_model.dart';

import '../services/student_attendance_report_service.dart';

class StudentAttendanceReportProvider extends ChangeNotifier {
  final StudentAttendanceReportService _service = StudentAttendanceReportService();

  StudentAttendanceReport? _report;
  SelectStudent? _studentList;
  bool _isLoading = false;
  String? _error;

  StudentAttendanceReport? get report => _report;
  SelectStudent? get studentList => _studentList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadAttendanceReport({
    required int studentID,
    required String month,
    required int sessionID,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final fetchedReport = await _service.fetchAttendanceReport(
      studentID: studentID,
      month: month,
      sessionID: sessionID,
    );

    if (fetchedReport != null) {
      _report = fetchedReport;
    } else {
      _error = 'Failed to fetch attendance report.';
    }

    _isLoading = false;
    notifyListeners();
  }


}
