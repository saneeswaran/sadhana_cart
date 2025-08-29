// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 4)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String productId;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final String subCategory;
  @HiveField(5)
  final String sku;
  @HiveField(6)
  final String brand;
  @HiveField(7)
  final double price;
  @HiveField(8)
  final int stock;
  @HiveField(9)
  final double rating;
  @HiveField(10)
  final Timestamp timestamp;
  @HiveField(11)
  final List<String> images;
  @HiveField(12)
  final String? sellerId;
  @HiveField(13)
  final List<Map<String, dynamic>> attributes;

  ProductModel({
    required this.productId,
    required this.name,
    required this.description,
    required this.category,
    required this.subCategory,
    required this.sku,
    required this.brand,
    required this.price,
    required this.stock,
    required this.rating,
    required this.timestamp,
    required this.images,
    required this.attributes,
    this.sellerId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'name': name,
      'description': description,
      'category': category,
      'subCategory': subCategory,
      'sku': sku,
      'brand': brand,
      'price': price,
      'stock': stock,
      'rating': rating,
      'timestamp': timestamp,
      'images': images,
      'sellerId': sellerId,
      'attributes': attributes,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      subCategory: map['subCategory'] as String,
      sku: map['sku'] as String,
      brand: map['brand'] as String,
      price: map['price'] as double,
      stock: map['stock'] as int,
      rating: map['rating'] as double,
      timestamp: map['timestamp'] as Timestamp,
      images: List<String>.from((map['images'] as List<String>)),
      sellerId: map['sellerId'] != null ? map['sellerId'] as String : null,
      attributes: List<Map<String, dynamic>>.from(
        (map['attributes'] as List<Map<String, dynamic>>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
