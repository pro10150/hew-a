import 'dart:typed_data';

class UserModel {
  String? uid;
  String? name;
  String? username;
  Uint8List? image;

  UserModel({required this.uid, this.name, required this.username, this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    username = json['username'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['username'] = this.username;
    data['image'] = this.image;

    return data;
  }
}
