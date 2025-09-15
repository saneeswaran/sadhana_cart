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

  factory SizeVariant.fromJson(Map<String, dynamic> json) =>
      _$SizeVariantFromJson(json);

  Map<String, dynamic> toJson() => _$SizeVariantToJson(this);

  factory SizeVariant.fromMap(Map<String, dynamic> map) =>
      SizeVariant.fromJson(map);

  Map<String, dynamic> toMap() => toJson();

  @override
  String toString() {
    return 'SizeVariant{size: $size, color: $color, stock: $stock, skuSuffix: $skuSuffix}';
  }
}
