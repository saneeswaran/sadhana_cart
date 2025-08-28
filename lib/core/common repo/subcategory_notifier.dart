import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/subcategory_model.dart';
import 'package:sadhana_cart/core/common%20services/subcategory_service.dart';
import 'package:sadhana_cart/core/helper/connection_helper.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

final subcategoryProvider =
    StateNotifierProvider<SubcategoryNotifier, List<SubcategoryModel>>(
      (ref) => SubcategoryNotifier()..initialize(),
    );

class SubcategoryNotifier extends StateNotifier<List<SubcategoryModel>> {
  SubcategoryNotifier() : super([]);

  void initialize() async {
    final bool isInternet = await ConnectionHelper.checkInternetConnection();
    if (isInternet) {
      state = await SubcategoryService.fetchSubcategory();
    } else {
      state = await HiveHelper.getSubcategory();
    }
  }
}
