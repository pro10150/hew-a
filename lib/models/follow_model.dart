<<<<<<< Updated upstream
class FollowModel {
  String? uid;
  String? followedUserID;

  FollowModel({required this.uid, required this.followedUserID});

  FollowModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    followedUserID = json['followedUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['followedUserID'] = this.followedUserID;
    return data;
  }
}
=======
class FollowModel {
  String? uid;
  String? followedUserID;

  FollowModel({required this.uid, required this.followedUserID});

  FollowModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    followedUserID = json['followedUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['followedUserID'] = this.followedUserID;
    return data;
  }
}
>>>>>>> Stashed changes
