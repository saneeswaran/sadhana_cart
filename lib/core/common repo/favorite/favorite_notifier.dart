import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/favorite/favorite_model.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20repo/product/product_notifier.dart';
import 'package:sadhana_cart/core/common%20services/favorite/favorite_service.dart';
import 'package:sadhana_cart/core/helper/connection_helper.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Set<FavoriteModel>>(
      (ref) => FavoriteNotifier(ref)..initialize(),
    );

class FavoriteNotifier extends StateNotifier<Set<FavoriteModel>> {
  final Ref ref;
  FavoriteNotifier(this.ref) : super({});

  void initialize() async {
    final bool isInternet = await ConnectionHelper.checkInternetConnection();
    if (isInternet) {
      state = await FavoriteService.fetchFavorites();
    } else {
      state = await HiveHelper.getFavorite();
    }
  }

  Future<void> addToFavorite({required ProductModel product}) async {
    final bool isAdded = await FavoriteService.addToFavorite(product: product);
    if (isAdded) {
      final updatedFavorite = await FavoriteService.fetchFavorites();
      state = {...updatedFavorite};
    } else {
      final updatedFavorite = await FavoriteService.fetchFavorites();
      state = {...updatedFavorite};
    }
  }

  Set<ProductModel> getFavoriteProducts() {
    final product = ref.watch(productProvider);
    for (final favorite in state) {
      return product.where((e) => e.productId == favorite.productId).toSet();
    }
    return {};
  }

  Future<void> removeFromFavorite({required FavoriteModel favorite}) async {
    final bool isDeleted = await FavoriteService.deleteFavorite(
      favorite: favorite,
    );
    if (isDeleted) {
      state = state.where((e) => e.favoriteId != favorite.favoriteId).toSet();
    } else {
      state = await FavoriteService.fetchFavorites();
    }
  }
}
