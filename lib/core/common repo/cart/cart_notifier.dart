import 'dart:developer' show log;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_model.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_with_product.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20services/cart/cart_service.dart';

class CartNotifier extends StateNotifier<Set<CartWithProduct>> {
  final Ref ref;
  CartNotifier(this.ref) : super({}) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final carts = await CartService.fetchCartItemsWithProducts();
    state = {...carts};
  }

  Future<void> addToCart({required ProductModel product, String? size}) async {
    final bool success = await CartService.addToCart(size, product: product);
    if (success) {
      final carts = await CartService.fetchCartItemsWithProducts();
      state = {...carts};
      ref.invalidate(cartItemsWithProductProvider);
    }
  }

  Future<void> removeFromCart({required String cartId}) async {
    if (cartId.trim().isEmpty) {
      log("removeFromCart: cartId empty, skipping");
      return;
    }

    final bool success = await CartService.deleteCart(cartId: cartId);
    if (success) {
      final updatedCarts = await CartService.fetchCartItemsWithProducts();
      state = {...updatedCarts};
      ref.invalidate(cartItemsWithProductProvider);
    } else {
      state = state.where((c) => c.cart.cartId != cartId).toSet();
      ref.invalidate(cartItemsWithProductProvider);
    }
  }

  void increaseQuantity({required CartModel cart}) {
    final cartWithProduct = state.firstWhere(
      (c) => c.cart.cartId == cart.cartId,
      orElse: () => throw Exception("Cart item not found"),
    );

    final maxStock = cartWithProduct.product.stock ?? 0;

    if (cart.quantity < maxStock) {
      final updatedCart = cart.copyWith(quantity: cart.quantity + 1);

      state = {
        for (final c in state)
          if (c.cart.cartId == cart.cartId)
            CartWithProduct(cart: updatedCart, product: cartWithProduct.product)
          else
            c,
      };
    }
  }

  void decreaseQuantity({required CartModel cart}) {
    if (cart.quantity > 1) {
      final cartWithProduct = state.firstWhere(
        (c) => c.cart.cartId == cart.cartId,
        orElse: () => throw Exception("Cart item not found"),
      );

      final updatedCart = cart.copyWith(quantity: cart.quantity - 1);

      state = {
        for (final c in state)
          if (c.cart.cartId == cart.cartId)
            CartWithProduct(cart: updatedCart, product: cartWithProduct.product)
          else
            c,
      };
    }
  }

  double getCartTotalAmount() {
    double total = 0.0;

    for (final cartWithProduct in state) {
      final price = cartWithProduct.product.offerprice ?? 0.0;
      total += price * cartWithProduct.cart.quantity;
    }

    return total;
  }
}

final cartProvider = StateNotifierProvider<CartNotifier, Set<CartWithProduct>>((
  ref,
) {
  return CartNotifier(ref);
});

final cartItemsWithProductProvider = FutureProvider<List<CartWithProduct>>((
  ref,
) async {
  return await CartService.fetchCartItemsWithProducts();
});
