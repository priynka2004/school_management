import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';
import '../ModelClass/teacher_model.dart';

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
}
