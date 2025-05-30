class TeacherModel {
  final int? id;
  final int? branchId;
  final String? name;
  final String? mobile;
  final String? email;
  final String? auth;

  TeacherModel({
    this.id,
    this.branchId,
    this.name,
    this.mobile,
    this.email,
    this.auth,
  });


  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['ID'] ?? 0,
      name: json['Name'],
      mobile: json['Mobile'],
      email: json['email'],
      branchId: json['BranchID'],
      auth: json['auth'],
    );
  }
}
