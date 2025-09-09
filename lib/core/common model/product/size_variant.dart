import 'package:hive/hive.dart';

part 'size_variant.g.dart';

@HiveType(typeId: 9)
class SizeVariant extends HiveObject {
  @HiveField(0)
  final String size;

  @HiveField(1)
  final String? color;

  @HiveField(2)
  int stock;

  @HiveField(3)
  final String? skuSuffix;

  SizeVariant({
    required this.size,
    this.color,
    required this.stock,
    this.skuSuffix,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'color': color,
      'stock': stock,
      'skuSuffix': skuSuffix,
    };
  }

  // Create from Map
  factory SizeVariant.fromMap(Map<String, dynamic> map) {
    return SizeVariant(
      size: map['size'] ?? '',
      color: map['color'],
      stock: map['stock'] ?? 0,
      skuSuffix: map['skuSuffix'],
    );
  }

  @override
  String toString() {
    return 'SizeVariant{size: $size, color: $color, stock: $stock}';
  }
}
