import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/ui_template/common%20widgets/product_price_rating.dart';
import 'package:sadhana_cart/core/widgets/custom_carousel_slider.dart';
import 'package:sadhana_cart/core/widgets/custom_tile_dropdown.dart';

class AccessoriesScreen extends StatefulWidget {
  final ProductModel product;
  const AccessoriesScreen({super.key, required this.product});

  @override
  State<AccessoriesScreen> createState() => _AccessoriesScreenState();
}

class _AccessoriesScreenState extends State<AccessoriesScreen> {
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCarouselSlider(product: widget.product),
            ProductPriceRating(product: widget.product),
            CustomTileDropdown(
              title: "Description",
              value: Text(widget.product.description!),
            ),
          ],
        ),
      ),
    );
  }
}
