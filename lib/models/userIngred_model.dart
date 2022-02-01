class UserIngredModel {
  String? uid;
  int? ingredientId;
  double? amount;
  String? unit;

  UserIngredModel(
      {required this.uid,
      required this.ingredientId,
      required this.amount,
      required this.unit});

  UserIngredModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    ingredientId = json['ingredientId'];
    amount = json['amount'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['ingredientId'] = this.ingredientId;
    data['amount'] = this.amount;
    data['unit'] = this.unit;
    return data;
  }
}
