import 'package:flutter/material.dart';
import 'package:school_management/model/complain_model.dart';
import 'package:school_management/services/complain_service.dart';

class ComplainProvider extends ChangeNotifier {
  final ComplainService _complainService = ComplainService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ComplainModel> _complains = [];
  List<ComplainModel> get complains => _complains;

  Future<void> sendComplain({
    required String studentId,
    required String parentId,
    required String message,
    required BuildContext context,
  }) async {
    _isLoading = true;
    notifyListeners();

    final success = await _complainService.addComplain(
      studentId: studentId,
      parentId: parentId,
      message: message,
    );

    _isLoading = false;
    notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success ? 'Complain sent successfully!' : 'Failed to send complain.'),
      ),
    );

    if (success) {
      await fetchComplainList(parentId);
    }
  }

  Future<void> fetchComplainList(String parentId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _complains = await _complainService.getComplainList(parentId);
    } catch (e) {
      _complains = [];
      debugPrint("Error fetching complains: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteComplain(String parentId, String complainId, BuildContext context) async {
    bool success = await _complainService.deleteComplain(parentId, complainId);

    if (success) {
      _complains.removeWhere((item) => item.id == complainId);
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Complain deleted successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to delete complain.")),
      );
    }
  }



}
