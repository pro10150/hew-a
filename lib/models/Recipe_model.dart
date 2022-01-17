class RecipeModel {
  String? uid;
  String? nameMenu;
  String? recipeName;
  String? description;
  int? timeHour;
  int? timeMinute;
  String? method;
  String? type;
  int? calories;
  int? protein;
  int? carb;
  int? fat;

  RecipeModel(
      {required this.uid,
      required this.nameMenu,
      required this.recipeName,
      required this.description,
      required this.timeHour,
      required this.timeMinute,
      required this.method,
      required this.type,
      required this.calories,
      required this.protein,
      required this.carb,
      required this.fat});

  RecipeModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    nameMenu = json['nameMenu'];
    recipeName = json['recipeName'];
    description = json['description'];
    timeHour = json['timeHour'];
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
    data['uid'] = this.uid;
    data['nameMenu'] = this.nameMenu;
    data['recipeName'] = this.recipeName;
    data['description'] = this.description;
    data['timeHour'] = this.timeHour;
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
