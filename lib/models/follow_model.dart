class FollowModel {
  String? followerUserID;
  String? followeeUserID;

  FollowModel({required this.followerUserID, required this.followeeUserID});

  FollowModel.fromJson(Map<String, dynamic> json) {
    followerUserID = json['followerUserID'];
    followeeUserID = json['followeeUserID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['followerUserID'] = this.followerUserID;
    data['followeeUserID'] = this.followeeUserID;
    return data;
  }
}
