class ComplainModel {
  final String id;
  final String studentId;
  final String parentId;
  final String message;
  final String date;

  ComplainModel({
    required this.id,
    required this.studentId,
    required this.parentId,
    required this.message,
    required this.date,
  });

  factory ComplainModel.fromJson(Map<String, dynamic> json) {
    return ComplainModel(
      id: json['ID'].toString(), // ✅ Corrected key
      studentId: json['StudentID'].toString(),
      parentId: json['ParentID'].toString(),
      message: json['Message'] ?? '',
      date: json['created_at'] ?? '',
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'StudentID': studentId,
      'ParentID': parentId,
      'Message': message,
      'created_at': date,
    };
  }
}
