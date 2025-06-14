import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/auth/teacher/model/view_student_leave_model.dart';


class ViewStudentLeaveService {
  Future<ViewStudentLeaveModel?> fetchLeaveList({
    required int teacherId,
    required int branchId,
  }) async {
    final url = Uri.parse(
        'https://mssapi.checkour.work/api/teacher/leave-list/teacherID/$teacherId/branchid/$branchId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return ViewStudentLeaveModel.fromJson(data);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while fetching leave list: $e');
    }

    return null;
  }

  Future<bool> approveLeave(int leaveId) async {
    final url = Uri.parse('https://mssapi.checkour.work/api/teacher/approve-leave/$leaveId');

    try {
      // Try GET request (to check if allowed)
      final response = await http.get(
        url,
      );

      print('GET request status: ${response.statusCode}');
      if (response.statusCode == 200) {
        print('GET Response: ${response.body}');
        return true;
      }

      // Try POST request
      final postResponse = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer your_access_token_here',
        },
      );
      print('POST request status: ${postResponse.statusCode}');
      if (postResponse.statusCode == 200) return true;

      // Try PUT request
      final putResponse = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer your_access_token_here',
        },
      );
      print('PUT request status: ${putResponse.statusCode}');
      if (putResponse.statusCode == 200) return true;

      return false;
    } catch (e) {
      print('Error approving leave: $e');
      return false;
    }
  }



}
