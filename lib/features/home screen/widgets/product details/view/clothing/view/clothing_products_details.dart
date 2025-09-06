import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';
import 'package:sadhana_cart/features/home%20screen/widgets/product%20details/view/clothing/widget/product_detail_image_container.dart';

class ClothingProductsDetails extends StatelessWidget {
  final ProductModel product;
  const ClothingProductsDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [ProductDetailImageContainer(images: product.images)],
      ),
    );
  }
}
