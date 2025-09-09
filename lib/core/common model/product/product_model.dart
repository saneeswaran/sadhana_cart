import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:sadhana_cart/core/common%20model/product/size_variant.dart';

part 'product_model.g.dart';

//please don't think about why this product model have so many things
//because client not willing to hire people to make changes in excel sheet
//also baapstore are not willing to create form based on our database structure
//i don't have choice now.. if any good developer see this this if you can optimize the model please do
//also explain about data structure to client... there some unused values are storing in the database
//i don't have choice now... sometime the stock count not showing in the product list
//when they upload the product with bulk upload option... that thing is waste until they strictly follow the data structure
//please explain and optimize the data structure to client
//i don't have choice now

@HiveType(typeId: 4)
class ProductModel extends HiveObject {
  @HiveField(0)
  String productId;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  String category;

  @HiveField(4)
  String subcategory;

  @HiveField(5)
  String baseSku; // Base SKU without size/color variants

  @HiveField(6)
  String brand;

  @HiveField(7)
  double price;

  @HiveField(8)
  double offerPrice;

  @HiveField(9)
  int get totalStock =>
      sizeVariants.fold(0, (int sum, variant) => sum + variant.stock);

  @HiveField(10)
  double rating;

  @HiveField(11)
  Timestamp timestamp;

  @HiveField(12)
  List<String> images;

  @HiveField(13)
  String? sellerId;

  @HiveField(14)
  bool cashOnDelivery;

  // Size variants for inventory management
  @HiveField(15)
  List<SizeVariant> sizeVariants;

  // Clothing attributes
  @HiveField(16)
  List<String>? colorOptions;

  @HiveField(17)
  String? material;

  @HiveField(18)
  String? fit;

  @HiveField(19)
  String? pattern;

  @HiveField(20)
  String? sleeveType;

  @HiveField(21)
  String? careInstruction;

  @HiveField(22)
  List<String>? sizeOptions;

  // Footwear attributes
  @HiveField(23)
  String? footwearMaterial;

  @HiveField(24)
  String? footwearType;

  @HiveField(25)
  String? gender;

  // Mobile attributes
  @HiveField(26)
  String? model;

  @HiveField(27)
  String? mobileColor;

  @HiveField(28)
  String? ram;

  @HiveField(29)
  String? storage;

  @HiveField(30)
  String? battery;

  @HiveField(31)
  String? camera;

  @HiveField(32)
  String? processor;

  @HiveField(33)
  String? display;

  @HiveField(34)
  String? os;

  @HiveField(35)
  String? connectivity;

  @HiveField(36)
  String? warranty;

  // Laptop attributes
  @HiveField(37)
  String? graphics;

  @HiveField(38)
  String? screenSize;

  @HiveField(39)
  String? operatingSystem;

  @HiveField(40)
  String? port;

  @HiveField(41)
  String? weight;

  // Electronics attributes
  @HiveField(42)
  String? resolution;

  @HiveField(43)
  String? displayType;

  @HiveField(44)
  String? smartFeatures;

  @HiveField(45)
  String? energyRating;

  @HiveField(46)
  String? powerConsumption;

  // Furniture attributes
  @HiveField(47)
  String? dimension;

  @HiveField(48)
  String? weightCapacity;

  @HiveField(49)
  String? assembly;

  @HiveField(50)
  String? style;

  @HiveField(51)
  String? roomType;

  // Grocery attributes
  @HiveField(52)
  String? weightVolume;

  @HiveField(53)
  String? quantity;

  @HiveField(54)
  String? organic;

  @HiveField(55)
  String? expiryDate;

  @HiveField(56)
  String? storageInstruction;

  @HiveField(57)
  String? dietaryPreference;

  // Beauty attributes
  @HiveField(58)
  String? shadeColor;

  @HiveField(59)
  String? beautyType;

  @HiveField(60)
  String? ingredients;

  @HiveField(61)
  String? skinHairType;

  @HiveField(62)
  String? beautyWeightVolume;

  @HiveField(63)
  String? beautyExpiryDate;

  @HiveField(64)
  String? dermatologicallyTested;

  // Jewellery attributes
  @HiveField(65)
  String? jewelleryMaterial;

