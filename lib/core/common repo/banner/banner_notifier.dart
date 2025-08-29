import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/banner/banner_model.dart';
import 'package:sadhana_cart/core/common%20services/banner/banner_service.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/helper/connection_helper.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

final bannerProvider = StateNotifierProvider<BannerNotifier, List<BannerModel>>(
  (ref) => BannerNotifier(ref)..initBanners(),
);

class BannerNotifier extends StateNotifier<List<BannerModel>> {
  final Ref ref;
  BannerNotifier(this.ref) : super([]);

  void initBanners() async {
    final isInternet = await ConnectionHelper.checkInternetConnection();

    if (isInternet) {
      state = await BannerService.fetchBanners(ref: ref);
    } else {
      state = HiveHelper.getBannerModel();
    }
    ref.read(loadingProvider.notifier).state = false;
  }
}
