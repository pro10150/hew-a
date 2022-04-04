<<<<<<< Updated upstream
class CommentLikeModel {
  String? id;
  String? commentId;
  String? uid;

  CommentLikeModel({required this.commentId, required this.uid});

  CommentLikeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentId = json['commentId'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['commentId'] = this.commentId;
    data['uid'] = this.uid;
    return data;
  }
}
=======
class CommentLikeModel {
  String? id;
  String? commentId;
  String? uid;

  CommentLikeModel({required this.commentId, required this.uid});

  CommentLikeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    commentId = json['commentId'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['commentId'] = this.commentId;
    data['uid'] = this.uid;
    return data;
  }
}
>>>>>>> Stashed changes
