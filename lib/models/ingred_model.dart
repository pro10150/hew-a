class IngredModel {
  String? userID;
  String? recipeID;
  String? ingredID;
  String? name;

  IngredModel(
      {required this.userID,
      required this.recipeID,
      required this.ingredID,
      required this.name});

  IngredModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    recipeID = json['recipeID'];
    ingredID = json['ingredID'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['userID'] = this.userID;
    data['recipeID'] = this.recipeID;
    data['ingredID'] = this.ingredID;
    data['name'] = this.name;

    return data;
  }
}
