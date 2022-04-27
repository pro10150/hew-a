class ReIngredModel {
  String? recipeId;
  int? ingredientId;
  double? amount;
  String? unit;
  int? isPrimary;

  ReIngredModel(
      {this.recipeId,
      required this.ingredientId,
      this.amount,
      this.unit,
      this.isPrimary});

  ReIngredModel.fromJson(Map<String, dynamic> json) {
    recipeId = json['recipeId'];
    ingredientId = json['ingredientId'];
    amount = json['amount'];
    unit = json['unit'];
    isPrimary = json['isPrimary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipeId'] = this.recipeId;
    data['ingredientId'] = this.ingredientId;
    data['amount'] = this.amount;
    data['unit'] = this.unit;
    data['isPrimary'] = this.isPrimary;
    return data;
  }
}
