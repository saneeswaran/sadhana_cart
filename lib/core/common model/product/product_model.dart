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

// ignore_for_file: invalid_annotation_target

import 'package:sadhana_cart/core/common%20model/product/size_variant.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
class ProductModel with _$ProductModel {
  const factory ProductModel({
    @JsonKey(name: 'Product ID') String? productId,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'Description') String? description,
    @JsonKey(name: 'Category') String? category,
    @JsonKey(name: 'Subcategory') String? subcategory,
    @JsonKey(name: 'Base SKU') String? baseSku,
    @JsonKey(name: 'Brand') String? brand,
    @JsonKey(name: 'Price') double? price,
    @JsonKey(name: 'Offer Price') double? offerPrice,
    @JsonKey(name: 'Stock') int? stock,
    @JsonKey(name: 'Rating') double? rating,
    @JsonKey(name: 'Images') List<String>? images,
    @JsonKey(name: 'Seller ID') String? sellerId,
    @JsonKey(name: 'Cash On Delivery') String? cashOnDelivery,
    @JsonKey(name: 'Size Variants') List<SizeVariant>? sizeVariants,

    @JsonKey(name: 'Timestamp') String? timestamp,
    @JsonKey(name: 'Date') String? date,

    // Fashion / Clothing
    @JsonKey(name: 'Material') String? material,
    @JsonKey(name: 'Fit') String? fit,
    @JsonKey(name: 'Pattern') String? pattern,
    @JsonKey(name: 'Sleeve Type') String? sleeveType,
    @JsonKey(name: 'Care Instructions') String? careInstruction,
    @JsonKey(name: 'Size Options') List<String>? sizeOptions,
    @JsonKey(name: 'HSN Code') String? hsnCode,
    @JsonKey(name: 'Weight') double? weight,
    @JsonKey(name: 'Length') double? length,
    @JsonKey(name: 'Width') double? width,
    @JsonKey(name: 'Height') double? height,
    @JsonKey(name: 'Fit Type') String? fitType,
    @JsonKey(name: 'Gender') String? gender,
    @JsonKey(name: 'Neck Type') String? neckType,
    @JsonKey(name: 'Occasion') String? occasion,
    @JsonKey(name: 'Stitch Type') String? stitchType,
    @JsonKey(name: 'Vendor') String? vendor,
    @JsonKey(name: 'Variant SKU') String? variantSku,
    @JsonKey(name: 'Closure Type') String? closureType,
    @JsonKey(name: 'Embroidery Style') String? embroideryStyle,
    @JsonKey(name: 'Lining') String? lining,
    @JsonKey(name: 'Model') String? model,
    @JsonKey(name: 'Neck Style') String? neckStyle,
    @JsonKey(name: 'Pad Type') String? padType,
    @JsonKey(name: 'Pockets') String? pockets,
    @JsonKey(name: 'Print Type') String? printType,
    @JsonKey(name: 'Product Length') String? productLength,
    @JsonKey(name: 'Product Type') String? productType,
    @JsonKey(name: 'Rise Style') String? riseStyle,
    @JsonKey(name: 'Side Type') String? sideType,
    @JsonKey(name: 'Sleeve') String? sleeve,
    @JsonKey(name: 'Sleeve Style') String? sleeveStyle,
    @JsonKey(name: 'Slit Type') String? slitType,
    @JsonKey(name: 'Special Features') String? specialFeatures,
    @JsonKey(name: 'Strap Type') String? strapType,
    @JsonKey(name: 'Style') String? style,
    @JsonKey(name: 'Transparent') String? transparent,
    @JsonKey(name: 'Type') String? type,
    @JsonKey(name: 'Work Type') String? workType,
    @JsonKey(name: 'Blouse Availability') String? blouseAvailability,
    @JsonKey(name: 'Pattern Coverage') String? patternCoverage,
    @JsonKey(name: 'Age') String? age,
    @JsonKey(name: 'Age Group') String? ageGroup,
    @JsonKey(name: 'Waist Style') String? waistStyle,

    // Mobile
    @JsonKey(name: 'Mobile Color') String? mobileColor,
    @JsonKey(name: 'RAM') String? ram,
    @JsonKey(name: 'Storage') String? storage,
    @JsonKey(name: 'Battery') String? battery,
    @JsonKey(name: 'Camera') String? camera,
    @JsonKey(name: 'Processor') String? processor,
    @JsonKey(name: 'Display') String? display,
    @JsonKey(name: 'OS') String? os,
    @JsonKey(name: 'Connectivity') String? connectivity,
    @JsonKey(name: 'Warranty') String? warranty,
    @JsonKey(name: 'Color') String? color,
    @JsonKey(name: 'Design Options') String? designOptions,

    // Electronics
    @JsonKey(name: 'Resolution') String? resolution,
    @JsonKey(name: 'Display Type') String? displayType,
    @JsonKey(name: 'Smart Features') String? smartFeatures,
    @JsonKey(name: 'Energy Rating') String? energyRating,
    @JsonKey(name: 'Power Consumption') String? powerConsumption,
    @JsonKey(name: 'Exp Date') DateTime? expDate,
    @JsonKey(name: 'MFG Date') String? mfgDate,
    @JsonKey(name: 'Highlight') String? highlight,
    @JsonKey(name: 'Other Highlights') String? otherHighlights,

    // Jewellery
    @JsonKey(name: 'Jewellery Material') String? jewelleryMaterial,
    @JsonKey(name: 'Purity') String? purity,
    @JsonKey(name: 'Jewellery Weight') double? jewelleryWeight,
    @JsonKey(name: 'Jewellery Color') String? jewelleryColor,
    @JsonKey(name: 'Jewellery Size') String? jewellerySize,
    @JsonKey(name: 'Gemstone') String? gemstone,
    @JsonKey(name: 'Certification') String? certification,

    // Book
    @JsonKey(name: 'Title') String? title,
    @JsonKey(name: 'Author') String? author,
    @JsonKey(name: 'Publisher') String? publisher,
    @JsonKey(name: 'Edition') String? edition,
    @JsonKey(name: 'Language') String? language,
    @JsonKey(name: 'ISBN') String? isbn,
    @JsonKey(name: 'Pages') int? pages,
    @JsonKey(name: 'Binding') String? binding,
    @JsonKey(name: 'Genre') String? genre,

    // Home & Kitchen
    @JsonKey(name: 'Frame Material') String? frameMaterial,
    @JsonKey(name: 'Mounting Type') String? mountingType,

    // Beauty
    @JsonKey(name: 'Shade Color') String? shadeColor,
    @JsonKey(name: 'Beauty Type') String? beautyType,
    @JsonKey(name: 'Ingredients') List<String>? ingredients,
    @JsonKey(name: 'Skin Hair Type') String? skinHairType,
    @JsonKey(name: 'Beauty Weight Volume') String? beautyWeightVolume,
    @JsonKey(name: 'Beauty Expiry Date') String? beautyExpiryDate,
    @JsonKey(name: 'Dermatologically Tested') String? dermatologicallyTested,

    // Furniture
    @JsonKey(name: 'Dimension') String? dimension,
    @JsonKey(name: 'Weight Capacity') String? weightCapacity,
    @JsonKey(name: 'Assembly') String? assembly,
    @JsonKey(name: 'Room Type') String? roomType,

    // Grocery
    @JsonKey(name: 'Weight Volume') String? weightVolume,
    @JsonKey(name: 'Quantity') String? quantity,
    @JsonKey(name: 'Organic') String? organic,
    @JsonKey(name: 'Expiry Date') String? expiryDate,
    @JsonKey(name: 'Storage Instruction') String? storageInstruction,
    @JsonKey(name: 'Dietary Preference') String? dietaryPreference,

    // Laptop
    @JsonKey(name: 'Graphics') String? graphics,
    @JsonKey(name: 'Screen Size') String? screenSize,
    @JsonKey(name: 'Operating System') String? operatingSystem,
    @JsonKey(name: 'Port') String? port,

    // Footwear
    @JsonKey(name: 'Footwear Material') String? footwearMaterial,
    @JsonKey(name: 'Footwear Type') String? footwearType,
    @JsonKey(name: 'Shoe Size') String? shoeSize,
    @JsonKey(name: 'Heel Height') String? heelHeight,
    @JsonKey(name: 'Sole Material') String? soleMaterial,
    @JsonKey(name: 'Toe Shape') String? toeShape,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  static ProductModel fromMap(Map<String, dynamic> map) =>
      _$ProductModelFromJson(map);
}
