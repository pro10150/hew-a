class MenuModel {
  int? id;
  String? nameMenu;
  String? mainIngredient;
  String? userID;

  MenuModel(
      {required this.nameMenu, required this.mainIngredient, this.userID});

  MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameMenu = json['name'];
    mainIngredient = json['mainIngredient'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.nameMenu;
    data['mainIngredient'] = this.mainIngredient;
    data['userID'] = this.userID;
    return data;
  }
}
