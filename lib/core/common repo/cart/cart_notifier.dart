import 'dart:developer' show log;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_model.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_with_product.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20services/cart/cart_service.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';

class CartNotifier extends StateNotifier<List<CartWithProduct>> {
  final Ref ref;
  CartNotifier(this.ref) : super([]) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final carts = await CartService.fetchCartItemsWithProducts();
    state = [...carts];
  }

  Future<void> addToCart({required ProductModel product, String? size}) async {
    ref.read(cartLoadingProvider.notifier).state = true;
    final bool success = await CartService.addToCart(size, product: product);
    if (success) {
      final carts = await CartService.fetchCartItemsWithProducts();
      state = [...carts];
      ref.read(cartLoadingProvider.notifier).state = false;
    }
  }

  Future<void> removeFromCart({required String cartId}) async {
    ref.read(cartLoadingProvider.notifier).state = true;
    if (cartId.trim().isEmpty) {
      log("removeFromCart: cartId empty, skipping");
      ref.read(cartLoadingProvider.notifier).state = false;
      return;
    }

    final bool success = await CartService.deleteCart(cartId: cartId);
    if (success) {
      final updatedCarts = await CartService.fetchCartItemsWithProducts();
      state = [...updatedCarts];
      ref.read(cartLoadingProvider.notifier).state = false;
    } else {
      state = state.where((c) => c.cart.cartId != cartId).toList();
      ref.read(cartLoadingProvider.notifier).state = false;
    }
  }

  void increaseQuantity({required CartModel cart}) {
    final index = state.indexWhere((c) => c.cart.cartId == cart.cartId);
    if (index == -1) return;

    final current = state[index];
    final maxStock = current.product.stock ?? 0;

    if (cart.quantity < maxStock) {
      final updatedCart = cart.copyWith(quantity: cart.quantity + 1);
      log(updatedCart.toString());
      final updatedItem = CartWithProduct(
        cart: updatedCart,
        product: current.product,
      );

      final updatedState = [...state];
      updatedState[index] = updatedItem;
      state = updatedState;
    }
  }

  void decreaseQuantity({required CartModel cart}) {
    final index = state.indexWhere((c) => c.cart.cartId == cart.cartId);
    if (index == -1 || cart.quantity <= 1) return;
    final current = state[index];
    final updatedCart = cart.copyWith(quantity: cart.quantity - 1);
    final updatedItem = CartWithProduct(
      cart: updatedCart,
      product: current.product,
    );

    final updatedState = [...state];
    updatedState[index] = updatedItem;
    state = updatedState;
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

final cartProvider = StateNotifierProvider<CartNotifier, List<CartWithProduct>>(
  (ref) {
    return CartNotifier(ref).._loadCart();
  },
);
