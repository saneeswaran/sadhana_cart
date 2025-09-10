import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sadhana_cart/core/colors/app_color.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/common%20repo/favorite/favorite_notifier.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/core/widgets/view_photo.dart';

final carouselController = StateProvider.autoDispose<int>((ref) => 0);

class CustomCarouselSlider extends ConsumerWidget {
  final ProductModel product;
  const CustomCarouselSlider({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final controller = CarouselSliderController();
    final bool isAlreadyFavorite = ref
        .read(favoriteProvider.notifier)
        .checkAlreadyInFavorite(productId: product.productId ?? "");
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 55),
          child: CarouselSlider(
            items: product.images!
                .map(
                  (e) => GestureDetector(
                    onTap: () {
                      navigateTo(
                        context: context,
                        screen: ViewPhoto(
                          imageUrl:
                              product.images![ref.watch(carouselController)],
                        ),
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
                log("Page changed: $index");
              },
            ),
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
              IconButton(
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(),
                ),
                onPressed: () {},
                icon: Icon(
                  isAlreadyFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isAlreadyFavorite ? Colors.red : Colors.white,
                ),
              ),
            ],
          ),
        ),
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
