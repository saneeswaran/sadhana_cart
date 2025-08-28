import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/banner_model.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

class BannerService {
  static const String bannerCollection = "Banners";
  static final bannerRef = FirebaseFirestore.instance.collection('banners');
  static Future<List<BannerModel>> fetchBanners({required Ref ref}) async {
    try {
      ref.read(loadingProvider.notifier).state = true;
      final QuerySnapshot querySnapshot = await bannerRef.get();
      final data = querySnapshot.docs
          .map((e) => BannerModel.fromMap(e.data() as Map<String, dynamic>))
          .toList();
      for (final banners in data) {
        await HiveHelper.addBanners(banner: banners);
      }
      ref.read(loadingProvider.notifier).state = false;
      return data;
    } catch (e) {
      ref.read(loadingProvider.notifier).state = false;
      log("banner service error $e");
      return [];
    }
  }
}
