import 'package:flutter/material.dart';
import 'package:school_management/model/Session.dart';
import 'package:school_management/model/Student.dart';
import 'package:school_management/model/fee_detail.dart';
import '../services/fee_service.dart';

class FeeProvider with ChangeNotifier {
  final FeeService _feeService = FeeService();

  List<Session> _sessions = [];
  Session? _selectedSession;

  List<Student> _students = [];
  Student? _selectedStudent;

  int? _parentId;

  List<FeeDetail> _feeDetails = [];
  FeeDetail? _selectedFeeDetail;

  List<Session> get sessions => _sessions;
  Session? get selectedSession => _selectedSession;

  List<Student> get students => _students;
  Student? get selectedStudent => _selectedStudent;


  List<FeeDetail> get feeDetails => _feeDetails;
  FeeDetail? get selectedFeeDetail => _selectedFeeDetail;

  final bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;



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


  void setSelectedSession(Session session) {
    _selectedSession = session;
    notifyListeners();
    if (_parentId != null) {
      loadStudentNames(_parentId!);
    }
  }

  Future<void> loadStudentNames(int parentId) async {
    try {
      _students = await _feeService.fetchStudentNames(parentId);
      _selectedStudent = null;
      notifyListeners();
    } catch (e) {
      print("Error loading students: $e");
    }
  }

  void setSelectedStudent(Student value) {
    _selectedStudent = value;
    notifyListeners();
  }

  void setSelectedFeeDetail(FeeDetail feeDetail) {
    _selectedFeeDetail = feeDetail;
    notifyListeners();
  }


  Future<void> loadFeeDetails(int studentId, String sessionId) async {
    print("loadFeeDetails called with studentId: $studentId, sessionId: $sessionId");

    final fees = await _feeService.fetchStudentFee(studentId: studentId, sessionId: sessionId);

    print("Loaded fees count: ${fees.length}");

    _feeDetails = fees;
    notifyListeners();
  }

}
