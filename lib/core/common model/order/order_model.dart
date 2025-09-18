// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sadhana_cart/core/common%20model/product/size_variant.dart';

class OrderModel {
  final int quantity;
  final String? userId;
  final double totalAmount;
  final String? address;
  final int phoneNumber;
  final double latitude;
  final double longitude;
  String? orderStatus;
  final Timestamp orderDate;
  final String? orderId;
  final Timestamp createdAt;
  final List<OrderProductModel> products;
  OrderModel({
    required this.quantity,
    this.userId,
    required this.totalAmount,
    this.address,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    this.orderStatus,
    required this.orderDate,
    this.orderId,
    required this.createdAt,
    required this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'userId': userId,
      'totalAmount': totalAmount,
      'address': address,
      'phoneNumber': phoneNumber,
      'latitude': latitude,
      'longitude': longitude,
      'orderStatus': orderStatus,
      'orderDate': orderDate,
      'orderId': orderId,
      'createdAt': createdAt,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      quantity: map['quantity'] as int,
      userId: map['userId'] != null ? map['userId'] as String : null,
      totalAmount: map['totalAmount'] as double,
      address: map['address'] != null ? map['address'] as String : null,
      phoneNumber: map['phoneNumber'] as int,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      orderStatus: map['orderStatus'] != null
          ? map['orderStatus'] as String
          : null,
      orderDate: map['orderDate'] as Timestamp,
      orderId: map['orderId'] != null ? map['orderId'] as String : null,
      createdAt: map['createdAt'] as Timestamp,
      products: List<OrderProductModel>.from(
        (map['products'] as List<int>).map<OrderProductModel>(
          (x) => OrderProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OrderProductModel {
  final String? id;
  final String? productid;
  final String? name;
  final double? price;
  int? stock;
  final int? quantity;
  final List<SizeVariant>? sizevariants;

  OrderProductModel({
    this.id,
    this.productid,
    this.name,
    this.price,
    this.stock,
    this.quantity,
    this.sizevariants,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productid': productid,
      'name': name,
      'price': price,
      'stock': stock,
      'quantity': quantity,
      'sizevariants': sizevariants?.map((x) => x.toMap()).toList(),
    };
  }

  factory OrderProductModel.fromMap(Map<String, dynamic> map) {
    return OrderProductModel(
      id: map['id'] != null ? map['id'] as String : null,
      productid: map['productid'] != null ? map['productid'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      price: map['price'] != null ? (map['price'] as num).toDouble() : null,
      stock: map['stock'] != null ? (map['stock'] as num).toInt() : null,
      quantity: map['quantity'] != null
          ? (map['quantity'] as num).toInt()
          : null,
      sizevariants: map['sizevariants'] != null
          ? (map['sizevariants'] as List<dynamic>)
                .map((x) => SizeVariant.fromMap(x as Map<String, dynamic>))
                .toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProductModel.fromJson(String source) =>
      OrderProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderProductModel(id: $id, productid: $productid, name: $name, price: $price, stock: $stock, quantity: $quantity, sizevariants: $sizevariants)';
  }
}
