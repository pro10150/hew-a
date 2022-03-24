class ReStepModel {
  String? recipeId;
  int? step;
  int? minute;
  String? description;

  ReStepModel(
      {required this.recipeId, required this.step, required this.description});

  ReStepModel.fromJson(Map<String, dynamic> json) {
    recipeId = json['recipeId'];
    step = json['step'];
    minute = json['minute'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['recipeId'] = this.recipeId;
    data['step'] = this.step;
    data['minute'] = this.minute;
    data['description'] = this.description;

    return data;
  }
}
