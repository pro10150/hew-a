class ReIngredModel {
  String? recipeId;
  int? ingredientId;
  double? amount;
  String? unit;

  ReIngredModel(
      {required this.recipeId,
      required this.ingredientId,
      required this.amount,
      required this.unit});

  ReIngredModel.fromJson(Map<String, dynamic> json) {
    recipeId = json['recipeId'];
    ingredientId = json['ingredientId'];
    amount = json['amount'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipeId'] = this.recipeId;
    data['ingredientId'] = this.ingredientId;
    data['amount'] = this.amount;
    data['unit'] = this.unit;
    return data;
  }
}
