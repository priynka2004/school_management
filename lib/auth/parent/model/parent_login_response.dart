class ParentLoginResponse {
  final bool status;
  final String message;
  final ParentModel? data;

  ParentLoginResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory ParentLoginResponse.fromJson(Map<String, dynamic> json) {
    return ParentLoginResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ParentModel.fromJson(json['data']) : null,
    );
  }
}

class ParentModel {
  final int id;
  final String? name;
  final String? mobile;
  final String? email;
  final String? loginid;
  final String? password;
  final String? address;
  final bool isActive;
  final String? createDate;
  final String? auth;

  ParentModel({
    required this.id,
    this.name,
    this.mobile,
    this.email,
    this.loginid,
    this.password,
    this.address,
    required this.isActive,
    this.createDate,
    this.auth,
  });

  factory ParentModel.fromJson(Map<String, dynamic> json) {
    return ParentModel(
      id: json['ID'] ?? 0,
      name: json['Name'],
      mobile: json['Mobile'],
      email: json['Email'],
      loginid: json['LoginID'],
      password: json['Password'],
      address: json['Address'],
      isActive: json['IsActive'] ?? false,
      createDate: json['CreateDate'],
      auth: json['auth'],
    );
  }

}

