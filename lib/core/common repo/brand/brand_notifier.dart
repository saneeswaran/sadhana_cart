import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/brand/brand_model.dart';
import 'package:sadhana_cart/core/common%20services/brand/brand_service.dart';
import 'package:sadhana_cart/core/helper/connection_helper.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

class BrandNotifier extends StateNotifier<List<BrandModel>> {
  BrandNotifier() : super([]);

  void initialize() async {
    final bool isInternet = await ConnectionHelper.checkInternetConnection();
    if (isInternet) {
      state = await BrandService.fetchBrands();
    } else {
      state = HiveHelper.getBrands();
    }
  }
}
