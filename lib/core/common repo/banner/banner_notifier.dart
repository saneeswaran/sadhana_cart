import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/banner/banner_state.dart';
import 'package:sadhana_cart/core/common%20services/banner/banner_service.dart';
import 'package:sadhana_cart/core/helper/connection_helper.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

final bannerProvider =
    StateNotifierProvider.autoDispose<BannerNotifier, BannerState>(
      (ref) => BannerNotifier(ref)..initBanners(),
    );

class BannerNotifier extends StateNotifier<BannerState> {
  final Ref ref;
  BannerNotifier(this.ref) : super(BannerState.initial());

  void initBanners() async {
    final isInternet = await ConnectionHelper.checkInternetConnection();
    if (isInternet) {
      try {
        state = state.copyWith(isLoading: true, error: null, banner: []);
        final data = await BannerService.fetchBanners();
        for (final ban in data) {
          HiveHelper.addBanners(banner: ban);
        }
        state = state.copyWith(isLoading: false, banner: data, error: null);
      } catch (e) {
        state = state.copyWith(
          isLoading: false,
          error: e.toString(),
          banner: [],
        );
      }
    }
  }
}
