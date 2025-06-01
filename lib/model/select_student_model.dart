class SelectStudent {
  final List<StudentData> data;

  SelectStudent({required this.data});

  factory SelectStudent.fromJson(Map<String, dynamic> json) {
    var list = json['data']['data'] as List<dynamic>;
    List<StudentData> students = list.map((e) => StudentData.fromJson(e)).toList();
    return SelectStudent(data: students);
  }
}

class StudentData {
  final int id;
  final String studentName;

  StudentData({
    required this.id,
    required this.studentName,
  });

  factory StudentData.fromJson(Map<String, dynamic> json) {
    return StudentData(
      id: json['ID'],
      studentName: json['StudentName'],
    );
  }
}
