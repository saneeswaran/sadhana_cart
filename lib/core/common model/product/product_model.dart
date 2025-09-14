//please don't think about why this product model have so many things
//because client not willing to hire people to make changes in excel sheet
//also baapstore are not willing to create form based on our database structure
//i don't have choice now.. if any good developer see this if you can optimize the model please do
//also explain about data structure to client... there some unused values are storing in the database
//i don't have choice now... sometime the stock count not showing in the product list
//when they upload the product with bulk upload option... that thing is waste until they strictly follow the data structure
//please explain and optimize the data structure to client
//i don't have choice now.. if any good developer see this this if you can optimize the model please do

//here important message
//we mention datetime, timestamp also string.... because of the bulk upload option.. it don't have any option
//if any developer see this means please don't curse us...
//we given one structure there are not following that so we given like this

import 'package:sadhana_cart/core/common%20model/product/size_variant.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    final String? productId,
    final String? name,
    final String? description,
    final String? category,
    final String? subcategory,
    final String? baseSku,
    final String? brand,
    final double? price,
    final double? offerPrice,
    final int? stock,
    final double? rating,
    final List<String>? images,
    final String? sellerId,
    final String? cashOnDelivery,
    final List<SizeVariant>? sizeVariants,
    final String? timestamp,
    final String? date,

    // Fashion / Clothing
    final String? material,
    final String? fit,
    final String? pattern,
    final String? sleeveType,
    final String? careInstruction,
    final List<String>? sizeOptions,
    final String? hsnCode,
    final double? weight,
    final double? length,
    final double? width,
    final double? height,
    final String? fitType,
    final String? gender,
    final String? neckType,
    final String? occasion,
    final String? stitchType,
    final String? vendor,
    final String? variantSku,
    final String? closureType,
    final String? embroideryStyle,
    final String? lining,
    final String? model,
    final String? neckStyle,
    final String? padType,
    final String? pockets,
    final String? printType,
    final String? productLength,
    final String? productType,
    final String? riseStyle,
    final String? sideType,
    final String? sleeve,
    final String? sleeveStyle,
    final String? slitType,
    final String? specialFeatures,
    final String? strapType,
    final String? style,
    final bool? transparent,
    final String? type,
    final String? workType,
    final bool? blouseAvailability,
    final String? patternCoverage,
    final String? age,
    final String? ageGroup,
    final String? waistStyle,

    // Mobile
    final String? mobileColor,
    final String? ram,
    final String? storage,
    final String? battery,
    final String? camera,
    final String? processor,
    final String? display,
    final String? os,
    final String? connectivity,
    final String? warranty,
    final String? color,
    final String? designOptions,

    // Electronics
    final String? resolution,
    final String? displayType,
    final String? smartFeatures,
    final String? energyRating,
    final String? powerConsumption,
    final DateTime? expDate,
    final String? mfgDate,
    final String? highlight,
    final String? otherHighlights,

    // Jewellery
    final String? jewelleryMaterial,
    final String? purity,
    final double? jewelleryWeight,
    final String? jewelleryColor,
    final String? jewellerySize,
    final String? gemstone,
    final String? certification,

    // Book
    final String? title,
    final String? author,
    final String? publisher,
    final String? edition,
    final String? language,
    final String? isbn,
    final int? pages,
    final String? binding,
    final String? genre,

    // Home & Kitchen
    final String? frameMaterial,
    final String? mountingType,

    // Beauty
    final String? shadeColor,
    final String? beautyType,
    final List<String>? ingredients,
    final String? skinHairType,
    final String? beautyWeightVolume,
    final String? beautyExpiryDate,
    final bool? dermatologicallyTested,

    // Furniture
    final String? dimension,
    final String? weightCapacity,
    final String? assembly,
    final String? roomType,

    // Grocery
    final String? weightVolume,
    final String? quantity,
    final bool? organic,
    final String? expiryDate,
    final String? storageInstruction,
    final String? dietaryPreference,

    // Laptop
    final String? graphics,
    final String? screenSize,
    final String? operatingSystem,
    final String? port,

    // Footwear
    final String? footwearMaterial,
    final String? footwearType,
    final String? shoeSize,
    final String? heelHeight,
    final String? soleMaterial,
    final String? toeShape,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  static ProductModel fromMap(Map<String, dynamic> map) =>
      _$ProductModelFromJson(map);
}
