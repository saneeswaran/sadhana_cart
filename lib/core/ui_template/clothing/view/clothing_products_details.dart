import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_color.dart';
import 'package:sadhana_cart/core/colors/app_color_enum.dart';
import 'package:sadhana_cart/core/common model/product/product_model.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/widgets/custom_carousel_slider.dart';
import 'package:sadhana_cart/core/widgets/custom_divider.dart';
import 'package:sadhana_cart/core/widgets/custom_elevated_button.dart';

class ClothingProductsDetails extends StatelessWidget {
  final ProductModel product;

  const ClothingProductsDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: CustomElevatedButton(
          child: const Text(
            "Add to Cart",
            style: customElevatedButtonTextStyle,
          ),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomCarouselSlider(product: product),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: size.width,
              child: Column(
                children: [
                  //   ProductPriceRating(product: product),
                  const Divider(color: AppColor.lightGrey, thickness: 1.2),
                  Consumer(
                    builder: (context, ref, child) {
                      final selecIndex = ref.watch(clothingColorProvider);
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Color :",
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
                                  final isSelected = index == selecIndex;
                                  final colorName =
                                      product.sizeVariants?[index].color;
                                  final color = getColorFromDatabase(
                                    colorName ?? "black",
                                  );
                                  final isWhite =
                                      color == AppColors.white.color;

                                  return GestureDetector(
                                    onTap: () {
                                      ref
                                              .read(
                                                clothingColorProvider.notifier,
                                              )
                                              .state =
                                          index;
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.transparent,
                                        border: isSelected
                                            ? Border.all(
                                                color: AppColor.primaryColor,
                                                width: 2,
                                              )
                                            : null,
                                      ),
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: color,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.shade300,
                                              blurRadius: 5,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                          border: isWhite
                                              ? Border.all(color: Colors.grey)
                                              : null,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

            const CustomDivider(),
            const SizedBox(height: 20),

            /// Sizes
            Consumer(
              builder: (context, ref, child) {
                final selectSize = ref.watch(clothingSizeProvider);

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Size :",
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
                            product.sizeOptions?.length ?? 0,
                            (index) {
                              final sizeItem = product.sizeOptions?[index];
                              final isSelected = index == selectSize;
                              return GestureDetector(
                                onTap: () {
                                  ref
                                          .read(clothingSizeProvider.notifier)
                                          .state =
                                      index;
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColor.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 5,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    sizeItem ?? "",
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
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

            /// Reviews
            // ListView.builder(
            //   itemCount: 5,
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index) {
            //     return const RatingTile(
            //       imageUrl: AppImages.noProfile,
            //       name: "Sathish",
            //       rating: 4.9,
            //       review: "This product is really good",
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
