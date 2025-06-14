import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import '../model/teacher_login_model.dart';

class TeacherLoginService {
  Future<TeacherModel?> login(String mobile, String password) async {
    final url = Uri.parse(
      'https://mssapi.checkour.work/api/TeacherLogin?mobile=$mobile&password=$password',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is bool) {
        throw Exception("Invalid login credentials or server error");
      }

      if (data is List && data.isNotEmpty) {
        return TeacherModel.fromJson(data[0]);
      }
      print('Login Response: ${response.body}');

      throw Exception("Unexpected response format");
    } else {
      throw Exception("Failed to login");
    }
  }



  Future<bool> changePassword({
    required int teacherId,
    required String oldPassword,
    required String newPassword,
  }) async {
    final url = Uri.parse('https://mssapi.checkour.work/api/teacher/change-password');

    final body = jsonEncode({
      "TeacherID": teacherId.toString(),
      "OldPassword": oldPassword,
      "NewPassword": newPassword,
    });

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    print("Change Password Status: ${response.statusCode}");
    print("Change Password Response: ${response.body}");

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}
