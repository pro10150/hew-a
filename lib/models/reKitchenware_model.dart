class ReKitchenwareModel {
  String? recipeId;
  String? kitchenwareId;

  ReKitchenwareModel({required this.recipeId, required this.kitchenwareId});

  ReKitchenwareModel.fromJson(Map<String, dynamic> json) {
    recipeId = json['recipeId'];
    kitchenwareId = json['kitchenwareId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['recipeId'] = this.recipeId;
    data['kitchenwareId'] = this.kitchenwareId;

    return data;
  }
}
