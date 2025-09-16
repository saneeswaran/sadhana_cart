import 'dart:developer' show log;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sadhana_cart/core/common model/cart/cart_model.dart';
import 'package:sadhana_cart/core/common repo/cart/cart_notifier.dart';
import 'package:sadhana_cart/core/constants/constants.dart';
import 'package:sadhana_cart/core/skeletonizer/cart_loader.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/features/cart/widget/check_out_details.dart';

class CartPageMobile extends ConsumerWidget {
  final PreferredSizeWidget? appBar;
  const CartPageMobile({super.key, this.appBar});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final cartWithProductsAsync = ref.watch(cartItemsWithProductProvider);
    return Scaffold(
      appBar: appBar,
      body: cartWithProductsAsync.when(
        loading: () => const CartLoader(),
        error: (e, st) => Center(child: Text("Error: ${e.toString()}")),
        data: (items) {
          log("CartPageMobile: items.length = ${items.length}");
          if (items.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final cw = items[index];
                    final cartItem = cw.cart;
                    final product = cw.product;

                    final selectedSize = cartItem.size;
                    final offerPrice = product.offerprice ?? 0.0;
                    final quantity = cartItem.quantity;
                    final priceForItem = offerPrice * quantity;

                    return GestureDetector(
                      onTap: () {
                        log(cartItem.productid);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        padding: const EdgeInsets.all(10),
                        height: size.height * 0.19,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Product Image
                            Container(
                              width: size.width * 0.3,
                              height: size.height * 0.17,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade200,
                                image:
                                    (product.images != null &&
                                        product.images!.isNotEmpty)
                                    ? DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          product.images!.first,
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child:
                                  (product.images == null ||
                                      product.images!.isEmpty)
                                  ? const Center(
                                      child: Icon(
                                        Icons.image_not_supported,
                                        size: 40,
                                      ),
                                    )
                                  : null,
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${Constants.indianCurrency} ${priceForItem.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    if (selectedSize != null &&
                                        selectedSize.isNotEmpty &&
                                        selectedSize != "nan")
                                      Text(
                                        "Size: $selectedSize",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    const Spacer(),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Quantity adjuster
                                        _quantityContainer(
                                          size: size,
                                          quantity: quantity,
                                          cart: cartItem,
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            ref
                                                .read(cartProvider.notifier)
                                                .removeFromCart(
                                                  cartId: cartItem.cartId,
                                                );
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Checkout section
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CheckOutDetails(cartItems: items),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                      child: const Text(
                        "Checkout",
                        style: customElevatedButtonTextStyle,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _quantityContainer({
  required Size size,
  required int quantity,
  required CartModel cart,
}) {
  const Color iconColor = Colors.grey;

  return Consumer(
    builder: (context, ref, child) {
      return Container(
        height: size.height * 0.04,
        width: size.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: iconColor, width: 1.4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: IconButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).decreaseQuantity(cart: cart);
                },
                icon: const Icon(Icons.remove, size: 18),
                color: iconColor,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ),
            Text(
              "$quantity",
              style: const TextStyle(
                color: iconColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).increaseQuantity(cart: cart);
                },
                icon: const Icon(Icons.add, size: 18),
                color: iconColor,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      );
    },
  );
}
