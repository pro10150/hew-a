class UserModel {
  String? userID;
  String? name;
  String? username;
  String? password;
  String? image;

  UserModel(
      {required this.userID,
      required this.name,
      required this.username,
      required this.password,
      required this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    name = json['Name'];
    username = json['Username'];
    password = json['Password'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['Name'] = this.name;
    data['Username'] = this.username;
    data['Password'] = this.password;
    data['image'] = this.image;

    return data;
  }
}
