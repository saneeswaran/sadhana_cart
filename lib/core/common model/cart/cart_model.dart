// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 5)
class CartModel extends HiveObject {
  @HiveField(0)
  final String cartId;
  @HiveField(1)
  final String customerId;

  @HiveField(2)
  final String productId;
  CartModel({
    required this.cartId,
    required this.customerId,
    required this.productId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartId': cartId,
      'customerId': customerId,
      'productId': productId,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cartId: map['cartId'] as String,
      customerId: map['customerId'] as String,
      productId: map['productId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
