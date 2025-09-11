import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_color.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20repo/favorite/fav_model_notifier.dart';
import 'package:sadhana_cart/core/common%20repo/favorite/favorite_notifier.dart';
import 'package:sadhana_cart/core/common%20services/favorite/favorite_service.dart';
import 'package:sadhana_cart/core/disposable/disposable.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/core/widgets/view_photo.dart';

class CustomCarouselSlider extends ConsumerWidget {
  final ProductModel product;
  const CustomCarouselSlider({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final controller = CarouselSliderController();
    final currentIndex = ref.watch(carouselController);

    return Stack(
      children: [
        /// Image Carousel
        Padding(
          padding: const EdgeInsets.only(top: 55),
          child: CarouselSlider.builder(
            itemCount: product.images?.length ?? 0,
            carouselController: controller,
            itemBuilder: (context, index, realIdx) {
              final imageUrl = product.images![index];

              return GestureDetector(
                onTap: () {
                  navigateTo(
                    context: context,
                    screen: ViewPhoto(imageUrl: imageUrl),
                  );
                },
                child: Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(imageUrl),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: size.height * 0.45,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              viewportFraction: 1,
              enableInfiniteScroll: true,
              pauseAutoPlayOnTouch: true,
              scrollPhysics: const BouncingScrollPhysics(),
              onPageChanged: (index, reason) {
                ref.read(carouselController.notifier).state = index;
              },
            ),
          ),
        ),

        /// Back & Favorite Buttons
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                ),
                onPressed: () => navigateBack(context: context),
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              ),
              Consumer(
                builder: (context, ref, child) {
                  final favSet = ref.watch(favoriteProvider);
                  final isFavorite = favSet.any(
                    (e) => e.productId == product.productId,
                  );
                  final favModel = ref.watch(favoriteModelProvider);
                  final matchedFavorite = favModel.firstWhereOrNull(
                    (e) => e.productId == product.productId,
                  );
                  final String? existsFavoriteId = matchedFavorite?.favoriteId;

                  return IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    onPressed: () async {
                      try {
                        if (!isFavorite) {
                          await FavoriteService.addToFavorite(
                            product: product,
                            ref: ref,
                          );
                        } else if (existsFavoriteId != null) {
                          await FavoriteService.deleteFavorite(
                            favoriteId: existsFavoriteId,
                            product: product,
                            ref: ref,
                          );
                        }
                      } catch (e) {
                        log("Error toggling favorite: $e");
                      }
                    },
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.black,
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        /// Dot Indicator
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: DotsIndicator(
              dotsCount: product.images?.length ?? 0,
              position: currentIndex.toDouble(),
              onTap: (index) {
                ref.read(carouselController.notifier).state = index;
                // controller.animateToPage(index);
              },
              decorator: DotsDecorator(
                size: const Size.square(8.0),
                activeSize: const Size(18.0, 8.0),
                color: Colors.grey.shade400,
                activeColor: AppColor.dartPrimaryColor,
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
