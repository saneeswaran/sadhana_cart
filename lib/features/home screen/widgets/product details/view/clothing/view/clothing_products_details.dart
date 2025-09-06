import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';

class ClothingProductsDetails extends StatelessWidget {
  final ProductModel product;
  const ClothingProductsDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with circular background
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl: product.images[0],
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Product Name and Price
              const Text(
                'Sportwear Set',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                '\$80.00',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),

              // Rating section
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < 4 ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                    size: 20,
                  );
                }),
              ),
              const SizedBox(height: 5),
              const Text(
                '(83 Reviews)',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),

              // Color Options
              const Text(
                'Color',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  colorOption(const Color(0xFFF4C2C2)), // Light pink color
                  colorOption(Colors.black), // Black color
                  colorOption(const Color(0xFFFF5C5C)), // Red color
                ],
              ),
              const SizedBox(height: 20),

              // Size Options
              const Text(
                'Size',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [sizeOption('S'), sizeOption('M'), sizeOption('L')],
              ),
              const SizedBox(height: 20),

              // Description Section
              const Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Sportswear is no longer under culture, it is no longer indie or cobbled together as it once was. Sport is fashion today. The top is oversized in fit and style, may need to size down.',
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 10),
              const Text(
                'Read more',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Color option widget
  Widget colorOption(Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: CircleAvatar(radius: 20, backgroundColor: color),
    );
  }

  // Size option widget
  Widget sizeOption(String size) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Chip(
        label: Text(size, style: const TextStyle(fontSize: 16)),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
