import 'package:sadhana_cart/core/common%20model/product/product_model.dart';

class FavoriteState {
  final bool isLoading;
  final Set<ProductModel> favoriteProducts;
  final String? error;

  FavoriteState({
    this.isLoading = false,
    this.favoriteProducts = const {},
    this.error,
  });

  factory FavoriteState.initial() =>
      FavoriteState(isLoading: false, favoriteProducts: {}, error: null);
}
