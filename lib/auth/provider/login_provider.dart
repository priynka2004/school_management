import 'package:flutter/material.dart';
import 'package:school_management/auth/ModelClass/parent_login_response.dart';
import 'package:school_management/auth/Service/auth_service.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  String? error;
  ParentModel? _parentData;

  ParentModel? get parentData => _parentData;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  final AuthService _authService = AuthService();

  Future<bool> login({required String mobile, required String password}) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      _parentData = await _authService.login(mobile, password);
      _isLoggedIn = true;
      return true; // success
    } catch (e) {
      print('Login Error: $e');
      error = e.toString();
      _isLoggedIn = false;
      return false; // failure
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
