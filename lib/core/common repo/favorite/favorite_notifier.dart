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

final fetchCurrentuserFavoriteProductProvider =
    FutureProvider<Set<ProductModel>>((ref) async {
      return await FavoriteService.fetchUserFavoriteProducts();
    });

class FavoriteNotifier extends StateNotifier<Set<FavoriteModel>> {
  final Ref ref;
  FavoriteNotifier(this.ref) : super({});

  void initialize() async {
    final bool isInternet = await ConnectionHelper.checkInternetConnection();
    if (isInternet) {
      state = await FavoriteService.fetchFavorites();
    } else {
      state = HiveHelper.getFavorite();
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
    final products = ref.watch(productProvider);
    final favoriteProductIds = state.map((e) => e.productId).toSet();
    return products
        .where((e) => favoriteProductIds.contains((e.productId)))
        .toSet();
  }

  void removeFromFavorite({required String favProductId}) {
    state = state.where((e) => e.productId != favProductId).toSet();
  }

  bool checkAlreadyInFavorite({required String productId}) {
    return state.any((e) => e.productId == productId);
  }
}
