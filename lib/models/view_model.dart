class ViewModel {
  String? uid;
  int? recipeId;
  int? isView;

  ViewModel({required this.uid, required this.recipeId, required this.isView});

  ViewModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    recipeId = json['recipeId'];
    isView = json['isView'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['recipeId'] = this.recipeId;
    data['isView'] = this.isView;

    return data;
  }
}
