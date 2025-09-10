import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';

class CategoryListPage extends StatelessWidget {
  final String title;
  final List<ProductModel> products;

  const CategoryListPage({
    super.key,
    required this.title,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: products.isEmpty
          ? const Center(child: Text("No products found"))
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: Image.network(product.images.first, width: 50),
                  title: Text(product.name),
                  subtitle: Text("₹ ${product.price}"),
                  onTap: () {
                    // Navigate to product details
                  },
                );
              },
            ),
    );
  }
}
