class ReAllergyModel {
  int? allID;
  String? userID;

  ReAllergyModel({required this.allID, required this.userID});

  ReAllergyModel.fromJson(Map<String, dynamic> json) {
    allID = json['allID'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['allID'] = this.allID;
    data['userID'] = this.userID;
    return data;
  }
}
