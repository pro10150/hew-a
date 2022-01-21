class UserMenuModel {
  String? uid;
  int? menuId;

  UserMenuModel({required this.uid, required this.menuId});

  UserMenuModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    menuId = json['menuId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['menuId'] = this.menuId;
    return data;
  }
}
