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
  @HiveField(3)
  int quantity = 1;
  CartModel({
    required this.cartId,
    required this.customerId,
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartId': cartId,
      'customerId': customerId,
      'productId': productId,
      'quantity': quantity,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cartId: map['cartId'] as String,
      customerId: map['customerId'] as String,
      productId: map['productId'] as String,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
