import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';

final List<ProductModel> productModel = [
  ProductModel(
    productId: "P001",
    name: "HP H200 Wireless Headset",
    description:
        "High-quality on-ear wireless headset with comfortable fit and clear audio.",
    category: "HeadPhone", // Updated to match CategoryConstants.headphone
    subcategory: "Audio",
    baseSku: "HP-H200",
    brand: "SoundMagic",
    price: 59.99,
    offerPrice: 49.99,
    sizeVariants: [
      // SizeVariant(variantName: "Black", stock: 50),
      // SizeVariant(variantName: "White", stock: 30),
    ],
    rating: 4.5,
    timestamp: Timestamp.now(),
    images: [
      "https://m.media-amazon.com/images/I/71Yl4L6JVML._UF1000,1000_QL80_.jpg",
    ],
    cashOnDelivery: true,
    //  reviews: [
    //   {
    //     "username": "Alice",
    //     "rating": 5,
    //     "comment": "Excellent sound quality and very comfortable!"
    //   },
    //   {
    //     "username": "Bob",
    //     "rating": 4,
    //     "comment": "Good headset but battery could be better."
    //   },
    //   {
    //     "username": "Charlie",
    //     "rating": 4,
    //     "comment": "Value for money and lightweight."
    //   },
    // ],
  ),
];
