class LikeModel {
  String? uid;
  int? recipeId;
  String? datetime;

  LikeModel({required this.uid, required this.recipeId, this.datetime});

  LikeModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    recipeId = json['recipeId'];
    datetime = json['datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['uid'] = this.uid;
    data['recipeId'] = this.recipeId;
    data['datetime'] = this.datetime;

    return data;
  }
}
