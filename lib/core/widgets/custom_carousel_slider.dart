import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

class CustomCarouselSlider extends StatelessWidget {
  final ProductModel product;
  const CustomCarouselSlider({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final controller = CarouselSliderController();

    return Stack(
      children: [
        /// Image Carousel
        Padding(
          padding: const EdgeInsets.only(top: 55),
          child: Consumer(
            builder: (context, ref, child) {
              final index = ref.watch(carouselController);
              return CarouselSlider(
                items: product.images!
                    .map(
                      (e) => GestureDetector(
                        onTap: () {
                          navigateTo(
                            context: context,
                            screen: ViewPhoto(imageUrl: product.images![index]),
                          );
                        },
                        child: Container(
                          height: size.height * 0.4,
                          width: size.width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(e, cacheKey: e),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                carouselController: controller,
                options: CarouselOptions(
                  height: size.height * 0.4,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  aspectRatio: 16 / 9,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
                  pauseAutoPlayOnTouch: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                  onPageChanged: (index, reason) {
                    ref.read(carouselController.notifier).state = index;
                  },
                ),
              );
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
                  final bool isFavorite = favSet.any(
                    (e) => e.productId == product.productId,
                  );
                  return IconButton(
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    onPressed: () async {
                      final fav = ref
                          .watch(favoriteModelProvider.notifier)
                          .getFavoriteModel(product.productId!);
                      try {
                        log("fav check $isFavorite");
                        log("favmodel check $fav");
                        if (!isFavorite) {
                          log("running on add");
                          await FavoriteService.addToFavorite(
                            product: product,
                            ref: ref,
                          );
                        } else {
                          log("running on delete");
                          await FavoriteService.deleteFavorite(
                            favoriteId: fav!.favoriteId,
                            product: product,
                            ref: ref,
                          );
                        }
                      } catch (e) {
                        log("Error adding favorite: $e");
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
          top: size.height * 0.37,
          right: size.width * 0.45,
          child: Consumer(
            builder: (context, ref, child) {
              final dot = ref.watch(carouselController);
              return DotsIndicator(
                dotsCount: product.images!.length,
                axis: Axis.horizontal,
                animationDuration: const Duration(milliseconds: 200),
                position: dot.toDouble(),
                onTap: (value) {
                  ref.read(carouselController.notifier).state = value;
                  controller.animateToPage(value);
                  log("Dot tapped: $value");
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
              );
            },
          ),
        ),
      ],
    );
  }
}
