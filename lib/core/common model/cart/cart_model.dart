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

  @HiveField(4)
  final String? size;

  CartModel({
    required this.cartId,
    required this.customerId,
    required this.productId,
    required this.quantity,
    required this.size,
  });

  CartModel copyWith({
    String? cartId,
    String? customerId,
    String? productId,
    int? quantity,
    String? sizeVariant,
  }) {
    return CartModel(
      cartId: cartId ?? this.cartId,
      customerId: customerId ?? this.customerId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      size: sizeVariant ?? size,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cartId': cartId,
      'customerId': customerId,
      'productId': productId,
      'quantity': quantity,
      'sizeVariant': size,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cartId: map['cartId'].toString(),
      customerId: map['customerId'].toString(),
      productId: map['productId'].toString(),
      quantity: map['quantity'] is int
          ? map['quantity']
          : int.tryParse(map['quantity'].toString()) ?? 1,
      size: map['sizeVariant']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartModel(cartId: $cartId, customerId: $customerId, productId: $productId, quantity: $quantity, size: $size)';
  }
}
