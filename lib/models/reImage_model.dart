class ReImageModel {
  int? id;
  String? name;
  int? recipeId;

  ReImageModel({required this.id, required this.recipeId});

  ReImageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    recipeId = json['jsonId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['recipeId'] = this.recipeId;
    return data;
  }
}
