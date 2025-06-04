import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/model/teacher_leave_list_model.dart';

class TeacherLeaveApiService {
  static const String baseUrl = 'https://mssapi.checkour.work/api';

  Future<List<TeacherLeaveModel>> fetchLeaves(int teacherID, int branchID) async {
    final response = await http.get(
      Uri.parse('$baseUrl/teacher/leave-list/teacherID/$teacherID/BranchID/$branchID'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> leavesJson = data['data']['data'];

      return leavesJson.map((json) => TeacherLeaveModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load leave list");
    }
  }


}
