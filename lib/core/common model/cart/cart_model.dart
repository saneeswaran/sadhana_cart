// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartModel {
  final String cartId;

  final String customerId;

  final String productid;

  int quantity = 1;

  final String? size;

  CartModel({
    required this.cartId,
    required this.customerId,
    required this.productid,
    required this.quantity,
    required this.size,
  });

  CartModel copyWith({
    String? cartId,
    String? customerId,
    String? productid,
    int? quantity,
    String? sizeVariant,
  }) {
    return CartModel(
      cartId: cartId ?? this.cartId,
      customerId: customerId ?? this.customerId,
      productid: productid ?? this.productid,
      quantity: quantity ?? this.quantity,
      size: sizeVariant ?? size,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cartId': cartId,
      'customerId': customerId,
      'productid': productid,
      'quantity': quantity,
      'sizeVariant': size,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      cartId: map['cartId'].toString(),
      customerId: map['customerId'].toString(),
      productid: map['productid'].toString(),
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
    return 'CartModel(cartId: $cartId, customerId: $customerId, productid: $productid, quantity: $quantity, size: $size)';
  }

  @override
  bool operator ==(covariant CartModel other) {
    if (identical(this, other)) return true;

    return other.cartId == cartId &&
        other.customerId == customerId &&
        other.productid == productid &&
        other.quantity == quantity &&
        other.size == size;
  }

  @override
  int get hashCode {
    return cartId.hashCode ^
        customerId.hashCode ^
        productid.hashCode ^
        quantity.hashCode ^
        size.hashCode;
  }
}
