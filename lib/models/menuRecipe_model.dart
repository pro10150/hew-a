class MenuRecipeModel {
  int? id;
  int? menuId;
  String? uid;
  String? recipeUid;
  String? nameMenu;
  int? mainIngredient;
  String? userID;
  String? menuImage;
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
      {this.id,
      this.uid,
      this.menuId,
      this.recipeUid,
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
      this.menuImage,
      this.name});

  MenuRecipeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menuId'];
    uid = json['uid'];
    recipeUid = json['recipeUid'];
    recipeName = json['recipeName'];
    description = json['description'];
    timeMinute = json['timeMinute'];
    method = json['method'];
    type = json['type'];
    calories = json['calories'];
    protein = json['protein'];
    carb = json['carb'];
    fat = json['fat'];
    nameMenu = json['nameMenu'];
    mainIngredient = json['mainIngredient'];
    userID = json['userID'];
    menuImage = json['menuImage'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menuId'] = this.menuId;
    data['uid'] = this.uid;
    data['recipeUid'] = this.recipeUid;
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
    data['menuImage'] = this.menuImage;
    data['name'] = this.name;
    return data;
  }
}
