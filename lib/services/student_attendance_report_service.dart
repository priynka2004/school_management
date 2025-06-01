import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/model/student_addendance_report_model.dart';

class StudentAttendanceReportService {
  final String baseUrl = 'https://mssapi.checkour.work/api/parent';


  Future<StudentAttendanceReport?> fetchAttendanceReport({
    required int studentID,
    required String month,
    required int sessionID,
  }) async {
    final url = Uri.parse('$baseUrl/student-attendance/StudentID/$studentID/Month/$month/SessionID/$sessionID');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return StudentAttendanceReport.fromJson(jsonData);
      } else {
        print('Failed to load attendance report. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching attendance report: $e');
      return null;
    }
  }

}
