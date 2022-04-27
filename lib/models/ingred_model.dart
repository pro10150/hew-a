import 'dart:typed_data';

class IngredModel {
  int? id;
  String? name;
  String? type;
  String? image;

  IngredModel(
      {this.id, required this.name, this.type, required this.image});

  IngredModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['image'] = this.image;

    return data;
  }
}
