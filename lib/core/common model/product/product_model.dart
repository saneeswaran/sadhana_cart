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
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      subCategory: map['subCategory'] ?? '',
      sku: map['sku'] ?? '',
      brand: map['brand'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      stock: map['stock'] ?? 0,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      timestamp: map['timestamp'] is Timestamp
          ? map['timestamp']
          : Timestamp.fromMillisecondsSinceEpoch(map['timestamp'] ?? 0),
      images: List<String>.from(map['images'] ?? []),
      attributes: List<Map<String, dynamic>>.from(
        (map['attributes'] ?? []).map((e) => Map<String, dynamic>.from(e)),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
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
      'attributes': attributes,
    };
  }
}
