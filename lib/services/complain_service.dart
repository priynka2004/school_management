import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/model/complain_model.dart';

class ComplainService {
  final String baseUrl = "https://mssapi.checkour.work/api/parent";

  Future<bool> addComplain({
    required String studentId,
    required String parentId,
    required String message,
  }) async {
    final url = Uri.parse("$baseUrl/addcomplain");

    final body = {
      "StudentID": studentId,
      "ParentID": parentId,
      "Message": message,
    };

    final response = await http.post(
      url,
      body: jsonEncode(body),
      headers: {
        "Content-Type": "application/json",
      },
    );

    return response.statusCode == 200;
  }

  Future<List<ComplainModel>> getComplainList(String parentId) async {
    final url = Uri.parse("$baseUrl/complain-list/$parentId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('data') &&
          jsonResponse['data'] is Map &&
          jsonResponse['data'].containsKey('data')) {
        final List<dynamic> jsonData = jsonResponse['data']['data'];
        return jsonData.map((e) => ComplainModel.fromJson(e)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception("Failed to fetch complain list");
    }
  }


  Future<bool> deleteComplain(String parentId, String complainId) async {
    final url = Uri.parse("$baseUrl/delete-complain/$parentId?complainId=$complainId");

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print("Delete API status: ${response.statusCode}");
      print("Delete API response: ${response.body}");
      return false;
    }
  }




}
