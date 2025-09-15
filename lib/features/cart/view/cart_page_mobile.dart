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
              ListView.builder(
                itemCount: cartItems.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final cart = cartItems[index];
                  //to show the size variants
                  final cartModel = carts.firstWhere(
                    (e) => e.productid == cart.productid,
                    orElse: () => CartModel(
                      cartId: '',
                      customerId: '',
                      productid: '',
                      quantity: 0,
                      size: '',
                    ),
                  );
                  final sizes = cartModel.size;

                  //getting stock
                  final selectedVariant = cart.sizevariants?.firstWhere(
                    (e) => e.size == cartModel.size,
                    orElse: () => SizeVariant(size: '', stock: 0),
                  );
                  final maxStock = selectedVariant?.stock ?? 0;

                  //get total price by quantity
                  final specificProductPrice =
                      cartModel.quantity * cart.offerprice!;
                  return Container(
                    margin: const EdgeInsets.all(10),
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
                        Container(
                          height: size.height * 0.17,
                          width: size.width * 0.3,
                          decoration: BoxDecoration(
                            image:
                                cart.images != null && cart.images!.isNotEmpty
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
                          child: cart.images == null || cart.images!.isEmpty
                              ? const Icon(Icons.image_not_supported, size: 40)
                              : null,
                        ),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
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
                                Text(
                                  "${Constants.indianCurrency} ${specificProductPrice.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                cart.sizevariants != null
                                    ? Text(
                                        "Size: $sizes",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
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
                                        final cartNotifier = ref.read(
                                          cartProvider.notifier,
                                        );
                                        await cartNotifier.removeFromCart(
                                          cart: cartModel,
                                        );
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
              const Spacer(),
              Column(
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
            ],
          );
        },
        error: (e, s) => Center(child: Text(e.toString())),
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
