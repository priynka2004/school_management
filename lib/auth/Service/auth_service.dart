import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/auth/ModelClass/parent_login_response.dart';

class AuthService {

  Future<ParentModel> login(String mobile, String password) async {
    final url = Uri.parse("https://mssapi.checkour.work/api/ParentLogin?mobile=$mobile&password=$password");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // Agar data bool hai, to error throw karo
      if (data is bool) {
        throw Exception("Invalid login credentials or server error");
      }

      // Agar data List hai to first item ko model me convert karo
      if (data is List && data.isNotEmpty) {
        return ParentModel.fromJson(data[0]);
      }
      print('Login Response: ${response.body}');

      throw Exception("Unexpected response format");
    } else {
      throw Exception("Failed to login");
    }
  }

}
