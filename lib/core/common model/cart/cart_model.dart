import 'dart:convert';

import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 5)
class CartModel extends HiveObject {
  @HiveField(0)
  final String customerId;

  @HiveField(1)
  final String productId;

  CartModel({required this.customerId, required this.productId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'customerId': customerId, 'productId': productId};
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      customerId: map['customerId'] as String,
      productId: map['productId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CartModel(customerId: $customerId, productId: $productId)';
}
