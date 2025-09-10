// ignore_for_file: public_member_api_docs, sort_constructors_first
//please don't think about why this product model have so many things
//because client not willing to hire people to make changes in excel sheet
//also baapstore are not willing to create form based on our database structure
//i don't have choice now.. if any good developer see this this if you can optimize the model please do
//also explain about data structure to client... there some unused values are storing in the database
//i don't have choice now... sometime the stock count not showing in the product list
//when they upload the product with bulk upload option... that thing is waste until they strictly follow the data structure
//please explain and optimize the data structure to client
//i don't have choice now
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sadhana_cart/core/common%20model/product/size_variant.dart';

class ProductModel {
  // Common Fields (Non-nullable)
  final String productId;
  final String name;
  final String description;
  final String category;
  final String subcategory;
  final String baseSku;
  final String brand;
  final double price;
  final double offerPrice;
  final int totalStock;
  final double rating;
  final List<String> images;
  final String sellerId;
  final bool cashOnDelivery;
  final List<SizeVariant> sizeVariants;
  final Timestamp? timestamp;
  final DateTime? date;

  // Fashion / Clothing
  final String? material;
  final String? fit;
  final String? pattern;
  final String? sleeveType;
  final String? careInstruction;
  final List<String>? sizeOptions;
  final String? hsnCode;
  final double? weight;
  final double? length;
  final double? width;
  final double? height;
  final String? fitType;
  final String? gender;
  final String? neckType;
  final String? occasion;
  final String? stitchType;
  final String? vendor;
  final String? variantSku;
  final String? closureType;
  final String? embroideryStyle;
  final String? lining;
  final String? model;
  final String? neckStyle;
  final String? padType;
  final String? pockets;
  final String? printType;
  final String? productLength;
  final String? productType;
  final String? riseStyle;
  final String? sideType;
  final String? sleeve;
  final String? sleeveStyle;
  final String? slitType;
  final String? specialFeatures;
  final String? strapType;
  final String? style;
  final bool? transparent;
  final String? type;
  final String? workType;
  final bool? blouseAvailability;
  final String? patternCoverage;
  final String? age;
  final String? ageGroup;
  final String? waistStyle;

  // Mobile
  final String? mobileColor;
  final String? ram;
  final String? storage;
  final String? battery;
  final String? camera;
  final String? processor;
  final String? display;
  final String? os;
  final String? connectivity;
  final String? warranty;
  final String? color;
  final String? designOptions;

  // Electronics
  final String? resolution;
  final String? displayType;
  final String? smartFeatures;
  final String? energyRating;
  final String? powerConsumption;
  final DateTime? expDate;
  final String? mfgDate;
  final String? highlight;
  final String? otherHighlights;

  // Jewellery
  final String? jewelleryMaterial;
  final String? purity;
  final double? jewelleryWeight;
  final String? jewelleryColor;
  final String? jewellerySize;
  final String? gemstone;
  final String? certification;

  // Book
  final String? title;
  final String? author;
  final String? publisher;
  final String? edition;
  final String? language;
  final String? isbn;
  final int? pages;
  final String? binding;
  final String? genre;

  // Home & Kitchen
  final String? frameMaterial;
  final String? mountingType;

  // Beauty
  final String? shadeColor;
  final String? beautyType;
  final List<String>? ingredients;
  final String? skinHairType;
  final String? beautyWeightVolume;
  final DateTime? beautyExpiryDate;
  final bool? dermatologicallyTested;

  // Furniture
  final String? dimension;
  final String? weightCapacity;
  final String? assembly;
  final String? roomType;

  // Grocery
  final String? weightVolume;
  final String? quantity;
  final bool? organic;
  final DateTime? expiryDate;
  final String? storageInstruction;
  final String? dietaryPreference;

  // Laptop
  final String? graphics;
  final String? screenSize;
  final String? operatingSystem;
  final String? port;

  // Footwear
  final String? footwearMaterial;
  final String? footwearType;
  final String? shoeSize;
  final String? heelHeight;
  final String? soleMaterial;
  final String? toeShape;

