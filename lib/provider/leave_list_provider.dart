import 'package:flutter/material.dart';
import 'package:school_management/auth/storage/storage_helper.dart';
import 'package:school_management/model/leave_list_model.dart';
import 'package:school_management/services/leave_list_service.dart';


class LeaveListProvider extends ChangeNotifier {
  List<LeaveItem> _leaveList = [];
  bool _isLoading = false;

  List<LeaveItem> get leaveList => _leaveList;
  bool get isLoading => _isLoading;

  Future<void> fetchLeaveList() async {
    _isLoading = true;
    notifyListeners();

    List<LeaveItem> savedList = await StorageHelper.getLeaveList();
    if (savedList.isNotEmpty) {
      _leaveList = savedList;
      _isLoading = false;
      notifyListeners();
    }


    final result = await LeaveListServices.fetchLeaveList();

    if (result != null) {
      _leaveList = result.data;


      await StorageHelper.saveLeaveList(_leaveList);
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearList() {
    _leaveList = [];
    notifyListeners();
  }
}