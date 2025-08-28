import 'package:hive/hive.dart';
import 'package:sadhana_cart/core/common%20model/banner_model.dart';
import 'package:sadhana_cart/core/common%20model/category_model.dart';
import 'package:sadhana_cart/core/common%20model/search_field_model.dart';

class HiveHelper {
  static const String bannerBox = 'bannerBox';
  static const String categoryBox = 'categoryBox';
  static const String searchBox = 'searchBox';

  //banners
  static Future<void> addBanners({required BannerModel banner}) async {
    final box = Hive.box<BannerModel>(bannerBox);
    await box.put(banner.bannerId, banner);
  }

  static Future<List<BannerModel>> getBannerModel() async {
    final box = Hive.box<BannerModel>(bannerBox);
    return box.values.toList();
  }

  //categories
  static Future<void> addCategories({required CategoryModel category}) async {
    final box = Hive.box<CategoryModel>(categoryBox);
    await box.put(category.id, category);
  }

  static Future<List<CategoryModel>> getCategoryModel() async {
    final box = Hive.box<CategoryModel>(categoryBox);
    return box.values.toList();
  }

  //search field
  static Future<void> addSearchField({required SearchFieldModel search}) async {
    final box = Hive.box<SearchFieldModel>(searchBox);
    await box.put(search.searchField, search);
  }
}
