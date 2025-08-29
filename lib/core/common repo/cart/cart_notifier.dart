import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_model.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20repo/product/product_notifier.dart';
import 'package:sadhana_cart/core/common%20services/cart/cart_service.dart';
import 'package:sadhana_cart/core/helper/connection_helper.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

final cartProvider = StateNotifierProvider<CartNotifier, Set<CartModel>>(
  (ref) => CartNotifier(ref)..initialize(),
);

class CartNotifier extends StateNotifier<Set<CartModel>> {
  final Ref ref;
  CartNotifier(this.ref) : super({});

  void initialize() async {
    final bool isInternet = await ConnectionHelper.checkInternetConnection();
    if (isInternet) {
      state = await CartService.fetchCart();
    } else {
      state = await HiveHelper.getCart();
    }
  }

  Future<Set<ProductModel>> getCartProducts() async {
    final products = ref.watch(productProvider);
    for (final cart in state) {
      return products.where((e) => e.productId == cart.productId).toSet();
    }
    return {};
  }

  Future<void> addToCart({required ProductModel product}) async {
    final bool isAdded = await CartService.addToCart(product: product);

    if (isAdded) {
      final updatedCart = await CartService.fetchCart();
      state = {...updatedCart};
    } else {
      final updatedCart = await CartService.fetchCart();
      state = {...updatedCart};
    }
  }

  Future<void> removeFromCart({required CartModel cart}) async {
    final bool isDeleted = await CartService.deleteCart(cart: cart);
    if (isDeleted) {
      state = state.where((e) => e.cartId != cart.cartId).toSet();
    } else {
      state = await CartService.fetchCart();
    }
  }
}
