class StudentAttendanceReport {
  final List<StudentAttendance> data;

  StudentAttendanceReport({required this.data});

  factory StudentAttendanceReport.fromJson(Map<String, dynamic> json) {
    final dataList = json['data']['data'] as List;
    return StudentAttendanceReport(
      data: dataList.map((e) => StudentAttendance.fromJson(e)).toList(),
    );
  }
}

class StudentAttendance {
  final int id;
  final String admissionNumber;
  final String name;
  final String mobile;
  final String date;
  final String status;

  StudentAttendance({
    required this.id,
    required this.admissionNumber,
    required this.name,
    required this.mobile,
    required this.date,
    required this.status,
  });

  factory StudentAttendance.fromJson(Map<String, dynamic> json) {
    return StudentAttendance(
      id: json['ID'],
      admissionNumber: json['AdmissionNumber'],
      name: json['Name'],
      mobile: json['Mobile'],
      date: json['Date'],
      status: json['Status'],
    );
  }
}
