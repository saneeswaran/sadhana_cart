// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
<<<<<<< HEAD
=======
import 'dart:developer';

>>>>>>> 571b95b7ba6f515bbb20b9deda60f2f47be4ce75
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
    log("products ${map['products']}");
    return OrderModel(
<<<<<<< HEAD
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
=======
      quantity: map['quantity'],
      userId: map['userId'],
      totalAmount: map['totalAmount'],
      address: map['address'],
      phoneNumber: map['phoneNumber'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      orderStatus: map['orderStatus'],
      orderDate: map['orderDate'],
      orderId: map['orderId'],
      createdAt: map['createdAt'],
      products: map['products'] != null
          ? (map['products'] is List<dynamic>)
                ? List<OrderProductModel>.from(
                    (map['products'] as List<dynamic>).map<OrderProductModel>(
                      (x) =>
                          OrderProductModel.fromMap(x as Map<String, dynamic>),
                    ),
                  )
                : []
          : [],
>>>>>>> 571b95b7ba6f515bbb20b9deda60f2f47be4ce75
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
      id: map['id'],
      productid: map['productid'],
      name: map['name'],
      price: map['price'],
      stock: map['stock'],
      quantity: map['quantity'],
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
