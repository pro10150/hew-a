import 'dart:typed_data';

class UserModel {
  String? uid;
  String? name;
  String? username;
  Uint8List? image;
  int? ingredients;
  int? kitchenwares;

  UserModel(
      {required this.uid,
      this.name,
      required this.username,
      this.image,
      this.ingredients,
      this.kitchenwares});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    username = json['username'];
    image = json['image'];
    ingredients = json['ingredients'];
    kitchenwares = json['kitchenwares'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['username'] = this.username;
    data['image'] = this.image;
    data['ingredients'] = this.ingredients;
    data['kitchenwares'] = this.kitchenwares;

    return data;
  }
}
