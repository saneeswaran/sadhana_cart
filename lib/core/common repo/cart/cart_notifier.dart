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
      state = HiveHelper.getCart();
    }
  }

  Set<ProductModel> getCartProducts() {
    final products = ref.watch(productProvider);
    final productIdsInCart = state.map((cart) => cart.productId).toSet();

    return products
        .where((product) => productIdsInCart.contains(product.productId))
        .toSet();
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

  void removeFromCart({required CartModel cart}) {
    state = state.where((e) => e.productId != cart.productId).toSet();
  }

  double getCartTotalAmount() {
    final products = ref.watch(productProvider);
    double total = 0.0;

    for (final cart in state) {
      final product = products.firstWhere((p) => p.productId == cart.productId);

      total += product.offerPrice * cart.quantity;
    }

    return total;
  }
}
