import 'package:flutter/material.dart';
import '../service/teacher_edit_profile_service.dart';

enum UpdateStatus { initial, loading, success, failure }

class TeacherEditProfileProvider with ChangeNotifier {
  UpdateStatus _status = UpdateStatus.initial;
  String? _errorMessage;

  UpdateStatus get status => _status;
  String? get errorMessage => _errorMessage;

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    _status = UpdateStatus.loading;
    _errorMessage = null;
    notifyListeners();

    final result = await TeacherEditProfileService.updateTeacherProfile(data);

    if (result) {
      _status = UpdateStatus.success;
    } else {
      _status = UpdateStatus.failure;
      _errorMessage = "Failed to update profile";
    }

    notifyListeners();
    return result;
  }

  void reset() {
    _status = UpdateStatus.initial;
    _errorMessage = null;
    notifyListeners();
  }
}
