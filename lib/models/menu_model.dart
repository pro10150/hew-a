<<<<<<< Updated upstream
import 'dart:typed_data';

class MenuModel {
  int? id;
  String? nameMenu;
  String? mainIngredient;
  String? userID;
  String? menuImage;
  int? methodid;

  MenuModel(
      {required this.nameMenu,
      required this.mainIngredient,
      this.userID,
      this.menuImage,
      this.methodid});

  MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameMenu = json['nameMenu'];
    mainIngredient = json['mainIngredient'];
    userID = json['userID'];
    menuImage = json['menuImage'];
    methodid = json['methodid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameMenu'] = this.nameMenu;
    data['mainIngredient'] = this.mainIngredient;
    data['userID'] = this.userID;
    data['menuImage'] = this.menuImage;
    data['methodid'] = this.methodid;
    return data;
  }
}
=======
import 'dart:typed_data';

class MenuModel {
  int? id;
  String? nameMenu;
  String? mainIngredient;
  String? userID;
  String? menuImage;
  int? methodid;

  MenuModel(
      {required this.nameMenu,
      required this.mainIngredient,
      this.userID,
      this.menuImage,
      this.methodid});

  MenuModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameMenu = json['nameMenu'];
    mainIngredient = json['mainIngredient'];
    userID = json['userID'];
    menuImage = json['menuImage'];
    methodid = json['methodid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nameMenu'] = this.nameMenu;
    data['mainIngredient'] = this.mainIngredient;
    data['userID'] = this.userID;
    data['menuImage'] = this.menuImage;
    data['methodid'] = this.methodid;
    return data;
  }
}
>>>>>>> Stashed changes
