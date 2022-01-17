import 'package:firebase_auth/firebase_auth.dart';

class UserKitchenwareModel {
  String? uid;
  String? kitchenware;

  UserKitchenwareModel({required this.uid, required this.kitchenware});

  UserKitchenwareModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    kitchenware = json['kitchenware'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['kitchenware'] = this.kitchenware;
    return data;
  }
}
