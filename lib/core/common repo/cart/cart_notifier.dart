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

  Future<void> addToCart({
    required ProductModel product,
    required String size,
  }) async {
    final bool success = await CartService.addToCart(
      product: product,
      size: size,
    );

    if (success) {
      final updated = await CartService.fetchCart();
      state = {...updated};
    }
  }

  Future<void> removeFromCart({required CartModel cart}) async {
    final bool success = await CartService.deleteCart(cart: cart);

    if (success) {
      final updated = await CartService.fetchCart();
      state = {...updated};
    } else {
      state = state.where((e) => e.productId != cart.productId).toSet();
    }
  }

  Set<ProductModel> getCartProducts() {
    final products = ref.read(productProvider);
    final productIds = state.map((c) => c.productId).toSet();

    return products.where((p) => productIds.contains(p.productId)).toSet();
  }

  void increaseQuantity({required CartModel cart, required int maxStock}) {
    if (cart.quantity < maxStock) {
      final updatedCart = cart.copyWith(quantity: cart.quantity + 1);
      state = {
        for (final c in state)
          if (c.productId == cart.productId) updatedCart else c,
      };
    }
  }

  void decreaseQuantity({required CartModel cart}) {
    if (cart.quantity > 1) {
      final updatedCart = cart.copyWith(quantity: cart.quantity - 1);
      state = {
        for (final c in state)
          if (c.productId == cart.productId) updatedCart else c,
      };
    }
  }

  double getCartTotalAmount({required List<ProductModel> products}) {
    double total = 0.0;

    for (final cart in state) {
      final cartProduct = products.firstWhere(
        (product) => product.productId == cart.productId,
      );
      final product = cartProduct;
      final price = product.offerPrice ?? 0.0;
      final qty = cart.quantity;
      total += price * qty;
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
