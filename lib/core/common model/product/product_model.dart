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
    required this.images,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': productId,
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
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      subCategory: map['subCategory'] ?? '',
      sku: map['sku'] ?? '',
      brand: map['brand'] ?? '',
      price: (map['price'] as num).toDouble(),
      stock: map['stock'] ?? 0,
      rating: (map['rating'] as num).toDouble(),
      timestamp: map['timestamp'] ?? Timestamp.now(),
      images: List<String>.from(map['images'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $productId, name: $name, description: $description, category: $category, subCategory: $subCategory, sku: $sku, brand: $brand, price: $price, stock: $stock, rating: $rating, timestamp: $timestamp, images: $images)';
  }

  ProductModel copyWith({
    String? productId,
    String? name,
    String? description,
    String? category,
    String? subCategory,
    String? sku,
    String? brand,
    double? price,
    int? stock,
    double? rating,
    Timestamp? timestamp,
    List<String>? images,
  }) {
    return ProductModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      subCategory: subCategory ?? this.subCategory,
      sku: sku ?? this.sku,
      brand: brand ?? this.brand,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      rating: rating ?? this.rating,
      timestamp: timestamp ?? this.timestamp,
      images: images ?? this.images,
    );
  }
}
