import 'dart:convert';
import 'package:http/http.dart' as http;

class TeacherEditProfileService {
  static Future<bool> updateTeacherProfile(Map<String, dynamic> profileData) async {
    final url = Uri.parse('https://mssapi.checkour.work/api/teacher/update-profile');

    try {
      final finalJson = jsonEncode(profileData);
      print("Sending update data: $profileData");
      print("Final JSON sent: $finalJson");

      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: finalJson,
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final body = response.body.trim();

        try {
          final responseData = jsonDecode(body);

          if (responseData is Map<String, dynamic> && responseData.containsKey('success')) {
            final success = responseData['success'] == true;
            final message = responseData['message'] ?? 'No message from server';
            print("Server Message: $message");
            return success;
          }
        } catch (e) {
          print("JSON decode error: $e");
        }

        if (body.toLowerCase() == 'true') return true;
        if (body.toLowerCase() == 'false') {
          print("Server returned 'false' without message.");
          return false;
        }

        // Unknown format
        print("Unknown response format.");
        return false;
      } else {
        print("Failed with status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Update failed: $e");
      return false;
    }
  }
}
