import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/core/common%20model/banner_model.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

class BannerService {
  static const String bannerCollection = "Banners";
  static final bannerRef = FirebaseFirestore.instance.collection('banners');
  static Future<List<BannerModel>> fetchBanners() async {
    try {
      final QuerySnapshot querySnapshot = await bannerRef.get();
      final data = querySnapshot.docs
          .map((e) => BannerModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      for (final banners in data) {
        await HiveHelper.addBanners(banner: banners);
      }
      return data;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
