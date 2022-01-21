class StepModel {
  String? recipeID;
  int? step;
  String? text;
  String? image;

  StepModel(
      {required this.recipeID,
      required this.step,
      required this.text,
      required this.image});

  StepModel.fromJson(Map<String, dynamic> json) {
    recipeID = json['recipeID'];
    step = json['Step'];
    text = json['Text'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['recipeID'] = this.recipeID;
    data['Step'] = this.step;
    data['Text'] = this.text;
    data['image'] = this.image;

    return data;
  }
}
