import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/core/common%20model/product/product_model.dart';

// Category Model
class CategoryModel {
  final String categoryId;
  final String name;
  final String image;
  final List<SubCategoryModel> subcategories;

  CategoryModel({
    required this.categoryId,
    required this.name,
    required this.image,
    required this.subcategories,
  });
}

class SubCategoryModel {
  final String subcategoryId;
  final String name;
  final List<ProductModel> products;

  SubCategoryModel({
    required this.subcategoryId,
    required this.name,
    required this.products,
  });
}

final List<CategoryModel> categories = [
  // ---------------- ELECTRONICS ----------------
  CategoryModel(
    categoryId: "C001",
    name: "Electronics",
    image: "https://www.balajimultisales.in/images/E6.png",
    subcategories: [
      SubCategoryModel(
        subcategoryId: "SC001",
        name: "Mobiles",
        products: [
          ProductModel(
            productId: "P001",
            name: "Samsung Galaxy S23 Ultra",
            description:
                "Flagship mobile with Snapdragon 8 Gen 2, 200MP camera, 5000mAh battery.",
            category: "Electronics",
            subcategory: "Mobiles",
            baseSku: "S23ULTRA",
            brand: "Samsung",
            price: 1199.99,
            offerPrice: 1099.99,
            rating: 4.9,
            timestamp: Timestamp.now(),
            images: [
              "https://m.media-amazon.com/images/I/71Sa3dqTqzL._SL1500_.jpg",
            ],
            cashOnDelivery: true,
            ram: "12GB",
            storage: "256GB",
            battery: "5000mAh",
            camera: "200MP + 12MP + 10MP",
            processor: "Snapdragon 8 Gen 2",
            display: "6.8-inch QHD+ AMOLED",
            os: "Android 13",
            connectivity: "5G, WiFi 6E, Bluetooth 5.3",
            warranty: "1 Year Manufacturer",
            sizeVariants: [],
          ),
        ],
      ),
      SubCategoryModel(
        subcategoryId: "SC002",
        name: "Laptops",
        products: [
          ProductModel(
            productId: "P002",
            name: "Apple MacBook Air M2",
            description:
                "13.6-inch Liquid Retina Display, M2 Chip, 8GB RAM, 256GB SSD.",
            category: "Electronics",
            subcategory: "Laptops",
            baseSku: "MBA-M2",
            brand: "Apple",
            price: 1299.99,
            offerPrice: 1199.99,
            rating: 4.8,
            timestamp: Timestamp.now(),
            images: [
              "https://m.media-amazon.com/images/I/71vFKBpKakL._SL1500_.jpg",
            ],
            cashOnDelivery: false,
            graphics: "Integrated 10-core GPU",
            screenSize: "13.6-inch",
            operatingSystem: "macOS Ventura",
            weight: "1.24kg",
            resolution: "2560x1664",
            port: "MagSafe, Thunderbolt 4",
            sizeVariants: [],
          ),
        ],
      ),
    ],
  ),

  // ---------------- ACCESSORIES ----------------
  CategoryModel(
    categoryId: "C002",
    name: "Accessories",
    image:
        "https://img.freepik.com/free-photo/women-s-day-still-life-with-makeup-jewelry_23-2149263158.jpg",
    subcategories: [
      SubCategoryModel(
        subcategoryId: "SC003",
        name: "Jewelry",
        products: [
          ProductModel(
            productId: "P003",
            name: "Gold Chain for Men",
            description:
                "22K pure gold chain ideal for festive and casual wear.",
            category: "Accessories",
            subcategory: "Jewelry",
            baseSku: "GOLDCHAIN22K",
            brand: "Tanishq",
            price: 599.99,
            offerPrice: 549.99,
            rating: 4.6,
            timestamp: Timestamp.now(),
            images: [
              "https://m.media-amazon.com/images/I/71hV7V0ecJL._UL1500_.jpg",
            ],
            cashOnDelivery: true,
            jewelleryMaterial: "Gold",
            purity: "22K",
            jewelleryWeight: "12g",
            jewelleryColor: "Yellow Gold",
            gender: "Men",
            certification: "BIS Hallmark",
            occasion: "Festive, Casual",
            sizeVariants: [],
          ),
          ProductModel(
            productId: "P004",
            name: "Diamond Ring for Women",
            description: "18K gold diamond ring with IGI certification.",
            category: "Accessories",
            subcategory: "Jewelry",
            baseSku: "DIARING18K",
            brand: "PC Jewellers",
            price: 899.99,
            offerPrice: 799.99,
            rating: 4.7,
            timestamp: Timestamp.now(),
            images: [
              "https://m.media-amazon.com/images/I/71t6kG47M-L._UL1500_.jpg",
            ],
            cashOnDelivery: false,
            jewelleryMaterial: "Gold + Diamond",
            purity: "18K",
            jewelleryWeight: "6g",
            jewelleryColor: "Rose Gold",
            gender: "Women",
            gemstone: "Diamond",
            certification: "IGI Certified",
            occasion: "Engagement, Wedding",
            sizeVariants: [],
          ),
        ],
      ),
    ],
  ),

  // ---------------- HOME & KITCHEN ----------------
  CategoryModel(
    categoryId: "C003",
    name: "Home & Kitchen",
    image:
        "https://blog.servicemarket.com/wp-content/uploads/2024/03/home-appliances-dubai-1.jpg",
    subcategories: [
      SubCategoryModel(
        subcategoryId: "SC004",
        name: "Appliances",
        products: [
          ProductModel(
            productId: "P005",
            name: "LG 1.5 Ton Inverter AC",
            description:
                "Energy-efficient split AC with 5-star rating and dual inverter compressor.",
            category: "Home & Kitchen",
            subcategory: "Appliances",
            baseSku: "LGAC15",
            brand: "LG",
            price: 699.99,
            offerPrice: 649.99,
            rating: 4.4,
            timestamp: Timestamp.now(),
            images: [
              "https://m.media-amazon.com/images/I/71ILwY6UScL._SL1500_.jpg",
            ],
            cashOnDelivery: true,
            smartFeatures: "WiFi Enabled, Voice Control",
            energyRating: "5 Star",
            powerConsumption: "1450W",
            warranty: "1 Year Comprehensive + 5 Years Compressor",
            sizeVariants: [],
          ),
        ],
      ),
      SubCategoryModel(
        subcategoryId: "SC005",
        name: "Furniture",
        products: [
          ProductModel(
            productId: "P006",
            name: "Sheesham Wood King Size Bed",
            description: "Solid wood bed frame with storage drawers.",
            category: "Home & Kitchen",
            subcategory: "Furniture",
            baseSku: "WOODBEDK",
            brand: "Urban Ladder",
            price: 899.00,
            offerPrice: 799.00,
            rating: 4.3,
            timestamp: Timestamp.now(),
            images: [
              "https://m.media-amazon.com/images/I/81pF9xX9VhL._SL1500_.jpg",
            ],
            cashOnDelivery: false,
            dimension: "82 x 74 x 40 inches",
            weightCapacity: "300kg",
            assembly: "DIY Assembly Required",
            style: "Modern",
            roomType: "Bedroom",
            sizeVariants: [],
          ),
        ],
      ),
    ],
  ),

  // ---------------- BOOKS ----------------
  CategoryModel(
    categoryId: "C004",
    name: "Books",
    image:
        "https://t4.ftcdn.net/jpg/02/59/13/05/360_F_259130513_dM3XdZB7cznmJo8UW29O64DV6ivuSGCw.jpg",
    subcategories: [
      SubCategoryModel(
        subcategoryId: "SC006",
        name: "Fiction",
        products: [
          ProductModel(
            productId: "P007",
            name: "Harry Potter and the Philosopher’s Stone",
            description:
                "First book in the legendary Harry Potter series by J.K. Rowling.",
            category: "Books",
            subcategory: "Fiction",
            baseSku: "HP-BOOK1",
            brand: "Bloomsbury",
            price: 19.99,
            offerPrice: 14.99,
            rating: 4.9,
            timestamp: Timestamp.now(),
            images: [
              "https://m.media-amazon.com/images/I/81YOuOGFCJL._SL1500_.jpg",
            ],
            cashOnDelivery: true,
            title: "Harry Potter and the Philosopher’s Stone",
            author: "J.K. Rowling",
            publisher: "Bloomsbury",
            edition: "First Edition",
            language: "English",
            isbn: "978-0747532699",
            pages: "352",
            binding: "Paperback",
            genre: "Fantasy",
            sizeVariants: [],
          ),
        ],
      ),
    ],
  ),
];

// Dummy data
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
  ),
];
