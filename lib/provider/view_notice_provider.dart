import 'package:flutter/material.dart';
import 'package:school_management/model/view_notice_model.dart';
import 'package:school_management/services/view_notice_service.dart';

class ViewNoticeProvider extends ChangeNotifier {
  final ViewNoticeService _service = ViewNoticeService();

  List<ViewNoticeModel> _notices = [];
  List<ViewNoticeModel> get notices => _notices;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  Future<void> loadNotices(int parentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _notices = await _service.fetchNotices(parentId);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
