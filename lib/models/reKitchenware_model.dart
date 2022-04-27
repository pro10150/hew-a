class ReKitchenwareModel {
  int? id;
  String? recipeId;
  int? kitchenwareId;

  ReKitchenwareModel({required this.recipeId, required this.kitchenwareId});

  ReKitchenwareModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recipeId = json['recipeId'];
    kitchenwareId = json['kitchenwareId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['recipeId'] = this.recipeId;
    data['kitchenwareId'] = this.kitchenwareId;

    return data;
  }
}
