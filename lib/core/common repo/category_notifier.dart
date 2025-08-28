import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/category_model.dart';
import 'package:sadhana_cart/core/common%20services/category_services.dart';

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<CategoryModel>>(
      (ref) => CategoryNotifier()..initializeCategory(),
    );

class CategoryNotifier extends StateNotifier<List<CategoryModel>> {
  CategoryNotifier() : super([]);

  void initializeCategory() async {
    state = await CategoryServices.getAllCategory();
  }
}
