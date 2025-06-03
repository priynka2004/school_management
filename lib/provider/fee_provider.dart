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

  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Session> get sessions => _sessions;
  Session? get selectedSession => _selectedSession;

  List<Student> get students => _students;
  Student? get selectedStudent => _selectedStudent;

  List<FeeDetail> get feeDetails => _feeDetails;
  FeeDetail? get selectedFeeDetail => _selectedFeeDetail;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setParentId(int id) {
    _parentId = id;
  }

  Future<void> loadSessions() async {
    _setLoading(true);
    try {
      _sessions = await _feeService.fetchStudentSessions();
      print("Sessions loaded: ${_sessions.map((s) => 'ID: ${s.id}, Name: ${s.name}').toList()}");
    } catch (e) {
      _setError("Error loading sessions: $e");
    } finally {
      _setLoading(false);
    }
  }

  // void setSelectedSession(Session? session) {
  //   _selectedSession = session;
  //   notifyListeners();
  //   if (_parentId != null && session != null) {
  //     loadStudentNames(_parentId!);
  //   }
  // }
  // void setSelectedSession(Session? session) {
  //   _selectedSession = session;
  //   notifyListeners();
  //   // Do not load students again here, as it may reset the selected student
  // }
  void setSelectedStudent(Student? student) {
    _selectedStudent = student;
    print("Selected student set to: ${student?.name}");
    notifyListeners();
  }

  void setSelectedSession(Session? session) {
    _selectedSession = session;
    print("Selected session set to: ${session?.name}");
    notifyListeners();
  }
  Future<void> loadStudentNames(int parentId) async {
    _setLoading(true);
    try {
      _students = await _feeService.fetchStudentNames(parentId);
      _selectedStudent = null;
    } catch (e) {
      _setError("Error loading students: $e");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  // void setSelectedStudent(Student? student) {
  //   _selectedStudent = student;
  //   notifyListeners();
  // }

  void setSelectedFeeDetail(FeeDetail? feeDetail) {
    _selectedFeeDetail = feeDetail;
    notifyListeners();
  }

  Future<void> loadStudents() async {
    if (_parentId != null) {
      await loadStudentNames(_parentId!);
    } else {
      print("Parent ID not set.");
    }
  }

  Future<void> loadFeeDetails(int studentId, String sessionId) async {
    _setLoading(true);
    try {
      print("Loading fee details for studentId: $studentId, sessionId: $sessionId");
      _feeDetails = await _feeService.fetchStudentFee(studentId: studentId, sessionId: sessionId);
      print("Loaded fee count: ${_feeDetails.length}");
    } catch (e) {
      _setError("Error loading fee details: $e");
    } finally {
      _setLoading(false);
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    print(message);
  }
}