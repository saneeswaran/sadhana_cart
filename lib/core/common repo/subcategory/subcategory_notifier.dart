import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/subcategory/subcategory_model.dart';
import 'package:sadhana_cart/core/common%20repo/subcategory/subcategory_state.dart';
import 'package:sadhana_cart/core/common%20services/subcategory/subcategory_service.dart';

final subcategoryProvider =
    StateNotifierProvider<SubcategoryNotifier, SubcategoryState>(
      (ref) => SubcategoryNotifier(),
    );

final getSpecificSubcategoryByCategoryProvider = FutureProvider.autoDispose
    .family<List<SubcategoryModel>, String>((ref, category) async {
      return await SubcategoryService.fetchSubcategory();
    });

class SubcategoryNotifier extends StateNotifier<SubcategoryState> {
  SubcategoryNotifier() : super(SubcategoryState.initial());
}
