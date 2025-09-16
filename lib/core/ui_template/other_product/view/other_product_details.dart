import 'dart:developer' show log;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_color.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20repo/cart/cart_notifier.dart';
import 'package:sadhana_cart/core/constants/app_images.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/core/skeletonizer/rating_tile_loader.dart';
import 'package:sadhana_cart/core/ui_template/clothing/widget/clothing%20details/edit_review.dart';
import 'package:sadhana_cart/core/ui_template/clothing/widget/clothing%20details/rating_tile.dart';
import 'package:sadhana_cart/core/ui_template/common%20widgets/product_price_rating.dart';
import 'package:sadhana_cart/core/ui_template/head%20phones/widgets/product_detail_row.dart';
import 'package:sadhana_cart/core/widgets/custom_carousel_slider.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';
import 'package:sadhana_cart/core/widgets/custom_rating_widget.dart';
import 'package:sadhana_cart/core/widgets/custom_text_button.dart';
import 'package:sadhana_cart/core/widgets/custom_tile_dropdown.dart';
import 'package:sadhana_cart/core/widgets/snack_bar.dart';
import 'package:sadhana_cart/features/order%20confirm/widget/payment/view/payment_main_page.dart';
import 'package:sadhana_cart/features/rating/view%20model/rating_notifier.dart';

class OtherProductDetails extends StatelessWidget {
  final ProductModel product;
  const OtherProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> productData = product.getDetailsByCategory();
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
                    (c) => c.productid == product.productid,
                  );
                  return CustomElevatedButton(
                    child: Text(
                      isAlreadyInCart ? "Remove" : "Add to Cart",
                      style: customElevatedButtonTextStyle,
                    ),
                    onPressed: () async {
                      if (!isAlreadyInCart) {
                        await cartNotifier.addToCart(product: product);

                        if (context.mounted) {
                          showCustomSnackbar(
                            context: context,
                            message: "Added to cart",
                            type: ToastType.success,
                          );
                        }
                      } else {
                        final cartItem = cartItems.firstWhere(
                          (c) => c.productid == product.productid,
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
            ProductPriceRating(product: product),
            CustomTileDropdown(
              title: "Description",
              value: Text(product.description!),
            ),
            CustomTileDropdown(
              title: "Details",
              value: Column(
                children: productData.entries.map((entry) {
                  return ProductDetailRow(title: entry.key, value: entry.value);
                }).toList(),
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                final ratingAsync = ref.watch(
                  specificProductrating(product.productid!),
                );

                return ratingAsync.when(
                  loading: () {
                    return const RatingTileLoader();
                  },
                  error: (error, stack) {
                    return Center(child: Text("Error: ${error.toString()}"));
                  },
                  data: (ratingList) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${ratingList.length} Ratings",
                                style: const TextStyle(
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
                                    productId: product.productid!,
                                    ref: ref,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        ListView.builder(
                          itemCount: ratingList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final currentUser =
                                FirebaseAuth.instance.currentUser!.uid;
                            final rating = ratingList[index];
                            return GestureDetector(
                              onTap: () {
                                if (rating.userId == currentUser) {
                                  showEditRatingDialoge(
                                    context: context,
                                    ref: ref,
                                    productId: product.productid!,
                                    ratingId: rating.ratingId,
                                  );
                                } else {
                                  showCustomSnackbar(
                                    context: context,
                                    message:
                                        "You can't edit other user's review",
                                    type: ToastType.error,
                                  );
                                }
                              },
                              child: RatingTile(
                                imageUrl: rating.image.isEmpty
                                    ? AppImages.noProfile
                                    : rating.image,
                                name: rating.userName,
                                rating: rating.rating,
                                review: rating.comment,
                              ),
                            );
                          },
                        ),
                      ],
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
