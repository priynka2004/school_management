import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/auth/teacher/model/teacher_model.dart';

class TeacherService {
  final String baseUrl = 'https://mssapi.checkour.work/api/teacher-profile';

  Future<TeacherProfileModel> fetchTeacherProfile(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> dataList = jsonResponse['data']['data'];
      if (dataList.isNotEmpty) {
        return TeacherProfileModel.fromJson(dataList[0]);
      } else {
        throw Exception('Teacher profile data is empty');
      }
    } else {
      throw Exception('Failed to load teacher profile');
    }
  }
}
