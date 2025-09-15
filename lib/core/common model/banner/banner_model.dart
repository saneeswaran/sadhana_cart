import 'dart:convert';

import 'package:hive/hive.dart';

part 'banner_model.g.dart';

@HiveType(typeId: 1)
class BannerModel extends HiveObject {
  @HiveField(0)
  final String bannerId;
  @HiveField(1)
  final String bannerName;
  @HiveField(2)
  final String bannerImage;
  @HiveField(3)
  final String productid;
  BannerModel({
    required this.bannerId,
    required this.bannerName,
    required this.bannerImage,
    required this.productid,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bannerId': bannerId,
      'bannerName': bannerName,
      'bannerImage': bannerImage,
      'productid': productid,
    };
  }

  factory BannerModel.fromMap(Map<String, dynamic> map) {
    return BannerModel(
      bannerId: map['bannerId'] as String,
      bannerName: map['bannerName'] as String,
      bannerImage: map['bannerImage'] as String,
      productid: map['productid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
