import 'package:hive/hive.dart';

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
  String sku;

  @HiveField(6)
  String brand;

  @HiveField(7)
  double price;

  @HiveField(8)
  double offerPrice;

  @HiveField(9)
  int stock;

  @HiveField(10)
  double rating;

  @HiveField(11)
  DateTime timestamp;

  @HiveField(12)
  List<String> images;

  @HiveField(13)
  String? sellerId;

  @HiveField(14)
  String cashOnDelivery;

  // Clothing attributes
  @HiveField(15)
  String? color;

  @HiveField(16)
  String? material;

  @HiveField(17)
  String? fit;

  @HiveField(18)
  String? pattern;

  @HiveField(19)
  String? sleeveType;

  @HiveField(20)
  String? careInstruction;

  @HiveField(21)
  String? size;

  // Footwear attributes
  @HiveField(22)
  String? footwearSize;

  @HiveField(23)
  String? footwearColor;

  @HiveField(24)
  String? footwearMaterial;

  @HiveField(25)
  String? footwearType;

  @HiveField(26)
  String? gender;

  // Mobile attributes
  @HiveField(27)
  String? model;

  @HiveField(28)
  String? mobileColor;

  @HiveField(29)
  String? ram;

  @HiveField(30)
  String? storage;

  @HiveField(31)
  String? battery;

  @HiveField(32)
  String? camera;

  @HiveField(33)
  String? processor;

  @HiveField(34)
  String? display;

  @HiveField(35)
  String? os;

  @HiveField(36)
  String? connectivity;

  @HiveField(37)
  String? warranty;

  // Laptop attributes
  @HiveField(38)
  String? graphics;

  @HiveField(39)
  String? screenSize;

  @HiveField(40)
  String? operatingSystem;

  @HiveField(41)
  String? port;

  @HiveField(42)
  String? weight;

  // Electronics attributes
  @HiveField(43)
  String? resolution;

  @HiveField(44)
  String? displayType;

  @HiveField(45)
  String? smartFeatures;

  @HiveField(46)
  String? energyRating;

  @HiveField(47)
  String? powerConsumption;

  // Furniture attributes
  @HiveField(48)
  String? dimension;

  @HiveField(49)
  String? weightCapacity;

  @HiveField(50)
  String? assembly;

  @HiveField(51)
  String? style;

  @HiveField(52)
  String? roomType;

  // Grocery attributes
  @HiveField(53)
  String? weightVolume;

  @HiveField(54)
  String? quantity;

  @HiveField(55)
  String? organic;

  @HiveField(56)
  String? expiryDate;

  @HiveField(57)
  String? storageInstruction;

  @HiveField(58)
  String? dietaryPreference;

  // Beauty attributes
  @HiveField(59)
  String? shadeColor;

  @HiveField(60)
  String? beautyType;

  @HiveField(61)
  String? ingredients;

  @HiveField(62)
  String? skinHairType;

  @HiveField(63)
  String? beautyWeightVolume;

  @HiveField(64)
  String? beautyExpiryDate;

  @HiveField(65)
  String? dermatologicallyTested;

  // Jewellery attributes
  @HiveField(66)
  String? jewelleryMaterial;

  @HiveField(67)
  String? purity;

  @HiveField(68)
  String? jewelleryWeight;

  @HiveField(69)
  String? jewelleryColor;

  @HiveField(70)
  String? jewellerySize;

  @HiveField(71)
  String? gemstone;

  @HiveField(72)
  String? certification;

  @HiveField(73)
  String? occasion;

  // Book attributes
  @HiveField(74)
  String? title;

  @HiveField(75)
  String? author;

  @HiveField(76)
  String? publisher;

  @HiveField(77)
  String? edition;

  @HiveField(78)
  String? language;

  @HiveField(79)
  String? isbn;

  @HiveField(80)
  String? pages;

  @HiveField(81)
  String? binding;

  @HiveField(82)
  String? genre;

  ProductModel({
    required this.productId,
    required this.name,
    required this.description,
    required this.category,
    required this.subcategory,
    required this.sku,
    required this.brand,
    required this.price,
    required this.offerPrice,
    required this.stock,
    required this.rating,
    required this.timestamp,
    required this.images,
    this.sellerId,
    required this.cashOnDelivery,

    // Category-specific attributes with default values
    this.color,
    this.material,
    this.fit,
    this.pattern,
    this.sleeveType,
    this.careInstruction,
    this.size,
    this.footwearSize,
    this.footwearColor,
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
  Map<String, dynamic> toExcelMap() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'category': category,
      'subcategory': subcategory,
      'sku': sku,
      'brand': brand,
      'price': price,
      'offerPrice': offerPrice,
      'stock': stock,
      'rating': rating,
      'timestamp': timestamp.toIso8601String(),
      'images': images.join(';'),
      'sellerId': sellerId,
      'cashOnDelivery': cashOnDelivery,

      // Category-specific attributes
      'color': color,
      'material': material,
      'fit': fit,
      'pattern': pattern,
      'sleeveType': sleeveType,
      'careInstruction': careInstruction,
      'size': size,
      'footwearSize': footwearSize,
      'footwearColor': footwearColor,
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

  // Factory method to create a Product from Excel row data
  factory ProductModel.fromExcelMap(Map<String, dynamic> map) {
    return ProductModel(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      subcategory: map['subcategory'] ?? '',
      sku: map['sku'] ?? '',
      brand: map['brand'] ?? '',
      price: double.tryParse(map['price']?.toString() ?? '0') ?? 0,
      offerPrice: double.tryParse(map['offerPrice']?.toString() ?? '0') ?? 0,
      stock: int.tryParse(map['stock']?.toString() ?? '0') ?? 0,
      rating: double.tryParse(map['rating']?.toString() ?? '0') ?? 0,
      timestamp:
          DateTime.tryParse(map['timestamp']?.toString() ?? '') ??
          DateTime.now(),
      images: (map['images']?.toString().split(';') ?? [])
          .where((e) => e.isNotEmpty)
          .toList(),
      sellerId: map['sellerId'],
      cashOnDelivery: map['cashOnDelivery'],

      // Category-specific attributes
      color: map['color'],
      material: map['material'],
      fit: map['fit'],
      pattern: map['pattern'],
      sleeveType: map['sleeveType'],
      careInstruction: map['careInstruction'],
      size: map['size'],
      footwearSize: map['footwearSize'],
      footwearColor: map['footwearColor'],
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

  // Helper method to get category-specific attributes as a map
  Map<String, dynamic> getCategoryAttributes() {
    switch (category.toLowerCase()) {
      case 'clothing':
        return {
          'Color': color,
          'Material': material,
          'Fit': fit,
          'Pattern': pattern,
          'Sleeve Type': sleeveType,
          'Care Instruction': careInstruction,
          'Size': size,
        };
      case 'footwear':
        return {
          'Size': footwearSize,
          'Color': footwearColor,
          'Material': footwearMaterial,
          'Type': footwearType,
          'Gender': gender,
        };
      case 'mobile':
        return {
          'Model': model,
          'Color': mobileColor,
          'Ram': ram,
          'Storage': storage,
          'Battery': battery,
          'Camera': camera,
          'Processor': processor,
          'Display': display,
          'OS': os,
          'Connectivity': connectivity,
          'Warranty': warranty,
        };
      case 'laptop':
        return {
          'Model': model,
          'Graphics': graphics,
          'Ram': ram,
          'Storage': storage,
          'Battery': battery,
          'Camera': camera,
          'Processor': processor,
          'Display': display,
          'OS': os,
          'Connectivity': connectivity,
          'Warranty': warranty,
          'Screen Size': screenSize,
          'Operating System': operatingSystem,
          'Port': port,
          'Weight': weight,
        };
      case 'electronics':
        return {
          'Model': model,
          'Screen Size': screenSize,
          'Resolution': resolution,
          'Display Type': displayType,
          'Smart Features': smartFeatures,
          'Connectivity': connectivity,
          'Energy Rating': energyRating,
          'Power Consumption': powerConsumption,
          'Warranty': warranty,
        };
      case 'furniture':
        return {
          'Material': material,
          'Color': color,
          'Dimension': dimension,
          'Weight Capacity': weightCapacity,
          'Assembly': assembly,
          'Style': style,
          'Room Type': roomType,
          'Warranty': warranty,
        };
      case 'grocery':
        return {
          'Weight/Volume': weightVolume,
          'Quantity': quantity,
          'Organic/Non Organic': organic,
          'Expiry Date': expiryDate,
          'Storage Instruction': storageInstruction,
          'Dietary Preference': dietaryPreference,
        };
      case 'beauty':
        return {
          'Shade/Color': shadeColor,
          'Type': beautyType,
          'Ingredients': ingredients,
          'Skin/Hair Type': skinHairType,
          'Weight/Volume': beautyWeightVolume,
          'Expiry Date': beautyExpiryDate,
          'Dermatologically Tested': dermatologicallyTested,
        };
      case 'jewellery':
        return {
          'Material': jewelleryMaterial,
          'Purity': purity,
          'Weight': jewelleryWeight,
          'Color': jewelleryColor,
          'Size': jewellerySize,
          'Gemstone': gemstone,
          'Certification': certification,
          'Occasion': occasion,
        };
      case 'book':
        return {
          'Title': title,
          'Author': author,
          'Publisher': publisher,
          'Edition': edition,
          'Language': language,
          'ISBN': isbn,
          'Pages': pages,
          'Binding': binding,
          'Genre': genre,
        };
      default:
        return {};
    }
  }

  // Calculate discount percentage
  double get discountPercentage {
    if (price == 0) return 0;
    return ((price - offerPrice) / price) * 100;
  }

  // Check if product is in stock
  bool get isInStock => stock > 0;

  // Check if product is on sale
  bool get isOnSale => offerPrice < price;

  @override
  String toString() {
    return 'Product{productId: $productId, name: $name, category: $category, price: $price, stock: $stock}';
  }
}
