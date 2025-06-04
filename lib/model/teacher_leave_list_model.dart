class TeacherLeaveModel {
  final int id;
  final String className;
  final String studentName;
  final String date;
  final String reason;
  final String status;

  TeacherLeaveModel({
    required this.id,
    required this.className,
    required this.studentName,
    required this.date,
    required this.reason,
    required this.status,
  });

  factory TeacherLeaveModel.fromJson(Map<String, dynamic> json) {
    return TeacherLeaveModel(
      id: json['ID'] ?? 0,
      className: json['Class'] ?? '',
      studentName: json['Student'] ?? '',
      date: json['Date'] ?? '',
      reason: json['Reason'] ?? '',
      status: json['Status'] ?? '',
    );
  }
}
