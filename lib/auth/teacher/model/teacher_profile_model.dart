class TeacherProfileModel {
  final int id;
  final String admissionDate;
  final String admissionNumber;
  final String branch;
  final String session;
  final String classSection;
  final String house;
  final String name;
  final String fatherName;
  final String motherName;
  final String parentOccupation;
  final String dob;
  final String gender;
  final String bloodGroup;
  final String category;
  final String religion;
  final String aadharNumber;
  final String photo;
  final String document;
  final String currentAddress;
  final String permanentAddress;
  final String mobileNumber;
  final String altMobileNumber;
  final String emailAddress;
  final PreviousSchoolInfo previousSchoolInfo;

  TeacherProfileModel({
    required this.id,
    required this.admissionDate,
    required this.admissionNumber,
    required this.branch,
    required this.session,
    required this.classSection,
    required this.house,
    required this.name,
    required this.fatherName,
    required this.motherName,
    required this.parentOccupation,
    required this.dob,
    required this.gender,
    required this.bloodGroup,
    required this.category,
    required this.religion,
    required this.aadharNumber,
    required this.photo,
    required this.document,
    required this.currentAddress,
    required this.permanentAddress,
    required this.mobileNumber,
    required this.altMobileNumber,
    required this.emailAddress,
    required this.previousSchoolInfo,
  });

  factory TeacherProfileModel.fromJson(Map<String, dynamic> json) {
    return TeacherProfileModel(
      id: json['ID'] ?? 0,
      admissionDate: json['AdmissionDate'] ?? '',
      admissionNumber: json['AdmissionNumber'] ?? '',
      branch: json['Branch'] ?? '',
      session: json['Session'] ?? '',
      classSection: json['ClassSection'] ?? '',
      house: json['House'] ?? '',
      name: json['Name'] ?? '',
      fatherName: json['FatherName'] ?? '',
      motherName: json['MotherName'] ?? '',
      parentOccupation: json['ParentOccupation'] ?? '',
      dob: json['DOB'] ?? '',
      gender: json['Gender'] ?? '',
      bloodGroup: json['BloodGroup'] ?? '',
      category: json['Category'] ?? '',
      religion: json['Religion'] ?? '',
      aadharNumber: json['AadharNumber'] ?? '',
      photo: json['Photo'] ?? '',
      document: json['Document'] ?? '',
      currentAddress: json['CurrentAddress'] ?? '',
      permanentAddress: json['PermanentAddress'] ?? '',
      mobileNumber: json['MobileNumber'] ?? '',
      altMobileNumber: json['AltMobileNumber'] ?? '',
      emailAddress: json['EmailAddress'] ?? '',
      previousSchoolInfo: PreviousSchoolInfo(
        previousSchool: json['PreviousSchool'] ?? '',
        previousClass: json['PreviousClass'] ?? '',
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'AdmissionDate': admissionDate,
      'AdmissionNumber': admissionNumber,
      'Branch': branch,
      'Session': session,
      'ClassSection': classSection,
      'House': house,
      'Name': name,
      'FatherName': fatherName,
      'MotherName': motherName,
      'ParentOccupation': parentOccupation,
      'DOB': dob,
      'Gender': gender,
      'BloodGroup': bloodGroup,
      'Category': category,
      'Religion': religion,
      'AadharNumber': aadharNumber,
      'Photo': photo,
      'Document': document,
      'CurrentAddress': currentAddress,
      'PermanentAddress': permanentAddress,
      'MobileNumber': mobileNumber,
      'AltMobileNumber': altMobileNumber,
      'EmailAddress': emailAddress,
      'PreviousSchool': previousSchoolInfo.previousSchool,
      'PreviousClass': previousSchoolInfo.previousClass,
    };
  }
}


class PreviousSchoolInfo {
  final String previousSchool;
  final String previousClass;

  PreviousSchoolInfo({
    required this.previousSchool,
    required this.previousClass,
  });

  Map<String, dynamic> toJson() {
    return {
      'PreviousSchool': previousSchool,
      'PreviousClass': previousClass,
    };
  }
}

