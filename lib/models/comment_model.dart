class CommentModel {
  String? commentID;
  String? text;
  String? userID;
  String? recipeID;
  String? date;

  CommentModel(
      {required this.commentID,
      required this.text,
      required this.userID,
      required this.recipeID,
      required this.date});

  CommentModel.fromJson(Map<String, dynamic> json) {
    commentID = json['commentID'];
    text = json['text'];
    userID = json['userID'];
    recipeID = json['recipeID'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentID'] = this.commentID;
    data['text'] = this.text;
    data['userID'] = this.userID;
    data['recipeID'] = this.recipeID;
    data['date'] = this.date;
    return data;
  }
}
