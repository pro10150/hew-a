class ReportImageModel {
  int? id;
  int? reportId;
  String? imagePath;

  ReportImageModel({required this.reportId, required this.imagePath});

  ReportImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reportId = json['reportId'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reportId'] = this.reportId;
    data['imagePath'] = this.imagePath;
    return data;
  }
}
