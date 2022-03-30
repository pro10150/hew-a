class CommentUserModel {
  String? text;
  String? uid;
  int? recipeId;
  String? date;
  String? name;
  String? username;
  String? image;
  int? ingredients;
  int? kitchenwares;

  CommentUserModel(
      {required this.uid,
      required this.text,
      required this.recipeId,
      required this.date,
      this.username,
      this.image,
      this.ingredients,
      this.name,
      this.kitchenwares});

  CommentUserModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    recipeId = json['recipeId'];
    date = json['date'];
    uid = json['uid'];
    name = json['name'];
    username = json['username'];
    image = json['image'];
    ingredients = json['ingredients'];
    kitchenwares = json['kitchenwares'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['recipeId'] = this.recipeId;
    data['date'] = this.date;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['username'] = this.username;
    data['image'] = this.image;
    data['ingredients'] = this.ingredients;
    data['kitchenwares'] = this.kitchenwares;

    return data;
  }
}
