class ViewStudentLeaveModel {
  final List<LeaveEntry> data;

  ViewStudentLeaveModel({required this.data});

  factory ViewStudentLeaveModel.fromJson(Map<String, dynamic> json) {
    return ViewStudentLeaveModel(
      data: (json['data']['data'] as List)
          .map((e) => LeaveEntry.fromJson(e))
          .toList(),
    );
  }
}

class LeaveEntry {
  final int id;
  final String className;
  final String student;
  final String date;
  final String reason;
  final String status;

  LeaveEntry({
    required this.id,
    required this.className,
    required this.student,
    required this.date,
    required this.reason,
    required this.status,
  });

  factory LeaveEntry.fromJson(Map<String, dynamic> json) {
    return LeaveEntry(
      id: json['ID'] ?? 0,
      className: json['Class'] ?? '',
      student: json['Student'] ?? '',
      date: json['Date'] ?? '',
      reason: json['Reason'] ?? '',
      status: json['Status'] ?? '',
    );
  }
}
