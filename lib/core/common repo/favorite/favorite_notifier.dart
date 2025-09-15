import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20services/favorite/favorite_service.dart';

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Set<ProductModel>>(
      (ref) => FavoriteNotifier()..initialize(),
    );

class FavoriteNotifier extends StateNotifier<Set<ProductModel>> {
  FavoriteNotifier() : super({});

  Future<void> initialize() async {
    final favorites = await FavoriteService.fetchUserFavoriteProducts();
    state = favorites;
  }

  void addToFavorite({required ProductModel product}) {
    state = {...state, product};
  }

  void removeFromFavorite({required ProductModel product}) {
    state = state.where((e) => e.productid != product.productid).toSet();
  }

  bool isFavorite(String productId) {
    return state.any((e) => e.productid == productId);
  }
}
