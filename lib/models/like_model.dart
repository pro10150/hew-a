class LikeModel {
  String? uid;
  String? recipeId;

  LikeModel({
    required this.uid,
    required this.recipeId,
  });

  LikeModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    recipeId = json['recipeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['uid'] = this.uid;
    data['recipeId'] = this.recipeId;

    return data;
  }
}
