<<<<<<< Updated upstream
class FridgeModel {
  String? userID;
  String? recipeID;
  String? ingredID;

  FridgeModel({
    required this.userID,
    required this.recipeID,
    required this.ingredID,
  });

  FridgeModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    recipeID = json['recipeID'];
    ingredID = json['ingredID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['userID'] = this.userID;
    data['recipeID'] = this.recipeID;
    data['ingredID'] = this.ingredID;

    return data;
  }
}
=======
class FridgeModel {
  String? userID;
  String? recipeID;
  String? ingredID;

  FridgeModel({
    required this.userID,
    required this.recipeID,
    required this.ingredID,
  });

  FridgeModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    recipeID = json['recipeID'];
    ingredID = json['ingredID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['userID'] = this.userID;
    data['recipeID'] = this.recipeID;
    data['ingredID'] = this.ingredID;

    return data;
  }
}
>>>>>>> Stashed changes
