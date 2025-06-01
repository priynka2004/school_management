import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:school_management/model/view_notice_model.dart';


class ViewNoticeService {
  final String baseUrl = "http://mssapi.checkour.work/api/parentNotice";

  Future<List<ViewNoticeModel>> fetchNotices(int parentId) async {
    final url = Uri.parse("$baseUrl/$parentId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final viewNoticeResponse = ViewNoticeResponse.fromJson(jsonData);
      return viewNoticeResponse.notices;
    } else {
      throw Exception("Failed to load notices");
    }
  }
}
