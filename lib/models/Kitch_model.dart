<<<<<<< Updated upstream
class KitchenwareModel {
  String? nameKitc;
  int? id;

  KitchenwareModel({required this.nameKitc, required this.id});

  KitchenwareModel.fromJson(Map<String, dynamic> json) {
    nameKitc = json['nameKitc'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameKitc'] = this.nameKitc;
    data['id'] = this.id;
    return data;
  }
}
=======
class KitchenwareModel {
  String? nameKitc;
  int? id;

  KitchenwareModel({required this.nameKitc, required this.id});

  KitchenwareModel.fromJson(Map<String, dynamic> json) {
    nameKitc = json['nameKitc'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameKitc'] = this.nameKitc;
    data['id'] = this.id;
    return data;
  }
}
>>>>>>> Stashed changes
