class LeaveListModel {
  final List<LeaveItem> data;

  LeaveListModel({required this.data});

  factory LeaveListModel.fromJson(Map<String, dynamic> json) {
    final rawList = (json['data']['data'] as List<dynamic>?) ?? [];
    final parsedList = rawList.map((e) => LeaveItem.fromJson(e)).toList();

    return LeaveListModel(data: parsedList);
  }

}

class LeaveItem {
  final int id;
  final String? studentId;
  final String? parentId;
  final String studentName;
  final String? fromDate;
  final String? toDate;
  final String reason;
  final String status;
  final String date;

  LeaveItem({
    required this.id,
    this.studentId,
    this.parentId,
    required this.studentName,
    this.fromDate,
    this.toDate,
    required this.reason,
    required this.status,
    required this.date,
  });

  factory LeaveItem.fromJson(Map<String, dynamic> json) {
    final rawId = json['ID'];

    int? id;
    if (rawId is int) {
      id = rawId;
    } else if (rawId is String) {
      id = int.tryParse(rawId);
    }

    if (id == null) {
      throw Exception("LeaveItem JSON missing valid 'ID' field");
    }

    return LeaveItem(
      id: id,
      studentId: json['StudentID']?.toString(),
      parentId: json['ParentID']?.toString(),
      studentName: json['StudentName'] ?? '',
      fromDate: json['FromDate'],
      toDate: json['ToDate'],
      reason: json['Reason'] ?? '',
      status: json['Status'] ?? '',
      date: json['Date'] ?? '',
    );
  }

  // ✅ ADD THIS METHOD BELOW
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'StudentID': studentId,
      'ParentID': parentId,
      'StudentName': studentName,
      'FromDate': fromDate,
      'ToDate': toDate,
      'Reason': reason,
      'Status': status,
      'Date': date,
    };
  }
}