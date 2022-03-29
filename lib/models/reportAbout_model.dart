class ReportAboutModel {
  int? id;
  String? aboutName;
  int? aboutType;

  ReportAboutModel({this.id, required this.aboutName, required this.aboutType});

  ReportAboutModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aboutName = json['aboutName'];
    aboutType = json['aboutType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['aboutName'] = this.aboutName;
    data['aboutType'] = this.aboutType;
    return data;
  }
}
