import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/banner_model.dart';
import 'package:sadhana_cart/core/common%20services/banner_service.dart';
import 'package:sadhana_cart/core/helper/connection_helper.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

final bannerProvider = StateNotifierProvider<BannerNotifier, List<BannerModel>>(
  (ref) => BannerNotifier()..initBanners(),
);

class BannerNotifier extends StateNotifier<List<BannerModel>> {
  BannerNotifier() : super([]);

  void initBanners() async {
    final isInternet = await ConnectionHelper.checkInternetConnection();

    if (isInternet) {
      state = await BannerService.fetchBanners();
    } else {
      state = await HiveHelper.getBannerModel();
    }
  }
}
