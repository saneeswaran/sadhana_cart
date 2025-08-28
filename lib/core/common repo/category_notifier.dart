import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/category_model.dart';
import 'package:sadhana_cart/core/common%20services/category_services.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/helper/connection_helper.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<CategoryModel>>(
      (ref) => CategoryNotifier(ref)..initializeCategory(),
    );

class CategoryNotifier extends StateNotifier<List<CategoryModel>> {
  final Ref ref;
  CategoryNotifier(this.ref) : super([]);

  void initializeCategory() async {
    final isInternet = await ConnectionHelper.checkInternetConnection();
    if (isInternet) {
      state = await CategoryServices.getAllCategory(ref: ref);
    } else {
      state = await HiveHelper.getCategoryModel();
      ref.read(loadingProvider.notifier).state = false;
    }
  }
}
