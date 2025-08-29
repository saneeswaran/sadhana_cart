import 'package:hive/hive.dart';
import 'package:sadhana_cart/core/common%20model/banner_model.dart';
import 'package:sadhana_cart/core/common%20model/category_model.dart';
import 'package:sadhana_cart/core/common%20model/product_model.dart';
import 'package:sadhana_cart/core/common%20model/search_field_model.dart';
import 'package:sadhana_cart/core/common%20model/subcategory_model.dart';

class HiveHelper {
  static const String bannerBox = 'bannerBox';
  static const String categoryBox = 'categoryBox';
  static const String searchBox = 'searchBox';
  static const String subcategoryBox = 'subcategoryBox';
  static const String productBox = 'productBox';
  static const String localData = 'localData';

  //store local things
  Future<void> storeLocalData<E>({
    required String key,
    required E value,
  }) async {
    final box = Hive.box<E>(localData);
    await box.put(key, value);
  }

  Future<E?> getLocalData<E>({required String key}) async {
    final box = Hive.box<E>(localData);
    return box.get(key);
  }

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

  //subcategory
  static Future<void> addSubcategory({
    required SubcategoryModel subcategory,
  }) async {
    final box = Hive.box<SubcategoryModel>(subcategoryBox);
    await box.put(subcategory.id, subcategory);
  }

  static Future<List<SubcategoryModel>> getSubcategory() async {
    final box = Hive.box<SubcategoryModel>(subcategoryBox);
    return box.values.toList();
  }

  //products
  static Future<void> addProducts({required ProductModel product}) async {
    final box = Hive.box<ProductModel>(productBox);
    await box.put(product.id, product);
  }

  static Future<List<ProductModel>> getProducts() async {
    final box = Hive.box<ProductModel>(productBox);
    return box.values.toList();
  }
}
