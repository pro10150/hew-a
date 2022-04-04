<<<<<<< Updated upstream
class CommentModel {
  String? text;
  String? uid;
  int? recipeId;
  String? date;

  CommentModel(
      {required this.text,
      required this.uid,
      required this.recipeId,
      required this.date});

  CommentModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    uid = json['uid'];
    recipeId = json['recipeId'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['uid'] = this.uid;
    data['recipeId'] = this.recipeId;
    data['date'] = this.date;
    return data;
  }
}
=======
class CommentModel {
  String? text;
  String? uid;
  int? recipeId;
  String? date;

  CommentModel(
      {required this.text,
      required this.uid,
      required this.recipeId,
      required this.date});

  CommentModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    uid = json['uid'];
    recipeId = json['recipeId'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['uid'] = this.uid;
    data['recipeId'] = this.recipeId;
    data['date'] = this.date;
    return data;
  }
}
>>>>>>> Stashed changes
