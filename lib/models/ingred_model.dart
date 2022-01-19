import 'dart:typed_data';

class IngredModel {
  int? id;
  String? name;
  String? type;
  Uint8List? picture;

  IngredModel(
      {required this.id,
      required this.name,
      required this.type,
      required this.picture});

  IngredModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['picture'] = this.picture;

    return data;
  }
}
