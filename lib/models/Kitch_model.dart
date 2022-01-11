class KitchenwareModel {
  String? nameKitc;
  String? userID;

  KitchenwareModel({required this.nameKitc, required this.userID});

  KitchenwareModel.fromJson(Map<String, dynamic> json) {
    nameKitc = json['nameKitc'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameKitc'] = this.nameKitc;
    data['userID'] = this.userID;
    return data;
  }
}
