class ComplainModel {
  final int id;
  final String? studentName;
  final String? message;
  final String? date;

  ComplainModel({
    required this.id,
    this.studentName,
    this.message,
    this.date,
  });

  factory ComplainModel.fromJson(Map<String, dynamic> json) {
    return ComplainModel(
      id: json['ID'] ?? 0,
      studentName: json['StudentName'],
      message: json['Message'],
      date: json['Date'],
    );
  }
}
