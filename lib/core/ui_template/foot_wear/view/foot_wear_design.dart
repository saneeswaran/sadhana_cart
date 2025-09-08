import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/core/ui_template/foot_wear/widgets/foot_wear_carousel.dart';
import 'package:sadhana_cart/core/ui_template/foot_wear/widgets/foot_wear_details.dart';

class FootWearDesign extends StatelessWidget {
  final ProductModel product;
  const FootWearDesign({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            FootWearCarousel(product: product),
            FootWearDetails(product: product),
          ],
        ),
      ),
    );
  }
}
