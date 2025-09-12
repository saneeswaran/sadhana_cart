import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20repo/cart/cart_notifier.dart';
import 'package:sadhana_cart/core/constants/constants.dart';

class CartPageMobile extends ConsumerWidget {
  final PreferredSizeWidget? appBar;
  const CartPageMobile({super.key, this.appBar});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ProductModel> cartProducts = ref.watch(cartProductListProvider);
    final cartItems = ref.watch(cartProvider).toList();
    final Size size = MediaQuery.of(context).size;

    if (cartProducts.isEmpty) {
      return const Center(child: Text("Your cart is empty"));
    }

    return Scaffold(
      appBar: appBar,
      body: ListView.builder(
        itemCount: cartProducts.length,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          final product = cartProducts[index];
          final cartModel = cartItems.firstWhere(
            (c) => c.productId == product.productId,
          );
          final variant = product.sizeVariants?.isNotEmpty == true
              ? product.sizeVariants!.first
              : null;

          return Container(
            margin: const EdgeInsets.all(10),
            height: size.height * 0.17,
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
                // Product image
                Container(
                  height: size.height * 0.17,
                  width: size.width * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(product.images!.first),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                // Product details
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
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
                        Text(
                          "${Constants.indianCurrency} ${product.offerPrice?.toStringAsFixed(2) ?? '--'}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        variant != null
                            ? Row(
                                children: [
                                  Text(
                                    "Size: ${variant.size}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    "Color: ${variant.color}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(height: 10),
                        _quantityContainer(
                          size: size,
                          quantity: cartModel.quantity,
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
    );
  }

  Widget _quantityContainer({required Size size, required int quantity}) {
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
          IconButton(
            onPressed: () {
              // handle decrement
            },
            icon: const Icon(Icons.remove, size: 18),
            color: iconColor,
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
          Text(
            quantity.toString(),
            style: const TextStyle(
              color: iconColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            onPressed: () {
              // handle increment
            },
            icon: const Icon(Icons.add, size: 18),
            color: iconColor,
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