  @HiveField(66)
  String? purity;

  @HiveField(67)
  String? jewelleryWeight;

  @HiveField(68)
  String? jewelleryColor;

  @HiveField(69)
  String? jewellerySize;

  @HiveField(70)
  String? gemstone;

  @HiveField(71)
  String? certification;

  @HiveField(72)
  String? occasion;

  // Book attributes
  @HiveField(73)
  String? title;

  @HiveField(74)
  String? author;

  @HiveField(75)
  String? publisher;

  @HiveField(76)
  String? edition;

  @HiveField(77)
  String? language;

  @HiveField(78)
  String? isbn;

  @HiveField(79)
  String? pages;

  @HiveField(80)
  String? binding;

  @HiveField(81)
  String? genre;

  ProductModel({
    required this.productId,
    required this.name,
    required this.description,
    required this.category,
    required this.subcategory,
    required this.baseSku,
    required this.brand,
    required this.price,
    required this.offerPrice,
    required this.rating,
    required this.timestamp,
    required this.images,
    this.sellerId,
    required this.cashOnDelivery,
    required this.sizeVariants,
    this.colorOptions,
    this.material,
    this.fit,
    this.pattern,
    this.sleeveType,
    this.careInstruction,
    this.sizeOptions,
    this.footwearMaterial,
    this.footwearType,
    this.gender,
    this.model,
    this.mobileColor,
    this.ram,
    this.storage,
    this.battery,
    this.camera,
    this.processor,
    this.display,
    this.os,
    this.connectivity,
    this.warranty,
    this.graphics,
    this.screenSize,
    this.operatingSystem,
    this.port,
    this.weight,
    this.resolution,
    this.displayType,
    this.smartFeatures,
    this.energyRating,
    this.powerConsumption,
    this.dimension,
    this.weightCapacity,
    this.assembly,
    this.style,
    this.roomType,
    this.weightVolume,
    this.quantity,
    this.organic,
    this.expiryDate,
    this.storageInstruction,
    this.dietaryPreference,
    this.shadeColor,
    this.beautyType,
    this.ingredients,
    this.skinHairType,
    this.beautyWeightVolume,
    this.beautyExpiryDate,
    this.dermatologicallyTested,
    this.jewelleryMaterial,
    this.purity,
    this.jewelleryWeight,
    this.jewelleryColor,
    this.jewellerySize,
    this.gemstone,
    this.certification,
    this.occasion,
    this.title,
    this.author,
    this.publisher,
    this.edition,
    this.language,
    this.isbn,
    this.pages,
    this.binding,
    this.genre,
  });

