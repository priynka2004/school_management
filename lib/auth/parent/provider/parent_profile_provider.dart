import 'package:flutter/material.dart';
import '../model/parent_profile.dart';
import '../service/parent_profile_service.dart';

class ParentProfileProvider with ChangeNotifier {
  final ParentProfileService _service = ParentProfileService();
  ParentProfile? _profile;
  bool _isLoading = false;
  String? _error;

  ParentProfile? get profile => _profile;

  bool get isLoading => _isLoading;

  String? get error => _error;

  Future<void> loadProfile(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _profile = await _service.fetchProfile(id);
      _error = null;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> updateProfile(ParentProfile updatedProfile) async {
    _isLoading = true;
    notifyListeners();
    try {
      final success = await _service.updateProfile(updatedProfile);
      if (success) {
        _profile = updatedProfile;
        _error = null;
      } else {
        _error = 'Failed to update profile';
        print(_error);
      }
      return success;
    } catch (e) {
      print('Update profile exception: $e');
      _error = e.toString();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
