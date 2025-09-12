import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/common%20repo/cart/cart_notifier.dart';
import 'package:sadhana_cart/core/constants/constants.dart';
import 'package:sadhana_cart/core/widgets/loader.dart';

class CartItemTile extends ConsumerWidget {
  const CartItemTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartProducts = ref.watch(getCurrentUserCartProducts);
    final Size size = MediaQuery.of(context).size;
    return cartProducts.when(
      data: (cart) {
        return SizedBox(
          height: size.height * 0.5,
          width: size.width * 1,
          child: ListView.builder(
            itemCount: cart.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              final car = cart[index];
              final variant = car.sizeVariants?[index];
              //outside container
              return Container(
                margin: const EdgeInsets.all(10),
                height: size.height * 0.17,
                width: size.width * 1,
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
                //inside the container
                child: Row(
                  children: [
                    Container(
                      height: size.height * 0.17,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(car.images![0]),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    //details section
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car.name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${Constants.indianCurrency} ${car.offerPrice}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //more details
                          const SizedBox(height: 5),

                          variant!.color!.isNotEmpty && variant.size.isNotEmpty
                              ? Row(
                                  children: [
                                    Text(
                                      "Size : ${variant.color}",
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(
                                      "Color: ${variant.color}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(height: 10),
                          _quantityContainer(size: size),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
      error: (e, s) => Center(child: Text(e.toString())),
      loading: () => const Loader(),
    );
  }

  Widget _quantityContainer({required Size size}) {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.remove, size: 18),
            color: iconColor,
            constraints: const BoxConstraints(),
            padding: EdgeInsets.zero,
          ),
          const Text(
            "1",
            style: TextStyle(color: iconColor, fontWeight: FontWeight.w500),
          ),
          IconButton(
            onPressed: () {},
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
