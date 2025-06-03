import 'dart:convert';
import 'package:school_management/model/leave_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static Future<void> saveLeaveList(List<LeaveItem> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(list.map((e) => e.toJson()).toList());
    await prefs.setString('leave_list', jsonData);
  }

  static Future<List<LeaveItem>> getLeaveList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonData = prefs.getString('leave_list');
    if (jsonData != null) {
      List decoded = jsonDecode(jsonData);
      return decoded.map((e) => LeaveItem.fromJson(e)).toList();
    }
    return [];
  }

  void testLeaveListLoad() async {
    final list = await StorageHelper.getLeaveList();
    print('Fetched Leave List: ${list.length}');
    for (var leave in list) {
      print('${leave.studentName} - ${leave.reason}');
    }
  }

}
