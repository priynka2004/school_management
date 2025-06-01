import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/model/leave_list_model.dart';

class LeaveListServices {
  static const String baseUrl = 'https://mssapi.checkour.work/api/parent/studentleave/1';

  static Future<LeaveListModel?> fetchLeaveList() async {
    final url = Uri.parse(baseUrl);

    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer YOUR_TOKEN_HERE',
    };

    try {
      final response = await http.get(url, headers: headers);
      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return LeaveListModel.fromJson(jsonData);
      } else {
        print('Failed to load leave list: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching leave list: $e');
      return null;
    }
  }
}