  ProductModel({
    // Required
    required this.productId,
    required this.name,
    required this.description,
    required this.category,
    required this.subcategory,
    required this.baseSku,
    required this.brand,
    required this.price,
    required this.offerPrice,
    required this.totalStock,
    required this.rating,
    required this.images,
    required this.sellerId,
    required this.cashOnDelivery,
    required this.sizeVariants,
    this.timestamp,
    this.date,

    // Optional
    this.material,
    this.fit,
    this.pattern,
    this.sleeveType,
    this.careInstruction,
    this.sizeOptions,
    this.hsnCode,
    this.weight,
    this.length,
    this.width,
    this.height,
    this.fitType,
    this.gender,
    this.neckType,
    this.occasion,
    this.stitchType,
    this.vendor,
    this.variantSku,
    this.closureType,
    this.embroideryStyle,
    this.lining,
    this.model,
    this.neckStyle,
    this.padType,
    this.pockets,
    this.printType,
    this.productLength,
    this.productType,
    this.riseStyle,
    this.sideType,
    this.sleeve,
    this.sleeveStyle,
    this.slitType,
    this.specialFeatures,
    this.strapType,
    this.style,
    this.transparent,
    this.type,
    this.workType,
    this.blouseAvailability,
    this.patternCoverage,
    this.age,
    this.ageGroup,
    this.waistStyle,
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
    this.color,
    this.designOptions,
    this.resolution,
    this.displayType,
    this.smartFeatures,
    this.energyRating,
    this.powerConsumption,
    this.expDate,
    this.mfgDate,
    this.highlight,
    this.otherHighlights,
    this.jewelleryMaterial,
    this.purity,
    this.jewelleryWeight,
    this.jewelleryColor,
    this.jewellerySize,
    this.gemstone,
    this.certification,
    this.title,
    this.author,
    this.publisher,
    this.edition,
    this.language,
    this.isbn,
    this.pages,
    this.binding,
    this.genre,
    this.frameMaterial,
    this.mountingType,
    this.shadeColor,
    this.beautyType,
    this.ingredients,
    this.skinHairType,
    this.beautyWeightVolume,
    this.beautyExpiryDate,
    this.dermatologicallyTested,
    this.dimension,
    this.weightCapacity,
    this.assembly,
    this.roomType,
    this.weightVolume,
    this.quantity,
    this.organic,
    this.expiryDate,
    this.storageInstruction,
    this.dietaryPreference,
    this.graphics,
    this.screenSize,
    this.operatingSystem,
    this.port,
    this.footwearMaterial,
    this.footwearType,
    this.shoeSize,
    this.heelHeight,
    this.soleMaterial,
    this.toeShape,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'date': date,
      'name': name,
      'description': description,
      'category': category,
      'subcategory': subcategory,
      'baseSku': baseSku,
      'brand': brand,
      'price': price,
      'offerPrice': offerPrice,
      'totalStock': totalStock,
      'rating': rating,
      'images': images,
      'sellerId': sellerId,
      'cashOnDelivery': cashOnDelivery,
      'sizeVariants': sizeVariants,
      'timestamp': timestamp,
      'material': material,
      'fit': fit,
      'pattern': pattern,
      'sleeveType': sleeveType,
      'careInstruction': careInstruction,
      'sizeOptions': sizeOptions,
      'hsnCode': hsnCode,
      'weight': weight,
      'length': length,
      'width': width,
      'height': height,
      'fitType': fitType,
      'gender': gender,
      'neckType': neckType,
      'occasion': occasion,
      'stitchType': stitchType,
      'vendor': vendor,
      'variantSku': variantSku,
      'closureType': closureType,
      'embroideryStyle': embroideryStyle,
      'lining': lining,
      'model': model,
      'neckStyle': neckStyle,
      'padType': padType,
      'pockets': pockets,
      'printType': printType,
      'productLength': productLength,
      'productType': productType,
      'riseStyle': riseStyle,
      'sideType': sideType,
      'sleeve': sleeve,
      'sleeveStyle': sleeveStyle,
      'slitType': slitType,
      'specialFeatures': specialFeatures,
      'strapType': strapType,
      'style': style,
      'transparent': transparent,
      'type': type,
      'workType': workType,
      'blouseAvailability': blouseAvailability,
      'patternCoverage': patternCoverage,
      'age': age,
      'ageGroup': ageGroup,
      'waistStyle': waistStyle,
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
      'color': color,
      'designOptions': designOptions,
      'resolution': resolution,
      'displayType': displayType,
      'smartFeatures': smartFeatures,
      'energyRating': energyRating,
      'powerConsumption': powerConsumption,
      'expDate': expDate?.millisecondsSinceEpoch,
      'mfgDate': mfgDate,
      'highlight': highlight,
      'otherHighlights': otherHighlights,
      'jewelleryMaterial': jewelleryMaterial,
      'purity': purity,
      'jewelleryWeight': jewelleryWeight,
      'jewelleryColor': jewelleryColor,
      'jewellerySize': jewellerySize,
      'gemstone': gemstone,
      'certification': certification,
      'title': title,
      'author': author,
      'publisher': publisher,
      'edition': edition,
      'language': language,
      'isbn': isbn,
      'pages': pages,
      'binding': binding,
      'genre': genre,
      'frameMaterial': frameMaterial,
      'mountingType': mountingType,
      'shadeColor': shadeColor,
      'beautyType': beautyType,
      'ingredients': ingredients,
      'skinHairType': skinHairType,
      'beautyWeightVolume': beautyWeightVolume,
      'beautyExpiryDate': beautyExpiryDate?.millisecondsSinceEpoch,
      'dermatologicallyTested': dermatologicallyTested,
      'dimension': dimension,
      'weightCapacity': weightCapacity,
      'assembly': assembly,
      'roomType': roomType,
      'weightVolume': weightVolume,
      'quantity': quantity,
      'organic': organic,
      'expiryDate': expiryDate?.millisecondsSinceEpoch,
      'storageInstruction': storageInstruction,
      'dietaryPreference': dietaryPreference,
      'graphics': graphics,
      'screenSize': screenSize,
      'operatingSystem': operatingSystem,
      'port': port,
      'footwearMaterial': footwearMaterial,
      'footwearType': footwearType,
      'shoeSize': shoeSize,
      'heelHeight': heelHeight,
      'soleMaterial': soleMaterial,
      'toeShape': toeShape,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
<<<<<<< HEAD
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
      timestamp: map['timestamp'] is Timestamp
          ? map['timestamp']
          : Timestamp.fromDate(
              DateTime.parse(
                map['timestamp'] ?? DateTime.now().toIso8601String(),
              ),
            ),
      images: List<String>.from(map['images'] ?? []),
      sellerId: map['sellerId'],
      cashOnDelivery: (map['cashOnDelivery'] is bool)
          ? map['cashOnDelivery']
          : ((map['cashOnDelivery'] ?? '').toString().toLowerCase() == 'yes'),
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
=======
      productId: map['id'] as String,
      date: map['date'] as DateTime,
      name: map['name'] as String,
      description: map['description'] as String,
      category: map['category'] as String,
      subcategory: map['subcategory'] as String,
      baseSku: map['baseSku'] as String,
      brand: map['brand'] as String,
      price: map['price'] as double,
      offerPrice: map['offerPrice'] as double,
      totalStock: map['totalStock'] as int,
      rating: map['rating'] as double,
      images: List<String>.from((map['images'] as List<String>)),
      sellerId: map['sellerId'] as String,
      cashOnDelivery: map['cashOnDelivery'] as bool,
      sizeVariants: List<SizeVariant>.from(
        (map['sizeVariants'] as List<SizeVariant>),
      ),
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] as Timestamp)
          : null,
      material: map['material'] != null ? map['material'] as String : null,
      fit: map['fit'] != null ? map['fit'] as String : null,
      pattern: map['pattern'] != null ? map['pattern'] as String : null,
      sleeveType: map['sleeveType'] != null
          ? map['sleeveType'] as String
          : null,
      careInstruction: map['careInstruction'] != null
          ? map['careInstruction'] as String
          : null,
      sizeOptions: map['sizeOptions'] != null
          ? List<String>.from((map['sizeOptions'] as List<String>))
          : null,
      hsnCode: map['hsnCode'] != null ? map['hsnCode'] as String : null,
      weight: map['weight'] != null ? map['weight'] as double : null,
      length: map['length'] != null ? map['length'] as double : null,
      width: map['width'] != null ? map['width'] as double : null,
      height: map['height'] != null ? map['height'] as double : null,
      fitType: map['fitType'] != null ? map['fitType'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      neckType: map['neckType'] != null ? map['neckType'] as String : null,
      occasion: map['occasion'] != null ? map['occasion'] as String : null,
      stitchType: map['stitchType'] != null
          ? map['stitchType'] as String
          : null,
      vendor: map['vendor'] != null ? map['vendor'] as String : null,
      variantSku: map['variantSku'] != null
          ? map['variantSku'] as String
          : null,
      closureType: map['closureType'] != null
          ? map['closureType'] as String
          : null,
      embroideryStyle: map['embroideryStyle'] != null
          ? map['embroideryStyle'] as String
          : null,
      lining: map['lining'] != null ? map['lining'] as String : null,
      model: map['model'] != null ? map['model'] as String : null,
      neckStyle: map['neckStyle'] != null ? map['neckStyle'] as String : null,
      padType: map['padType'] != null ? map['padType'] as String : null,
      pockets: map['pockets'] != null ? map['pockets'] as String : null,
      printType: map['printType'] != null ? map['printType'] as String : null,
      productLength: map['productLength'] != null
          ? map['productLength'] as String
          : null,
      productType: map['productType'] != null
          ? map['productType'] as String
          : null,
      riseStyle: map['riseStyle'] != null ? map['riseStyle'] as String : null,
      sideType: map['sideType'] != null ? map['sideType'] as String : null,
      sleeve: map['sleeve'] != null ? map['sleeve'] as String : null,
      sleeveStyle: map['sleeveStyle'] != null
          ? map['sleeveStyle'] as String
          : null,
      slitType: map['slitType'] != null ? map['slitType'] as String : null,
      specialFeatures: map['specialFeatures'] != null
          ? map['specialFeatures'] as String
          : null,
      strapType: map['strapType'] != null ? map['strapType'] as String : null,
      style: map['style'] != null ? map['style'] as String : null,
      transparent: map['transparent'] != null
          ? map['transparent'] as bool
          : null,
      type: map['type'] != null ? map['type'] as String : null,
      workType: map['workType'] != null ? map['workType'] as String : null,
      blouseAvailability: map['blouseAvailability'] != null
          ? map['blouseAvailability'] as bool
          : null,
      patternCoverage: map['patternCoverage'] != null
          ? map['patternCoverage'] as String
          : null,
      age: map['age'] != null ? map['age'] as String : null,
      ageGroup: map['ageGroup'] != null ? map['ageGroup'] as String : null,
      waistStyle: map['waistStyle'] != null
          ? map['waistStyle'] as String
          : null,
      mobileColor: map['mobileColor'] != null
          ? map['mobileColor'] as String
          : null,
      ram: map['ram'] != null ? map['ram'] as String : null,
      storage: map['storage'] != null ? map['storage'] as String : null,
      battery: map['battery'] != null ? map['battery'] as String : null,
      camera: map['camera'] != null ? map['camera'] as String : null,
      processor: map['processor'] != null ? map['processor'] as String : null,
      display: map['display'] != null ? map['display'] as String : null,
      os: map['os'] != null ? map['os'] as String : null,
      connectivity: map['connectivity'] != null
          ? map['connectivity'] as String
          : null,
      warranty: map['warranty'] != null ? map['warranty'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      designOptions: map['designOptions'] != null
          ? map['designOptions'] as String
          : null,
      resolution: map['resolution'] != null
          ? map['resolution'] as String
          : null,
      displayType: map['displayType'] != null
          ? map['displayType'] as String
          : null,
      smartFeatures: map['smartFeatures'] != null
          ? map['smartFeatures'] as String
          : null,
      energyRating: map['energyRating'] != null
          ? map['energyRating'] as String
          : null,
      powerConsumption: map['powerConsumption'] != null
          ? map['powerConsumption'] as String
          : null,
      expDate: map['expDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expDate'] as int)
          : null,
      mfgDate: map['mfgDate'] != null ? map['mfgDate'] as String : null,
      highlight: map['highlight'] != null ? map['highlight'] as String : null,
      otherHighlights: map['otherHighlights'] != null
          ? map['otherHighlights'] as String
          : null,
      jewelleryMaterial: map['jewelleryMaterial'] != null
          ? map['jewelleryMaterial'] as String
          : null,
      purity: map['purity'] != null ? map['purity'] as String : null,
      jewelleryWeight: map['jewelleryWeight'] != null
          ? map['jewelleryWeight'] as double
          : null,
      jewelleryColor: map['jewelleryColor'] != null
          ? map['jewelleryColor'] as String
          : null,
      jewellerySize: map['jewellerySize'] != null
          ? map['jewellerySize'] as String
          : null,
      gemstone: map['gemstone'] != null ? map['gemstone'] as String : null,
      certification: map['certification'] != null
          ? map['certification'] as String
          : null,
      title: map['title'] != null ? map['title'] as String : null,
      author: map['author'] != null ? map['author'] as String : null,
      publisher: map['publisher'] != null ? map['publisher'] as String : null,
      edition: map['edition'] != null ? map['edition'] as String : null,
      language: map['language'] != null ? map['language'] as String : null,
      isbn: map['isbn'] != null ? map['isbn'] as String : null,
      pages: map['pages'] != null ? map['pages'] as int : null,
      binding: map['binding'] != null ? map['binding'] as String : null,
      genre: map['genre'] != null ? map['genre'] as String : null,
      frameMaterial: map['frameMaterial'] != null
          ? map['frameMaterial'] as String
          : null,
      mountingType: map['mountingType'] != null
          ? map['mountingType'] as String
          : null,
      shadeColor: map['shadeColor'] != null
          ? map['shadeColor'] as String
          : null,
      beautyType: map['beautyType'] != null
          ? map['beautyType'] as String
          : null,
      ingredients: map['ingredients'] != null
          ? List<String>.from((map['ingredients'] as List<String>))
          : null,
      skinHairType: map['skinHairType'] != null
          ? map['skinHairType'] as String
          : null,
      beautyWeightVolume: map['beautyWeightVolume'] != null
          ? map['beautyWeightVolume'] as String
          : null,
      beautyExpiryDate: map['beautyExpiryDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['beautyExpiryDate'] as int)
          : null,
      dermatologicallyTested: map['dermatologicallyTested'] != null
          ? map['dermatologicallyTested'] as bool
          : null,
      dimension: map['dimension'] != null ? map['dimension'] as String : null,
      weightCapacity: map['weightCapacity'] != null
          ? map['weightCapacity'] as String
          : null,
      assembly: map['assembly'] != null ? map['assembly'] as String : null,
      roomType: map['roomType'] != null ? map['roomType'] as String : null,
      weightVolume: map['weightVolume'] != null
          ? map['weightVolume'] as String
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as String : null,
      organic: map['organic'] != null ? map['organic'] as bool : null,
      expiryDate: map['expiryDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expiryDate'] as int)
          : null,
      storageInstruction: map['storageInstruction'] != null
          ? map['storageInstruction'] as String
          : null,
      dietaryPreference: map['dietaryPreference'] != null
          ? map['dietaryPreference'] as String
          : null,
      graphics: map['graphics'] != null ? map['graphics'] as String : null,
      screenSize: map['screenSize'] != null
          ? map['screenSize'] as String
          : null,
      operatingSystem: map['operatingSystem'] != null
          ? map['operatingSystem'] as String
          : null,
      port: map['port'] != null ? map['port'] as String : null,
      footwearMaterial: map['footwearMaterial'] != null
          ? map['footwearMaterial'] as String
          : null,
      footwearType: map['footwearType'] != null
          ? map['footwearType'] as String
          : null,
      shoeSize: map['shoeSize'] != null ? map['shoeSize'] as String : null,
      heelHeight: map['heelHeight'] != null
          ? map['heelHeight'] as String
          : null,
      soleMaterial: map['soleMaterial'] != null
          ? map['soleMaterial'] as String
          : null,
      toeShape: map['toeShape'] != null ? map['toeShape'] as String : null,
>>>>>>> 765a30664c52cb183c2304584bf5a6dcc740c6f6
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  //this is the code will help you by getting products attributes by category
  Map<String, dynamic> getDetailsByCategory() {
    switch (category.toLowerCase()) {
      case 'fashion':
      case 'clothing':
        return {
          'material': material,
          'fit': fit,
          'pattern': pattern,
          'sleeveType': sleeveType,
          'careInstruction': careInstruction,
          'sizeOptions': sizeOptions,
          'hsnCode': hsnCode,
          'weight': weight,
          'length': length,
          'width': width,
          'height': height,
          'fitType': fitType,
          'gender': gender,
          'neckType': neckType,
          'occasion': occasion,
          'stitchType': stitchType,
          'vendor': vendor,
          'variantSku': variantSku,
          'closureType': closureType,
          'embroideryStyle': embroideryStyle,
          'lining': lining,
          'model': model,
          'neckStyle': neckStyle,
          'padType': padType,
          'pockets': pockets,
          'printType': printType,
          'productLength': productLength,
          'productType': productType,
          'riseStyle': riseStyle,
          'sideType': sideType,
          'sleeve': sleeve,
          'sleeveStyle': sleeveStyle,
          'slitType': slitType,
          'specialFeatures': specialFeatures,
          'strapType': strapType,
          'style': style,
          'transparent': transparent,
          'type': type,
          'workType': workType,
          'blouseAvailability': blouseAvailability,
          'patternCoverage': patternCoverage,
          'age': age,
          'ageGroup': ageGroup,
          'waistStyle': waistStyle,
        };

      case 'mobile':
        return {
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
          'vendor': vendor,
          'variantSku': variantSku,
          'hsnCode': hsnCode,
          'weight': weight,
          'length': length,
          'width': width,
          'height': height,
          'color': color,
          'designOptions': designOptions,
          'gender': gender,
          'material': material,
          'productType': productType,
          'type': type,
        };

      case 'electronics':
        return {
          'resolution': resolution,
          'displayType': displayType,
          'smartFeatures': smartFeatures,
          'energyRating': energyRating,
          'powerConsumption': powerConsumption,
          'vendor': vendor,
          'variantSku': variantSku,
          'hsnCode': hsnCode,
          'weight': weight,
          'length': length,
          'width': width,
          'height': height,
          'color': color,
          'expDate': expDate,
          'material': material,
          'mfgDate': mfgDate,
          'model': model,
          'pattern': pattern,
          'productType': productType,
          'type': type,
          'highlight': highlight,
          'otherHighlights': otherHighlights,
        };

      case 'jewellery':
        return {
          'jewelleryMaterial': jewelleryMaterial,
          'purity': purity,
          'jewelleryWeight': jewelleryWeight,
          'jewelleryColor': jewelleryColor,
          'jewellerySize': jewellerySize,
          'gemstone': gemstone,
          'certification': certification,
          'occasion': occasion,
          'vendor': vendor,
          'hsnCode': hsnCode,
          'length': length,
          'width': width,
          'height': height,
          'gender': gender,
          'pattern': pattern,
          'style': style,
        };

      case 'book':
      case 'books':
        return {
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

      case 'home_kitchen':
      case 'home & kitchen':
        return {
          'vendor': vendor,
          'hsnCode': hsnCode,
          'weight': weight,
          'length': length,
          'width': width,
          'height': height,
          'variantSku': variantSku,
          'color': color,
          'frameMaterial': frameMaterial,
          'model': model,
          'mountingType': mountingType,
          'type': type,
        };

      case 'beauty':
        return {
          'shadeColor': shadeColor,
          'beautyType': beautyType,
          'ingredients': ingredients,
          'skinHairType': skinHairType,
          'beautyWeightVolume': beautyWeightVolume,
          'beautyExpiryDate': beautyExpiryDate,
          'dermatologicallyTested': dermatologicallyTested,
        };

      case 'furniture':
        return {
          'sizeVariants': sizeVariants,
          'dimension': dimension,
          'weightCapacity': weightCapacity,
          'assembly': assembly,
          'style': style,
          'roomType': roomType,
        };

      case 'grocery':
        return {
          'weightVolume': weightVolume,
          'quantity': quantity,
          'organic': organic,
          'expiryDate': expiryDate,
          'storageInstruction': storageInstruction,
          'dietaryPreference': dietaryPreference,
        };

      case 'laptop':
        return {
          'graphics': graphics,
          'screenSize': screenSize,
          'operatingSystem': operatingSystem,
          'port': port,
          'ram': ram,
          'storage': storage,
          'processor': processor,
          'battery': battery,
          'weight': weight,
          'warranty': warranty,
          'model': model,
          'display': display,
          'resolution': resolution,
        };

      case 'footwear':
        return {
          'footwearMaterial': footwearMaterial,
          'footwearType': footwearType,
          'gender': gender,
          'shoeSize': shoeSize,
          'heelHeight': heelHeight,
          'closureType': closureType,
          'soleMaterial': soleMaterial,
          'pattern': pattern,
          'style': style,
          'toeShape': toeShape,
          'occasion': occasion,
          'color': color,
        };

      default:
        return {};
    }
  }
}
