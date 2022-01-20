import 'dart:typed_data';

class MenuModel {
  int? id;
  String? nameMenu;
  String? mainIngredient;
  String? userID;
  String? image;

  MenuModel(
      {required this.nameMenu,
      required this.mainIngredient,
      this.userID,
      this.image});

  MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameMenu = json['nameMenu'];
    mainIngredient = json['mainIngredient'];
    userID = json['userID'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameMenu'] = this.nameMenu;
    data['mainIngredient'] = this.mainIngredient;
    data['userID'] = this.userID;
    data['image'] = this.image;
    return data;
  }
}
