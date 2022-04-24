class ReportModel {
  int? id;
  String? uid;
  int? type;
  String? reportedUid;
  int? reportedRecipeId;
  int? about;
  String? text;
  String? date;
  int? isSolve;

  ReportModel(
      {this.id,
      required this.uid,
      required this.type,
      this.reportedUid,
      this.reportedRecipeId,
      required this.about,
      this.text,
      required this.date,
      this.isSolve});

  ReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    type = json['type'];
    reportedUid = json['reportedUid'];
    reportedRecipeId = json['reportedRecipeId'];
    about = json['about'];
    text = json['text'];
    date = json['date'];
    isSolve = json['isSolve'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['type'] = this.type;
    data['reportedUid'] = this.reportedUid;
    data['reportedRecipeId'] = this.reportedRecipeId;
    data['about'] = this.about;
    data['text'] = this.text;
    data['date'] = this.date;
    data['isSolve'] = this.isSolve;

    return data;
  }
}
