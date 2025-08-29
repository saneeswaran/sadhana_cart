import 'dart:convert';

import 'package:hive/hive.dart';

part 'favorute_model.g.dart';

@HiveType(typeId: 6)
class FavoruteModel extends HiveObject {
  @HiveField(0)
  final String productId;
  @HiveField(1)
  final String customerId;
  FavoruteModel({required this.productId, required this.customerId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'productId': productId, 'customerId': customerId};
  }

  factory FavoruteModel.fromMap(Map<String, dynamic> map) {
    return FavoruteModel(
      productId: map['productId'] as String,
      customerId: map['customerId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoruteModel.fromJson(String source) =>
      FavoruteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
