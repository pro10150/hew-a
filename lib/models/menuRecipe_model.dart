class MenuRecipeModel {
  String? uid;
  String? nameMenu;
  String? mainIngredient;
  String? userID;
  String? image;
  String? recipeName;
  String? description;
  int? timeMinute;
  String? method;
  String? type;
  double? calories;
  double? protein;
  double? carb;
  double? fat;
  String? name;

  MenuRecipeModel(
      {this.uid,
      this.recipeName,
      this.description,
      required this.timeMinute,
      required this.method,
      required this.type,
      required this.calories,
      required this.protein,
      required this.carb,
      required this.fat,
      required this.nameMenu,
      required this.mainIngredient,
      this.userID,
      this.image,
      this.name});

  MenuRecipeModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    recipeName = json['recipeName'];
    description = json['description'];
    timeMinute = json['timeMinue'];
    method = json['method'];
    type = json['type'];
    calories = json['calories'];
    protein = json['protein'];
    carb = json['carb'];
    fat = json['carb'];
    nameMenu = json['nameMenu'];
    mainIngredient = json['mainIngredient'];
    userID = json['userID'];
    image = json['image'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['recipeName'] = this.recipeName;
    data['description'] = this.description;
    data['timeMinute'] = this.timeMinute;
    data['method'] = this.method;
    data['type'] = this.type;
    data['calories'] = this.calories;
    data['protein'] = this.protein;
    data['carb'] = this.carb;
    data['fat'] = this.fat;
    data['nameMenu'] = this.nameMenu;
    data['mainIngredient'] = this.mainIngredient;
    data['userID'] = this.userID;
    data['image'] = this.image;
    data['name'] = this.name;
    return data;
  }
}
