import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_model.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20repo/product/product_notifier.dart';
import 'package:sadhana_cart/core/common%20services/cart/cart_service.dart';
import 'package:sadhana_cart/core/helper/connection_helper.dart';
import 'package:sadhana_cart/core/helper/hive_helper.dart';

class CartNotifier extends StateNotifier<Set<CartModel>> {
  final Ref ref;
  CartNotifier(this.ref) : super({}) {
    initialize();
  }

  Future<void> initialize() async {
    final bool isInternet = await ConnectionHelper.checkInternetConnection();
    if (isInternet) {
      final fetched = await CartService.fetchCart();
      state = {...fetched};
    } else {
      state = HiveHelper.getCart();
    }
  }

  Future<void> addToCart({required ProductModel product, String? size}) async {
    final bool success = await CartService.addToCart(product: product, size);

    if (success) {
      final updated = await CartService.fetchCart();
      state = {...updated};
    }
  }

  Future<void> removeFromCart({required String cartId}) async {
    final success = await CartService.deleteCart(cartId: cartId);

    if (success) {
      final updated = await CartService.fetchCart();
      state = {...updated};
    } else {
      state = state.where((e) => e.cartId != cartId).toSet();
    }
  }

  Set<ProductModel> getCartProducts() {
    final products = ref.read(productProvider);
    final productIds = state.map((c) => c.productid).toSet();

    return products.where((p) => productIds.contains(p.productid)).toSet();
  }

  void increaseQuantity({required CartModel cart, required int maxStock}) {
    if (cart.quantity < maxStock) {
      final updatedCart = cart.copyWith(quantity: cart.quantity + 1);
      state = {
        for (final c in state)
          if (c.cartId == cart.cartId) updatedCart else c,
      };
    }
  }

  void decreaseQuantity({required CartModel cart}) {
    if (cart.quantity > 1) {
      final updatedCart = cart.copyWith(quantity: cart.quantity - 1);
      state = {
        for (final c in state)
          if (c.cartId == cart.cartId) updatedCart else c,
      };
    }
  }

  double getCartTotalAmount({required List<ProductModel> products}) {
    double total = 0.0;

    for (final product in products) {
      final price = product.offerprice ?? 0.0;

      final matchingCarts = state.where(
        (cart) => cart.productid == product.productid,
      );

      final subtotal = matchingCarts.fold<double>(
        0.0,
        (sum, item) => sum + (item.quantity * price),
      );

      total += subtotal;
    }

    return total;
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, Set<CartModel>>((ref) {
  return CartNotifier(ref)..initialize();
});

final getCurrentUserCartProducts = StreamProvider<List<ProductModel>>(
  (ref) => CartService.getCurrentUserCartProducts(),
);
