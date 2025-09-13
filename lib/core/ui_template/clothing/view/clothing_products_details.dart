import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_color.dart';
import 'package:sadhana_cart/core/common model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20repo/cart/cart_notifier.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/core/skeletonizer/rating_tile_loader.dart';
import 'package:sadhana_cart/core/ui_template/clothing/widget/clothing%20details/rating_tile.dart';
import 'package:sadhana_cart/core/ui_template/common%20widgets/product_price_rating.dart';
import 'package:sadhana_cart/core/widgets/custom_carousel_slider.dart';
import 'package:sadhana_cart/core/widgets/custom_divider.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/core/widgets/custom_rating_widget.dart';
import 'package:sadhana_cart/core/widgets/custom_text_button.dart';
import 'package:sadhana_cart/core/widgets/custom_tile_dropdown.dart';
import 'package:sadhana_cart/core/widgets/snack_bar.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/view/payment_main_page.dart';
import 'package:sadhana_cart/features/profile/view%20model/user_notifier.dart';
import 'package:sadhana_cart/features/rating/view%20model/rating_notifier.dart';

class ClothingProductsDetails extends StatelessWidget {
  final ProductModel product;

  const ClothingProductsDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  final cartItems = ref.watch(cartProvider);
                  final cartNotifier = ref.read(cartProvider.notifier);
                  final bool isAlreadyInCart = cartItems.any(
                    (c) => c.productId == product.productId,
                  );

                  final selectedSize = ref.watch(clothingSizeProvider);
                  final selected =
                      product.sizeVariants?[selectedSize].size ?? "L";
                  return CustomElevatedButton(
                    child: Text(
                      isAlreadyInCart ? "Remove" : "Add to Cart",
                      style: customElevatedButtonTextStyle,
                    ),
                    onPressed: () async {
                      if (!isAlreadyInCart) {
                        await cartNotifier.addToCart(
                          product: product,
                          size: selected,
                        );

                        if (context.mounted) {
                          showCustomSnackbar(
                            context: context,
                            message: "Added to cart",
                            type: ToastType.success,
                          );
                        }
                      } else {
                        final cartItem = cartItems.firstWhere(
                          (c) => c.productId == product.productId,
                        );

                        await cartNotifier.removeFromCart(cart: cartItem);

                        if (context.mounted) {
                          showCustomSnackbar(
                            context: context,
                            message: "Removed from cart",
                            type: ToastType.success,
                          );
                        }
                      }
                    },
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomElevatedButton(
                child: const Text(
                  "Buy now",
                  style: customElevatedButtonTextStyle,
                ),
                onPressed: () {
                  log(product.toString());
                  navigateTo(
                    context: context,
                    screen: PaymentMainPage(product: product),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCarouselSlider(product: product),
            SizedBox(
              width: size.width,
              child: Column(children: [ProductPriceRating(product: product)]),
            ),

            const CustomDivider(),
            const SizedBox(height: 20),

            /// Sizes
            Consumer(
              builder: (context, ref, child) {
                final selectedSizeIndex = ref.watch(clothingSizeProvider);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Size:",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: List.generate(
                            product.sizeVariants?.length ?? 0,
                            (index) {
                              final sizeItem = product.sizeVariants?[index];
                              final isSelected = index == selectedSizeIndex;

                              final bool sizeHaveMoreContent =
                                  sizeItem!.size
                                      .allMatches(sizeItem.size)
                                      .length >
                                  4;

                              return GestureDetector(
                                onTap: () {
                                  ref
                                          .read(clothingSizeProvider.notifier)
                                          .state =
                                      index;
                                  log("prodct sku ${product.productId}");
                                },
                                child: Container(
                                  height: sizeHaveMoreContent ? 40 : 40,
                                  width: sizeHaveMoreContent ? 120 : 60,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColor.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColor.primaryColor
                                          : Colors.grey.shade300,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade200,
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    sizeItem.size,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const CustomDivider(),
            CustomTileDropdown(
              title: "Description",
              value: Text(product.description!),
            ),
            const SizedBox(height: 20),

            Consumer(
              builder: (context, ref, child) {
                final userName = ref.read(
                  userProvider.select((value) => value?.name ?? ""),
                );
                final ratingAsync = ref.watch(
                  specificProductrating(product.productId!),
                );

                return ratingAsync.when(
                  loading: () {
                    return const RatingTileLoader();
                  },
                  error: (error, stack) {
                    return Center(child: Text("Error: ${error.toString()}"));
                  },
                  data: (ratingList) {
                    if (ratingList.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "0 Ratings",
                              style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CustomTextButton(
                              text: "Write a Review",
                              onPressed: () {
                                showRatingDialog(
                                  context: context,
                                  productId: product.productId!,
                                  userName: userName,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: ratingList.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final rating = ratingList[index];
                        return RatingTile(
                          imageUrl: rating.image.isEmpty
                              ? AppImages.noProfile
                              : rating.image,
                          name: rating.userName,
                          rating: rating.rating,
                          review: rating.comment,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
