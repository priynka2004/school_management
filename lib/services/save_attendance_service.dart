import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/model/save_attendance_model.dart';


class SaveAttendanceService {
  Future<List<SaveAttendanceModel>> fetchAttendanceList({
    required int classID,
    required int sectionID,
    required int branchID,
    required int sessionID,
    required String date,
  }) async {
    final url = Uri.parse(
        'https://mssapi.checkour.work/api/teacher-studentlist-attendance/classID/$classID/sectionID/$sectionID/BranchID/$branchID/sessionID/$sessionID/Date/$date');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<dynamic> studentsJson = jsonData['data']['data'];

      List<SaveAttendanceModel> students = studentsJson
          .map((studentJson) => SaveAttendanceModel.fromJson(studentJson))
          .toList();

      return students;
    } else {
      throw Exception('Failed to load attendance data');
    }
  }
}
