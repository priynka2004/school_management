class SaveAttendanceModel {
  final int studentID;
  final String admissionNumber;
  final String name;
  final String mobile;
  final String house;
  final String status;

  SaveAttendanceModel({
    required this.studentID,
    required this.admissionNumber,
    required this.name,
    required this.mobile,
    required this.house,
    required this.status,
  });

  factory SaveAttendanceModel.fromJson(Map<String, dynamic> json) {
    return SaveAttendanceModel(
      studentID: json['StudentID'],
      admissionNumber: json['AdmissionNumber'],
      name: json['Name'],
      mobile: json['Mobile'],
      house: json['House'],
      status: json['Status'].toString(),
    );
  }
}
