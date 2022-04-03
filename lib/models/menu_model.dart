import 'dart:typed_data';

class MenuModel {
  int? id;
  String? nameMenu;
  String? descMenu;
  int? mainIngredient;
  String? userID;
  String? menuImage;
  int? methodid;

  MenuModel(
      {required this.nameMenu,
      required this.mainIngredient,
        this.id,
      this.descMenu,
      this.userID,
      this.menuImage,
      this.methodid});

  MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameMenu = json['nameMenu'];
    descMenu = json['descMenu'];
    mainIngredient = json['mainIngredient'];
    userID = json['userID'];
    menuImage = json['image'];
    methodid = json['methodid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameMenu'] = this.nameMenu;
    data['descMenu'] = this.descMenu;
    data['mainIngredient'] = this.mainIngredient;
    data['userID'] = this.userID;
    data['menuImage'] = this.menuImage;
    data['methodid'] = this.methodid;

    return data;
  }
}
