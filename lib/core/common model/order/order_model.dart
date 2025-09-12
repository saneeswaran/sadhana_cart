// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sadhana_cart/core/common%20model/product/product_model.dart';

class OrderModel {
  final int quantity;
  final String userId;
  final double totalAmount;
  final String address;
  final int phoneNumber;
  final double latitude;
  final double longitude;
  String orderStatus;
  final String orderDate;
  final String orderId;
  final Timestamp createdAt;
  final List<ProductModel> products;
  OrderModel({
    required this.quantity,
    required this.userId,
    required this.totalAmount,
    required this.address,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.orderStatus,
    required this.orderDate,
    required this.orderId,
    required this.createdAt,
    required this.products,
  });

  OrderModel copyWith({
    String? userId,
    double? totalAmount,
    String? address,
    int? phoneNumber,
    double? latitude,
    double? longitude,
    String? orderStatus,
    String? orderDate,
    String? orderId,
    Timestamp? createdAt,
    List<ProductModel>? products,
    int? quantity,
  }) {
    return OrderModel(
      quantity: quantity ?? this.quantity,
      userId: userId ?? this.userId,
      totalAmount: totalAmount ?? this.totalAmount,
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      orderStatus: orderStatus ?? this.orderStatus,
      orderDate: orderDate ?? this.orderDate,
      orderId: orderId ?? this.orderId,
      createdAt: createdAt ?? this.createdAt,
      products: products ?? this.products,
    );
  }

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
      userId: map['userId'] as String,
      totalAmount: map['totalAmount'] as double,
      address: map['address'] as String,
      phoneNumber: map['phoneNumber'] as int,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      orderStatus: map['orderStatus'] as String,
      orderDate: map['orderDate'] as String,
      orderId: map['orderId'] as String,
      createdAt: map['createdAt'] as Timestamp,
      products: List<ProductModel>.from(
        (map['products'] as List<int>).map<ProductModel>(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
