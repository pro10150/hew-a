class ReAllergyModel {
  int? id;
  int? allID;
  String? userID;

  ReAllergyModel({required this.allID, required this.userID});

  ReAllergyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    allID = json['allID'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['allID'] = this.allID;
    data['userID'] = this.userID;
    return data;
  }
}
