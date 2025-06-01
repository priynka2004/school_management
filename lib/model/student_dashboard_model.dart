class StudentDashboardModel {
  final List<StudentDetailModel> students;

  StudentDashboardModel({required this.students});

  factory StudentDashboardModel.fromJson(Map<String, dynamic> json) {
    return StudentDashboardModel(
      students: List<StudentDetailModel>.from(
        (json['data']['data'] as List).map((e) => StudentDetailModel.fromJson(e)),
      ),
    );
  }
}

class StudentDetailModel {
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
  final String previousSchool;
  final String previousClass;

  StudentDetailModel({
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
    required this.previousSchool,
    required this.previousClass,
  });

  factory StudentDetailModel.fromJson(Map<String, dynamic> json) {
    return StudentDetailModel(
      id: json['ID'],
      admissionDate: json['AdmissionDate'],
      admissionNumber: json['AdmissionNumber'],
      branch: json['Branch'],
      session: json['Session'],
      classSection: json['ClassSection'],
      house: json['House'],
      name: json['Name'],
      fatherName: json['FatherName'],
      motherName: json['MotherName'],
      parentOccupation: json['ParentOccupation'],
      dob: json['DOB'],
      gender: json['Gender'],
      bloodGroup: json['BloodGroup'],
      category: json['Category'],
      religion: json['Religion'],
      aadharNumber: json['AadharNumber'],
      photo: json['Photo'],
      document: json['Document'],
      currentAddress: json['CurrentAddress'],
      permanentAddress: json['PermanentAddress'],
      mobileNumber: json['MobileNumber'],
      altMobileNumber: json['AltMobileNumber'],
      emailAddress: json['EmailAddress'],
      previousSchool: json['PreviousSchool'],
      previousClass: json['PreviousClass'],
    );
  }
}
