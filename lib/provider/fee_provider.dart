import 'package:flutter/material.dart';
import '../services/fee_service.dart';

class FeeProvider with ChangeNotifier {
  final FeeService _feeService = FeeService();

  List<String> _sessions = [];
  String? _selectedSession;

  List<String> _students = [];
  String? _selectedStudent;

  int? _parentId; // 👈 Track parent ID

  List<String> get sessions => _sessions;
  String? get selectedSession => _selectedSession;

  List<String> get students => _students;
  String? get selectedStudent => _selectedStudent;

  void setParentId(int id) {
    _parentId = id;
  }

  Future<void> loadSessions() async {
    try {
      _sessions = await _feeService.fetchStudentSessions();
      notifyListeners();
    } catch (e) {
      print("Error loading sessions: $e");
    }
  }

  void setSelectedSession(String value) {
    _selectedSession = value;
    notifyListeners();

    if (_parentId != null) {
      loadStudentNames(_parentId!); // 👈 Use parent ID when session changes
    }
  }

  Future<void> loadStudentNames(int parentId) async {
    try {
      _students = await _feeService.fetchStudentNames(parentId);
      _selectedStudent = null; // reset selected student on session change
      notifyListeners();
    } catch (e) {
      print("Error loading students: $e");
    }
  }

  void setSelectedStudent(String value) {
    _selectedStudent = value;
    notifyListeners();
  }
}
