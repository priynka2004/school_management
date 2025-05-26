import 'dart:convert';
import 'package:http/http.dart' as http;

class FeeService {

  Future<List<String>> fetchStudentSessions() async {
    final url = Uri.parse("https://mssapi.checkour.work/api/parent/studentSession");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final sessions = data['data']?['data'];
      print('Student API Response: ${response.body}');
      print('Student API Status Code: ${response.statusCode}');

      if (sessions is List) {
        return sessions
            .map<String>((session) => session['SessionName'].toString())
            .toList();

      } else {
        throw Exception("Unexpected response structure: $data");
      }

    } else {
      throw Exception("Failed to load sessions");
    }
  }

  Future<List<String>> fetchStudentNames(int parentId) async {
    final url = Uri.parse("https://mssapi.checkour.work/api/parent/studentName/$parentId");
    final response = await http.get(url);

    print("Student name API response: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final studentList = data['data']?['data'];

      if (studentList is List) {
        return studentList
            .map<String>((student) => student['StudentName']?.toString() ?? '')
            .where((name) => name.isNotEmpty)
            .toList();
      } else {
        throw Exception("Unexpected response structure: $data");
      }
    } else {
      throw Exception("Failed to load students");
    }
  }


}
