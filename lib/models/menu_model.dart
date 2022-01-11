class MenuModel {
  String? nameMenu;
  String? userID;

  MenuModel({required this.nameMenu, required this.userID});

  MenuModel.fromJson(Map<String, dynamic> json) {
    nameMenu = json['name'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.nameMenu;
    data['userID'] = this.userID;
    return data;
  }
}
