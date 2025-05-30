class ParentProfile {
  final int id;
  final String name;
  final String email;
  final String password;
  final String address;
  final String mobile;

  ParentProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.mobile,
  });

  factory ParentProfile.fromJson(Map<String, dynamic> json) {
    return ParentProfile(
      id: json['ID'] != null ? int.tryParse(json['ID'].toString()) ?? 0 : 0,
      name: json['Name'] ?? '',
      email: json['Email'] ?? '',
      password: json['Password'] ?? '',
      address: json['Address'] ?? '',
      mobile: json['Mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ID": id.toString(),
      "Name": name,
      "Email": email,
      "Password": password,
      "Address": address,
      "Mobile": mobile,
    };
  }
}
