import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/auth/parent/model/parent_login_response.dart';

class StudentLoginService {

  // Future<ParentModel> login(String mobile, String password) async {
  //   final url = Uri.parse("https://mssapi.checkour.work/api/ParentLogin?mobile=$mobile&password=$password");
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //
  //     // Agar data bool hai, to error throw karo
  //     if (data is bool) {
  //       throw Exception("Invalid login credentials or server error");
  //     }
  //
  //     if (data is List && data.isNotEmpty) {
  //       return ParentModel.fromJson(data[0]);
  //     }
  //     print('Login Response: ${response.body}');
  //
  //     throw Exception("Unexpected response format");
  //   } else {
  //     throw Exception("Failed to login");
  //   }
  // }


  Future<ParentModel> login(String mobile, String password) async {
    final url = Uri.parse("https://mssapi.checkour.work/api/ParentLogin?mobile=$mobile&password=$password");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      print('Raw API response: ${response.body}');

      final data = jsonDecode(response.body);

      if (data is List && data.isNotEmpty) {
        // Since it's a list of maps
        final firstItem = data[0];

        if (firstItem is Map<String, dynamic>) {
          return ParentModel.fromJson(firstItem);
        } else {
          throw Exception("Unexpected item type in list");
        }
      } else {
        throw Exception("Empty or invalid data");
      }
    } else {
      throw Exception("Failed to login");
    }
  }

}
