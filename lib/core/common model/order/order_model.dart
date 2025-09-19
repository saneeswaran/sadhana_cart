// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
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
  final String? orderStatus;
  final Timestamp orderDate;
  final String? orderId;
  final Timestamp createdAt;
  final List<OrderProductModel> products;

  // Shiprocket fields
  final int? shiprocketOrderId; // API order_id
  final String? shiprocketStatus; // API status

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
    this.shiprocketOrderId,
    this.shiprocketStatus,
  });

  // copyWith for immutability
  OrderModel copyWith({
    int? quantity,
    String? userId,
    double? totalAmount,
    String? address,
    int? phoneNumber,
    double? latitude,
    double? longitude,
    String? orderStatus,
    Timestamp? orderDate,
    String? orderId,
    Timestamp? createdAt,
    List<OrderProductModel>? products,
    int? shiprocketOrderId,
    String? shiprocketStatus,
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
      shiprocketOrderId: shiprocketOrderId ?? this.shiprocketOrderId,
      shiprocketStatus: shiprocketStatus ?? this.shiprocketStatus,
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
      'shiprocketOrderId': shiprocketOrderId,
      'shiprocketStatus': shiprocketStatus,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    log("product data: ${map['product']}");

    final Timestamp fallbackDate = Timestamp.fromDate(
      DateTime(2025, 1, 1, 10, 0),
    ); // demo value

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
        (map['products'] as List<dynamic>).map<OrderProductModel>(
          (x) => OrderProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      shiprocketOrderId: map['shiprocketOrderId'] != null
          ? (map['shiprocketOrderId'] as num).toInt()
          : null,
      shiprocketStatus: map['shiprocketStatus'] != null
          ? map['shiprocketStatus'] as String
          : null,
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
  final int? stock;
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

  // copyWith for immutability
  OrderProductModel copyWith({
    String? id,
    String? productid,
    String? name,
    double? price,
    int? stock,
    int? quantity,
    List<SizeVariant>? sizevariants,
  }) {
    return OrderProductModel(
      id: id ?? this.id,
      productid: productid ?? this.productid,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      quantity: quantity ?? this.quantity,
      sizevariants: sizevariants ?? this.sizevariants,
    );
  }

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
      id: map['id']?.toString(),
      productid: map['productid']?.toString(),
      name: map['name']?.toString(),
      price: (map['price'] ?? 0).toDouble(),
      stock: (map['stock'] ?? 0) as int,
      quantity: (map['quantity'] ?? 0) as int,
      sizevariants: map['sizevariants'] != null
          ? (map['sizevariants'] as List<dynamic>)
                .map((x) => SizeVariant.fromMap(x as Map<String, dynamic>))
                .toList()
          : [],
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
