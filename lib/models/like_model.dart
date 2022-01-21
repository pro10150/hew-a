class LikeModel {
  String? userID;
  String? recipeID;

  LikeModel({
    required this.userID,
    required this.recipeID,
  });

  LikeModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    recipeID = json['recipeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['userID'] = this.userID;
    data['recipeID'] = this.recipeID;

    return data;
  }
}
