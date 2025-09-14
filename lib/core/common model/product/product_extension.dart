import 'dart:developer';
import 'product_model.dart';

extension ProductModelExtensions on ProductModel {
  Map<String, dynamic> getDetailsByCategory() {
    if (category == null) return {};

    final normalizedCategory = category!.toLowerCase().replaceAll(' ', '');
    log("from model $normalizedCategory");

    switch (normalizedCategory) {
      case "brassiere":
      case "kidsdress":
      case "mensbottomwear":
      case 'fashion':
      case 'clothing':
      case 'menswear':
      case 'womenswear':
      case 'kidswear':
      case "dress":
      case "womens":
      case "womenstops":
      case "womensdress":
      case "wears":
      case 'frock':
      case 'gown':
      case 'lehenga':
      case 'kurti':
      case 'tops':
      case 'tshirt':
      case 'salwar':
      case 'ethnic':
      case 'skirt':
      case 'jumpsuit':
      case 'outfit':
      case 'partywear':
      case 'casualwear':
      case 'formalwear':
      case 'casual':
      case 'formal':
      case 'casuals':
      case 'formals':
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

      case 'homekitchen':
      case 'home&kitchen':
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
      case 'beauty&personalcare':
      case 'personalcare':
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
