import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';

class CustomCarouselSlider extends StatelessWidget {
  final ProductModel product;
  const CustomCarouselSlider({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        CarouselSlider(
          items: product.images
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      cacheKey: e,
                      imageUrl: e,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorWidget: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          alignment: Alignment.center,
                          child: const Icon(Icons.broken_image, size: 40),
                        );
                      },
                    ),
                  ),
                ),
              )
              .toList(),
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                icon: const Icon(Icons.favorite, color: Colors.red),
              ),
            ],
          ),
        ),
        Positioned(
          top: size.height * 0.37,
          right: size.width * 0.45,
          child: DotsIndicator(
            dotsCount: product.images.length,
            animate: true,
            axis: Axis.horizontal,
            animationDuration: const Duration(milliseconds: 200),
            position: 0,
            onTap: (value) {
              log(value.toString());
            },
          ),
        ),
      ],
    );
  }
}
