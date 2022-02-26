import 'dart:typed_data';

class MenuModel {
  int? id;
  String? nameMenu;
  String? mainIngredient;
  String? userID;
  String? image;
  int? methodid;

  MenuModel(
      {required this.nameMenu,
      required this.mainIngredient,
      this.userID,
      this.image,
      this.methodid});

  MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameMenu = json['nameMenu'];
    mainIngredient = json['mainIngredient'];
    userID = json['userID'];
    image = json['image'];
    methodid = json['methodid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameMenu'] = this.nameMenu;
    data['mainIngredient'] = this.mainIngredient;
    data['userID'] = this.userID;
    data['image'] = this.image;
    data['methodid'] = this.methodid;
    return data;
  }
}
