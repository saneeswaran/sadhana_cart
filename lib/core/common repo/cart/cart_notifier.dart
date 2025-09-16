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

  Future<void> removeFromCart({required CartModel cart}) async {
    final bool success = await CartService.deleteCart(cart: cart);

    if (success) {
      final updated = await CartService.fetchCart();
      state = {...updated};
    } else {
      state = state.where((e) => e.productid != cart.productid).toSet();
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
          if (c.productid == cart.productid) updatedCart else c,
      };
    }
  }

  void decreaseQuantity({required CartModel cart}) {
    if (cart.quantity > 1) {
      final updatedCart = cart.copyWith(quantity: cart.quantity - 1);
      state = {
        for (final c in state)
          if (c.productid == cart.productid) updatedCart else c,
      };
    }
  }

  double getCartTotalAmount({required List<ProductModel> products}) {
    double total = 0.0;

    for (var product in products) {
      final price = product.offerprice ?? 0.0;
      final quantity = state
          .firstWhere(
            (cart) => cart.productid == product.productid,
            orElse: () => CartModel(
              cartId: '',
              customerId: '',
              productid: product.productid ?? '',
              quantity: 0,
              size: '',
            ),
          )
          .quantity;

      total += price * quantity;
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
