import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/cart/cart_model.dart';
import 'package:sadhana_cart/core/common%20model/product/size_variant.dart';
import 'package:sadhana_cart/core/common%20repo/cart/cart_notifier.dart';
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
    final cartAsync = ref.watch(getCurrentUserCartProducts);
    final carts = ref.watch(cartProvider);

    return Scaffold(
      appBar: appBar,
      body: cartAsync.when(
        data: (cartItems) {
          if (cartItems.isEmpty) {
            return const Center(child: Text("Your cart is empty"));
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final cart = cartItems[index];

                    final firstSizeVariant =
                        (cart.sizevariants != null &&
                            cart.sizevariants!.isNotEmpty)
                        ? cart.sizevariants!.first
                        : null;

                    // Find the corresponding CartModel from state
                    CartModel? cartModel;
                    try {
                      cartModel = carts.firstWhere(
                        (e) =>
                            e.productid == cart.productid &&
                            (e.size?.toLowerCase() ?? '') ==
                                (firstSizeVariant?.size.toLowerCase() ?? ''),
                      );
                    } catch (_) {
                      cartModel = null;
                    }

                    // If cartModel is not found, skip rendering this item
                    if (cartModel == null || cartModel.cartId.isEmpty) {
                      log(
                        "Skipping item: no cartModel found for ${cart.productid}",
                      );
                      return const SizedBox.shrink();
                    }

                    final sizes = cartModel.size;
                    final selectedVariant = cart.sizevariants?.firstWhere(
                      (e) => e.size == cartModel!.size,
                      orElse: () => SizeVariant(size: '', stock: 0),
                    );
                    final maxStock = selectedVariant?.stock ?? 0;
                    final offerPrice = cart.offerprice ?? 0.0;
                    final specificProductPrice =
                        cartModel.quantity * offerPrice;

                    return Container(
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
                            height: size.height * 0.17,
                            width: size.width * 0.3,
                            decoration: BoxDecoration(
                              image:
                                  (cart.images != null &&
                                      cart.images!.isNotEmpty)
                                  ? DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        cart.images!.first,
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey.shade200,
                            ),
                            child: (cart.images == null || cart.images!.isEmpty)
                                ? const Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 40,
                                    ),
                                  )
                                : null,
                          ),

                          // Product Info
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cart.name ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${Constants.indianCurrency} ${specificProductPrice.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  if (sizes?.isNotEmpty ?? false)
                                    Text(
                                      "Size: $sizes",
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
                                      _quantityContainer(
                                        size: size,
                                        quantity: cartModel.quantity,
                                        maxStock: maxStock,
                                        cart: cartModel,
                                        ref: ref,
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          log(
                                            "Pressed delete button for cartId: ${cartModel!.cartId}",
                                          );
                                          if (cartModel.cartId.isNotEmpty) {
                                            await ref
                                                .read(cartProvider.notifier)
                                                .removeFromCart(
                                                  cartId: cartModel.cartId,
                                                );
                                          } else {
                                            log(
                                              "Cannot delete: cartId is empty.",
                                            );
                                          }
                                        },
                                        icon: const Icon(Icons.delete),
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Checkout
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CheckOutDetails(cartItems),
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
        error: (e, s) => Center(child: Text("Error: ${e.toString()}")),
        loading: () => const CartLoader(),
      ),
    );
  }

  Widget _quantityContainer({
    required Size size,
    required int quantity,
    required CartModel cart,
    required WidgetRef ref,
    required int maxStock,
  }) {
    const Color iconColor = Colors.grey;

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
                ref
                    .read(cartProvider.notifier)
                    .increaseQuantity(maxStock: maxStock, cart: cart);
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
  }
}
