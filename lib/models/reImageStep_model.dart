class ReImageStepModel {
  int? id;
  int? recipeId;
  int? stepId;
  String? name;

  ReImageStepModel(
      {this.id,
      required this.recipeId,
      required this.stepId,
      required this.name});

  ReImageStepModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    recipeId = json['recipeId'];
    stepId = json['stepId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['recipeId'] = this.recipeId;
    data['stepId'] = this.stepId;
    data['name'] = this.name;
    return data;
  }
}
