class MethodModel {
  int? methodid;
  String? nameMethod;

  MethodModel({
    required this.methodid,
    required this.nameMethod,
  });

  MethodModel.fromJson(Map<String, dynamic> json) {
    methodid = json['methodid'];
    nameMethod = json['nameMethod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['methodid'] = this.methodid;
    data['nameMethod'] = this.nameMethod;

    return data;
  }
}
