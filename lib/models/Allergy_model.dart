class AllergyModel {
  String? nameAll;
  String? allID;

  AllergyModel({required this.nameAll, required this.allID});

  AllergyModel.fromJson(Map<String, dynamic> json) {
    nameAll = json['nameAll'];
    allID = json['allID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameAll'] = this.nameAll;
    data['allID'] = this.allID;
    return data;
  }
}
