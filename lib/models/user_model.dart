class UserModel {
  String? userID;
  String? name;
  String? email;
  String? username;
  String? password;
  String? image;

  UserModel(
      {required this.userID,
      required this.name,
      required this.email,
      required this.username,
      required this.password,
      required this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['image'] = this.image;

    return data;
  }
}
