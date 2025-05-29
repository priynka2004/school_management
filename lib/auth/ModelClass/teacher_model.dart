import 'package:xml/xml.dart';

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

  // factory TeacherModel.fromXml(XmlElement table) {
  //   return TeacherModel(
  //     id: int.tryParse(table.getElement('ID')?.innerText ?? ''),
  //     branchId: int.tryParse(table.getElement('BranchID')?.innerText ?? ''),
  //     name: table.getElement('Name')?.innerText,
  //     mobile: table.getElement('Mobile')?.innerText,
  //     email: table.getElement('Email')?.innerText,
  //     auth: table.getElement('auth')?.innerText,
  //   );
  // }

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
