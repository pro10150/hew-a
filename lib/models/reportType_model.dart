class ReportTypeModel {
  int? id;
  String? typeName;

  ReportTypeModel({this.id, required this.typeName});

  ReportTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeName = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['typeName'] = this.typeName;
    return data;
  }
}
