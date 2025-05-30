class Student {
  final int id;
  final String name;

  Student({required this.id, required this.name});

  factory Student.fromJson(Map<String, dynamic> json) {
    final id = json['ID'];
    final name = json['StudentName'];

    if (id == null || name == null) {
      throw Exception("StudentID or StudentName is null");
    }

    return Student(id: id, name: name);
  }

  @override
  String toString() => name;
}
