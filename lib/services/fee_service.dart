import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/model/Session.dart';
import 'package:school_management/model/Student.dart';
import 'package:school_management/model/fee_detail.dart';

class FeeService {

  Future<List<Session>> fetchStudentSessions() async {
    final url = Uri.parse("https://mssapi.checkour.work/api/parent/studentSession");
    final response = await http.get(url);

    print("Sessions API raw response: ${response.body}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final sessions = data['data']?['data'];

      if (sessions is List) {
        return sessions.map<Session>((session) => Session.fromJson(session)).toList();
      } else {
        throw Exception("Unexpected response structure: $data");
      }
    } else {
      throw Exception("Failed to load sessions");
    }
  }


  Future<List<Student>> fetchStudentNames(int parentId) async {
    final url = Uri.parse("https://mssapi.checkour.work/api/parent/studentName/$parentId");
    final response = await http.get(url);

    print("Students API raw response: ${response.body}");  // <-- add this

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final students = data['data']?['data'];

      if (students is List) {
        return students.map<Student>((student) => Student.fromJson(student)).toList();
      } else {
        throw Exception("Unexpected response structure: $data");
      }
    } else {
      throw Exception("Failed to load students");
    }
  }


  Future<List<FeeDetail>> fetchStudentFee({
    required int studentId,
    required String sessionId,
  }) async {
    final url = Uri.parse(
      "https://mssapi.checkour.work/api/parent/studentfee/StudentID/$studentId/SessionID/$sessionId",
    );

    print("Calling Fee API: $url");

    final response = await http.get(url);

    print("Fee API Status Code: ${response.statusCode}");
    print("Fee API Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Decoded Fee API Data: $data");

      if (data['data'] != null && data['data']['data'] != null) {
        final feeList = List.from(data['data']['data']);
        print("Fee list count: ${feeList.length}");
        return feeList.map((json) => FeeDetail.fromJson(json)).toList();
      } else {
        print("Fee data missing or unexpected format");
        return [];
      }
    } else {
      print("Failed to fetch fee data");
      return [];
    }
  }


}
