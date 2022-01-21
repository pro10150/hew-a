class CommentLikeModel {
  String? commentID;
  String? userID;

  CommentLikeModel({required this.commentID, required this.userID});

  CommentLikeModel.fromJson(Map<String, dynamic> json) {
    commentID = json['commentID'];
    userID = json['userID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['commentID'] = this.commentID;
    data['userID'] = this.userID;
    return data;
  }
}
