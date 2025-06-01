import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/model/student_dashboard_model.dart';

class StudentDashboardService {
  static Future<StudentDashboardModel?> fetchStudentData() async {
    final url = Uri.parse('https://mssapi.checkour.work/api/Parent/students-list/1');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': 'Bearer YOUR_TOKEN',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return StudentDashboardModel.fromJson(jsonData);
      } else {
        print("Failed to load student data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching student data: $e");
    }

    return null;
  }
}
