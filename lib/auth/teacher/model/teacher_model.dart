class TeacherProfileModel {
  final int id;
  final String name;
  final String branchId;
  final String fatherName;
  final String email;
  final String mobile;
  final String password;
  final String dob;
  final String gender;
  final String categoryId;
  final String religion;
  final String qualification;
  final String experience;
  final String previousSchool;
  final String address;
  final String photo;
  final String document;

  TeacherProfileModel({
    required this.id,
    required this.name,
    required this.branchId,
    required this.fatherName,
    required this.email,
    required this.mobile,
    required this.password,
    required this.dob,
    required this.gender,
    required this.categoryId,
    required this.religion,
    required this.qualification,
    required this.experience,
    required this.previousSchool,
    required this.address,
    required this.photo,
    required this.document,
  });

  factory TeacherProfileModel.fromJson(Map<String, dynamic> json) {
    return TeacherProfileModel(
      id: json['ID'] is int ? json['ID'] : int.tryParse(json['ID'].toString()) ?? 0,
      name: json['Name'] ?? '',
      branchId: json['BranchID']?.toString() ?? '',
      fatherName: json['FatherName'] ?? '',
      email: json['Email'] ?? '',
      mobile: json['Mobile'] ?? '',
      password: json['Password'] ?? '',
      dob: json['DOB'] ?? '',
      gender: json['Gender'] ?? '',
      categoryId: json['CategoryID']?.toString() ?? '',
      religion: json['Religion'] ?? '',
      qualification: json['Qualification'] ?? '',
      experience: json['Experience']?.toString() ?? '',
      previousSchool: json['PreviousSchool'] ?? '',
      address: json['Address'] ?? '',
      photo: json['Photo'] ?? '',
      document: json['Document'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TeacherID': id, // already int
      'BranchID': int.tryParse(branchId) ?? 0,
      'UpdatedBy': id,
      'Name': name,
      'FatherName': fatherName,
      'Email': email,
      'Mobile': mobile,
      'Password': password,
      'DOB': dob,
      'Gender': gender,
      'CategoryID': int.tryParse(categoryId) ?? 0,
      'Religion': religion,
      'Qualification': qualification,
      'Experience': int.tryParse(experience) ?? 0,
      'PreviousSchool': previousSchool,
      'Address': address,
      'Photo': photo,
      'Document': document,
    };
  }

}
