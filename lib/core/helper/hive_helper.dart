import 'package:hive/hive.dart';
import 'package:sadhana_cart/core/common%20model/banner/banner_model.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_model.dart';
import 'package:sadhana_cart/core/common%20model/category/category_model.dart';
import 'package:sadhana_cart/core/common%20model/favorite/favorite_model.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20model/search%20field/search_field_model.dart';
import 'package:sadhana_cart/core/common%20model/subcategory/subcategory_model.dart';

class HiveHelper {
  static const String bannerBox = 'bannerBox';
  static const String categoryBox = 'categoryBox';
  static const String searchBox = 'searchBox';
  static const String subcategoryBox = 'subcategoryBox';
  static const String productBox = 'productBox';
  static const String favoriteBox = 'favoriteBox';
  static const String cartBox = 'cartBox';
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
    await box.put(product.productId, product);
  }

  static Future<List<ProductModel>> getProducts() async {
    final box = Hive.box<ProductModel>(productBox);
    return box.values.toList();
  }

  //cart

  static Future<void> addCart({required CartModel cart}) async {
    final box = Hive.box<CartModel>(cartBox);
    box.put(cart.productId, cart);
  }

  static Future<List<CartModel>> getCart() async {
    final box = Hive.box<CartModel>(cartBox);
    return box.values.toList();
  }

  static Future<void> deleteCart({required String key}) async {
    final box = Hive.box<CartModel>(cartBox);
    await box.delete(key);
  }

  //favorite
  static Future<void> addFavorites({required FavoruteModel favorite}) async {
    final box = Hive.box<FavoruteModel>(favoriteBox);
    await box.put(favorite.productId, favorite);
  }

  static Future<List<FavoruteModel>> getFavorite() async {
    final box = Hive.box<FavoruteModel>(favoriteBox);
    return box.values.toList();
  }

  static Future<void> deleteFavorite({required String key}) async {
    final box = Hive.box<FavoruteModel>(favoriteBox);
    await box.delete(key);
  }
}
