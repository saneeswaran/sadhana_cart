import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:sadhana_cart/core/colors/app_color.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/constants/constants.dart';

class FootWearDetails extends StatelessWidget {
  final ProductModel product;
  const FootWearDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            color: AppColor.ratingColor,
            size: 25.0,
            onRatingChanged: (value) => log(value.toString()),
          ),
          trailing: Text(
            "${Constants.indianCurrency} ${product.price}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        const Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Row(
            children: [
              Text(
                "Color :",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(child: Wrap(children: [])),
            ],
          ),
        ),
      ],
    );
  }
}
