<<<<<<< Updated upstream
class ReKitchenModel {
  String? nameKitc;
  String? recipeID;

  ReKitchenModel({required this.nameKitc, required this.recipeID});

  ReKitchenModel.fromJson(Map<String, dynamic> json) {
    nameKitc = json['nameKitc'];
    recipeID = json['recipeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameKitc'] = this.nameKitc;
    data['recipeID'] = this.recipeID;
    return data;
  }
}
=======
class ReKitchenModel {
  String? nameKitc;
  String? recipeID;

  ReKitchenModel({required this.nameKitc, required this.recipeID});

  ReKitchenModel.fromJson(Map<String, dynamic> json) {
    nameKitc = json['nameKitc'];
    recipeID = json['recipeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameKitc'] = this.nameKitc;
    data['recipeID'] = this.recipeID;
    return data;
  }
}
>>>>>>> Stashed changes
