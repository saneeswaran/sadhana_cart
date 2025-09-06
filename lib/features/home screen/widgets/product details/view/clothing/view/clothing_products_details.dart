import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:sadhana_cart/core/colors/app_colors.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/constants/constants.dart';
import 'package:sadhana_cart/core/helper/navigation_helper.dart';
import 'package:sadhana_cart/core/widgets/custom_progress_indicator.dart';
import 'package:sadhana_cart/core/widgets/custom_tile_dropdown.dart';

class ClothingProductsDetails extends StatelessWidget {
  final ProductModel product;
  const ClothingProductsDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              children: [
                CarouselSlider(
                  items: product.images
                      .map(
                        (e) => Container(
                          height: size.height * 0.4,
                          width: size.width * 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(e, cacheKey: e),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(height: size.height * 0.4),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                        ),
                        onPressed: () => navigateBack(context: context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
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
            ),

            Container(
              width: size.width * 1,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: StarRating(
                      mainAxisAlignment: MainAxisAlignment.start,
                      rating: product.rating,
                      color: AppColors.ratingColor,
                      size: 25.0,
                      onRatingChanged: (value) => log(value.toString()),
                    ),
                    trailing: Text(
                      "${Constants.indianCurrency} ${product.price}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Divider(color: AppColors.lightGrey, thickness: 1.2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: _colorTile(
                            text: "Color",
                            widget: Text(
                              product.brand,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: _colorTile(
                            text: "Size",
                            widget: Wrap(
                              children: List.generate(
                                product.attributes["Size"].length,
                                (index) {
                                  final size =
                                      product.attributes["Size"][index];
                                  return Container(
                                    height: 40,
                                    width: 40,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Center(child: Text(size)),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(color: AppColors.lightGrey, thickness: 1.2),
                  CustomTileDropdown(
                    title: "Description",
                    value: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        product.description,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  const Divider(color: AppColors.lightGrey, thickness: 1.2),

                  //review tile
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Reviews",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "4.9",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "OUT OF 5",
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 90),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              StarRating(
                                mainAxisAlignment: MainAxisAlignment.end,
                                color: AppColors.switchTileColor,
                                size: 30,
                                rating: 5,
                              ),
                              Text(
                                "84 Ratings",
                                style: TextStyle(
                                  color: Colors.grey.shade300,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const CustomProgressIndicator(ratingData: []),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _colorTile({required String text, required Widget widget}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey.shade400,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        widget,
      ],
    );
  }
}
