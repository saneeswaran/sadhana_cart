import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryModel {
  final String id;
  final String name;
  final String imageUrl;
  CategoryModel({required this.id, required this.name, required this.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'imageUrl': imageUrl};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
