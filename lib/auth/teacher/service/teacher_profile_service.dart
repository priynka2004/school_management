import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/auth/teacher/model/teacher_profile_model.dart';

class TeacherProfileService {
  Future<List<TeacherProfileModel>> fetchTeacherProfile(int teacherId, int branchId) async {
    final url = 'https://mssapi.checkour.work/api/teacher/students-list/TeacherID/$teacherId/BranchID/$branchId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List teacherJson = body['data']['data'];
      return teacherJson.map((json) => TeacherProfileModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load student data');
    }
  }
}
