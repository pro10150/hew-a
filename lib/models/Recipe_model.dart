class RecipeModel {
  String? id;
  String? uid;
  int? menuId;
  String? recipeName;
  String? description;
  int? timeMinute;
  String? method;
  String? type;
  double? calories;
  double? protein;
  double? carb;
  double? fat;

  RecipeModel(
      {this.id,
      required this.uid,
      required this.menuId,
      this.recipeName,
      this.description,
      required this.timeMinute,
      required this.method,
      required this.type,
      required this.calories,
      required this.protein,
      required this.carb,
      required this.fat});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uid = json['uid'];
    menuId = json['menuId'];
    recipeName = json['recipeName'];
    description = json['description'];
    timeMinute = json['timeMinue'];
    method = json['method'];
    type = json['type'];
    calories = json['calories'];
    protein = json['protein'];
    carb = json['carb'];
    fat = json['carb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uid'] = this.uid;
    data['menuId'] = this.menuId;
    data['recipeName'] = this.recipeName;
    data['description'] = this.description;
    data['timeMinute'] = this.timeMinute;
    data['method'] = this.method;
    data['type'] = this.type;
    data['calories'] = this.calories;
    data['protein'] = this.protein;
    data['carb'] = this.carb;
    data['fat'] = this.fat;
    return data;
  }
}
