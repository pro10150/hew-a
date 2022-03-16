class ReIngredIngredModel {
  int? id;
  String? recipeId;
  String? name;
  String? type;
  String? image;
  double? amount;
  String? unit;

  ReIngredIngredModel(
      {this.id,
      this.recipeId,
      this.name,
      this.type,
      this.image,
      this.amount,
      this.unit});

  ReIngredIngredModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recipeId = json['recipeId'];
    name = json['name'];
    type = json['type'];
    image = json['image'];
    amount = json['amount'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['recipeId'] = this.recipeId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['image'] = this.image;
    data['amount'] = this.amount;
    data['unit'] = this.unit;
    return data;
  }
}
