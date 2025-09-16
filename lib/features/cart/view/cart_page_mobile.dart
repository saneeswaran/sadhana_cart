import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common repo/cart/cart_notifier.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/features/cart/widget/cart_tile.dart';
import 'package:sadhana_cart/features/cart/widget/check_out_details.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/view/payment_main_for_list_of_product.dart';

class CartPageMobile extends ConsumerWidget {
  final PreferredSizeWidget? appBar;
  const CartPageMobile({super.key, this.appBar});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    if (cart.isEmpty) {
      return const Center(child: Text("Your cart is empty"));
    }
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final cw = cart[index];
                final cartItem = cw.cart;
                final product = cw.product;

                final selectedSize = cartItem.size;
                final offerPrice = product.offerprice ?? 0.0;
                final quantity = cartItem.quantity;
                final priceForItem = offerPrice * quantity;

                return CartTile(
                  product: product,
                  cart: cartItem,
                  priceForItem: priceForItem,
                  selectedSize: selectedSize,
                );
              },
            ),
          ),

          // Checkout section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CheckOutDetails(cartItems: cart),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  child: const Text(
                    "Checkout",
                    style: customElevatedButtonTextStyle,
                  ),
                  onPressed: () {
                    final notifier = ref.watch(cartProvider.notifier);
                    final model = ref.watch(cartProvider);
                    final product = cart.map((e) => e.product).toList();
                    final carts = model.map((e) => e.cart).toList();
                    final totalAmount = notifier.getCartTotalAmount();
                    navigateTo(
                      context: context,
                      screen: PaymentMainForListOfProduct(
                        products: product,
                        totalAmount: totalAmount,
                        cart: carts,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
