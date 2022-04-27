class ReportJoinModel {
  int? id;
  String? uid;
  int? type;
  String? reportedUid;
  int? reportedRecipeId;
  int? about;
  String? text;
  String? date;
  String? typeName;
  String? aboutName;
  int? aboutType;
  int? isSolve;

  ReportJoinModel(
      {this.id,
      this.uid,
      this.type,
      this.reportedUid,
      this.reportedRecipeId,
      this.about,
      this.text,
      this.date,
      this.typeName,
      this.aboutName,
      this.aboutType,
      this.isSolve});

  ReportJoinModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    type = json['type'];
    reportedUid = json['reportedUid'];
    reportedRecipeId = json['reportedRecipeId'];
    about = json['about'];
    text = json['text'];
    date = json['date'];
    typeName = json['typeName'];
    aboutName = json['aboutName'];
    aboutType = json['aboutType'];
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
    data['typeName'] = this.typeName;
    data['aboutName'] = this.aboutName;
    data['aboutType'] = this.aboutType;
    data['isSolve'] = this.isSolve;
    return data;
  }
}
