import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/parent_profile.dart';

class ParentProfileService {
  final String baseUrl = "https://mssapi.checkour.work/api";

  Future<ParentProfile> fetchProfile(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/Parent-profile/$id'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final profileData = jsonData['data']['data'][0];
      return ParentProfile.fromJson(profileData);
    } else {
      throw Exception('Failed to fetch profile');
    }
  }

  Future<bool> updateProfile(ParentProfile profile) async {
    final response = await http.put(
      Uri.parse('$baseUrl/parent-profile/update'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(profile.toJson()),
    );

    print('Status Code: ${response.statusCode}');
    print('Response body: ${response.body}');

    return response.statusCode == 200;
  }


}