  // Helper method to get all attributes as a map for easy Excel import/export
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'category': category,
      'subcategory': subcategory,
      'baseSku': baseSku,
      'brand': brand,
      'price': price,
      'offerPrice': offerPrice,
      'rating': rating,
      'timestamp': timestamp,
      'images': images,
      'sellerId': sellerId,
      'cashOnDelivery': cashOnDelivery,
      'sizeVariants': sizeVariants.map((v) => v.toMap()).toList(),
      'colorOptions': colorOptions,
      'material': material,
      'fit': fit,
      'pattern': pattern,
      'sleeveType': sleeveType,
      'careInstruction': careInstruction,
      'sizeOptions': sizeOptions,
      'footwearMaterial': footwearMaterial,
      'footwearType': footwearType,
      'gender': gender,
      'model': model,
      'mobileColor': mobileColor,
      'ram': ram,
      'storage': storage,
      'battery': battery,
      'camera': camera,
      'processor': processor,
      'display': display,
      'os': os,
      'connectivity': connectivity,
      'warranty': warranty,
      'graphics': graphics,
      'screenSize': screenSize,
      'operatingSystem': operatingSystem,
      'port': port,
      'weight': weight,
      'resolution': resolution,
      'displayType': displayType,
      'smartFeatures': smartFeatures,
      'energyRating': energyRating,
      'powerConsumption': powerConsumption,
      'dimension': dimension,
      'weightCapacity': weightCapacity,
      'assembly': assembly,
      'style': style,
      'roomType': roomType,
      'weightVolume': weightVolume,
      'quantity': quantity,
      'organic': organic,
      'expiryDate': expiryDate,
      'storageInstruction': storageInstruction,
      'dietaryPreference': dietaryPreference,
      'shadeColor': shadeColor,
      'beautyType': beautyType,
      'ingredients': ingredients,
      'skinHairType': skinHairType,
      'beautyWeightVolume': beautyWeightVolume,
      'beautyExpiryDate': beautyExpiryDate,
      'dermatologicallyTested': dermatologicallyTested,
      'jewelleryMaterial': jewelleryMaterial,
      'purity': purity,
      'jewelleryWeight': jewelleryWeight,
      'jewelleryColor': jewelleryColor,
      'jewellerySize': jewellerySize,
      'gemstone': gemstone,
      'certification': certification,
      'occasion': occasion,
      'title': title,
      'author': author,
      'publisher': publisher,
      'edition': edition,
      'language': language,
      'isbn': isbn,
      'pages': pages,
      'binding': binding,
      'genre': genre,
    };
  }

  // Create from Map
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      subcategory: map['subcategory'] ?? '',
      baseSku: map['baseSku'] ?? '',
      brand: map['brand'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      offerPrice: (map['offerPrice'] ?? 0).toDouble(),
      rating: (map['rating'] ?? 0).toDouble(),
      timestamp: map['timestamp'] ?? Timestamp.now(),
      images: List<String>.from(map['images'] ?? []),
      sellerId: map['sellerId'],
      cashOnDelivery: map['cashOnDelivery'] ?? false,
      sizeVariants:
          (map['sizeVariants'] as List<dynamic>?)
              ?.map((v) => SizeVariant.fromMap(Map<String, dynamic>.from(v)))
              .toList() ??
          [],
      colorOptions: List<String>.from(map['colorOptions'] ?? []),
      material: map['material'],
      fit: map['fit'],
      pattern: map['pattern'],
      sleeveType: map['sleeveType'],
      careInstruction: map['careInstruction'],
      sizeOptions: List<String>.from(map['sizeOptions'] ?? []),
      footwearMaterial: map['footwearMaterial'],
      footwearType: map['footwearType'],
      gender: map['gender'],
      model: map['model'],
      mobileColor: map['mobileColor'],
      ram: map['ram'],
      storage: map['storage'],
      battery: map['battery'],
      camera: map['camera'],
      processor: map['processor'],
      display: map['display'],
      os: map['os'],
      connectivity: map['connectivity'],
      warranty: map['warranty'],
      graphics: map['graphics'],
      screenSize: map['screenSize'],
      operatingSystem: map['operatingSystem'],
      port: map['port'],
      weight: map['weight'],
      resolution: map['resolution'],
      displayType: map['displayType'],
      smartFeatures: map['smartFeatures'],
      energyRating: map['energyRating'],
      powerConsumption: map['powerConsumption'],
      dimension: map['dimension'],
      weightCapacity: map['weightCapacity'],
      assembly: map['assembly'],
      style: map['style'],
      roomType: map['roomType'],
      weightVolume: map['weightVolume'],
      quantity: map['quantity'],
      organic: map['organic'],
      expiryDate: map['expiryDate'],
      storageInstruction: map['storageInstruction'],
      dietaryPreference: map['dietaryPreference'],
      shadeColor: map['shadeColor'],
      beautyType: map['beautyType'],
      ingredients: map['ingredients'],
      skinHairType: map['skinHairType'],
      beautyWeightVolume: map['beautyWeightVolume'],
      beautyExpiryDate: map['beautyExpiryDate'],
      dermatologicallyTested: map['dermatologicallyTested'],
      jewelleryMaterial: map['jewelleryMaterial'],
      purity: map['purity'],
      jewelleryWeight: map['jewelleryWeight'],
      jewelleryColor: map['jewelleryColor'],
      jewellerySize: map['jewellerySize'],
      gemstone: map['gemstone'],
      certification: map['certification'],
      occasion: map['occasion'],
      title: map['title'],
      author: map['author'],
      publisher: map['publisher'],
      edition: map['edition'],
      language: map['language'],
      isbn: map['isbn'],
      pages: map['pages'],
      binding: map['binding'],
      genre: map['genre'],
    );
  }
}
