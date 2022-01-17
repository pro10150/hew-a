class Photo {
  int? id;
  String? photoName;

  Photo({required this.id, required this.photoName});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photoName = json['photoName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = new Map<String, dynamic>();

    map['id'] = this.id;
    map['photoName'] = this.photoName;

    return map;
  }
}
