class ViewNoticeModel {
  final int id;
  final String forWhom;
  final String className;
  final String branch;
  final String notice;

  ViewNoticeModel({
    required this.id,
    required this.forWhom,
    required this.className,
    required this.branch,
    required this.notice,
  });

  factory ViewNoticeModel.fromJson(Map<String, dynamic> json) {
    return ViewNoticeModel(
      id: json["ID"],
      forWhom: json["For"] ?? "",
      className: json["Class"] ?? "",
      branch: json["Branch"] ?? "",
      notice: json["Notice"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "For": forWhom,
      "Class": className,
      "Branch": branch,
      "Notice": notice,
    };
  }
}

class ViewNoticeResponse {
  final List<ViewNoticeModel> notices;

  ViewNoticeResponse({required this.notices});

  factory ViewNoticeResponse.fromJson(Map<String, dynamic> json) {
    var list = json["data"]["data"] as List;
    List<ViewNoticeModel> noticeList = list.map((e) => ViewNoticeModel.fromJson(e)).toList();
    return ViewNoticeResponse(notices: noticeList);
  }
}