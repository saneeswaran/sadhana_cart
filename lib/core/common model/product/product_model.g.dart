// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 4;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      productId: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      category: fields[3] as String,
      subcategory: fields[4] as String,
      baseSku: fields[5] as String,
      brand: fields[6] as String,
      price: fields[7] as double,
      offerPrice: fields[8] as double,
      rating: fields[10] as double,
      timestamp: fields[11] as Timestamp,
      images: (fields[12] as List).cast<String>(),
      sellerId: fields[13] as String?,
      cashOnDelivery: fields[14] as bool,
      sizeVariants: (fields[15] as List).cast<SizeVariant>(),
      colorOptions: (fields[16] as List?)?.cast<String>(),
      material: fields[17] as String?,
      fit: fields[18] as String?,
      pattern: fields[19] as String?,
      sleeveType: fields[20] as String?,
      careInstruction: fields[21] as String?,
      sizeOptions: (fields[22] as List?)?.cast<String>(),
      footwearMaterial: fields[23] as String?,
      footwearType: fields[24] as String?,
      gender: fields[25] as String?,
      model: fields[26] as String?,
      mobileColor: fields[27] as String?,
      ram: fields[28] as String?,
      storage: fields[29] as String?,
      battery: fields[30] as String?,
      camera: fields[31] as String?,
      processor: fields[32] as String?,
      display: fields[33] as String?,
      os: fields[34] as String?,
      connectivity: fields[35] as String?,
      warranty: fields[36] as String?,
      graphics: fields[37] as String?,
      screenSize: fields[38] as String?,
      operatingSystem: fields[39] as String?,
      port: fields[40] as String?,
      weight: fields[41] as String?,
      resolution: fields[42] as String?,
      displayType: fields[43] as String?,
      smartFeatures: fields[44] as String?,
      energyRating: fields[45] as String?,
      powerConsumption: fields[46] as String?,
      dimension: fields[47] as String?,
      weightCapacity: fields[48] as String?,
      assembly: fields[49] as String?,
      style: fields[50] as String?,
      roomType: fields[51] as String?,
      weightVolume: fields[52] as String?,
      quantity: fields[53] as String?,
      organic: fields[54] as String?,
      expiryDate: fields[55] as String?,
      storageInstruction: fields[56] as String?,
      dietaryPreference: fields[57] as String?,
      shadeColor: fields[58] as String?,
      beautyType: fields[59] as String?,
      ingredients: fields[60] as String?,
      skinHairType: fields[61] as String?,
      beautyWeightVolume: fields[62] as String?,
      beautyExpiryDate: fields[63] as String?,
      dermatologicallyTested: fields[64] as String?,
      jewelleryMaterial: fields[65] as String?,
      purity: fields[66] as String?,
      jewelleryWeight: fields[67] as String?,
      jewelleryColor: fields[68] as String?,
      jewellerySize: fields[69] as String?,
      gemstone: fields[70] as String?,
      certification: fields[71] as String?,
      occasion: fields[72] as String?,
      title: fields[73] as String?,
      author: fields[74] as String?,
      publisher: fields[75] as String?,
      edition: fields[76] as String?,
      language: fields[77] as String?,
      isbn: fields[78] as String?,
      pages: fields[79] as String?,
      binding: fields[80] as String?,
      genre: fields[81] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(82)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.category)
      ..writeByte(4)
      ..write(obj.subcategory)
      ..writeByte(5)
      ..write(obj.baseSku)
      ..writeByte(6)
      ..write(obj.brand)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.offerPrice)
      ..writeByte(10)
      ..write(obj.rating)
      ..writeByte(11)
      ..write(obj.timestamp)
      ..writeByte(12)
      ..write(obj.images)
      ..writeByte(13)
      ..write(obj.sellerId)
      ..writeByte(14)
      ..write(obj.cashOnDelivery)
      ..writeByte(15)
      ..write(obj.sizeVariants)
      ..writeByte(16)
      ..write(obj.colorOptions)
      ..writeByte(17)
      ..write(obj.material)
      ..writeByte(18)
      ..write(obj.fit)
      ..writeByte(19)
      ..write(obj.pattern)
      ..writeByte(20)
      ..write(obj.sleeveType)
      ..writeByte(21)
      ..write(obj.careInstruction)
      ..writeByte(22)
      ..write(obj.sizeOptions)
      ..writeByte(23)
      ..write(obj.footwearMaterial)
      ..writeByte(24)
      ..write(obj.footwearType)
      ..writeByte(25)
      ..write(obj.gender)
      ..writeByte(26)
      ..write(obj.model)
      ..writeByte(27)
      ..write(obj.mobileColor)
      ..writeByte(28)
      ..write(obj.ram)
      ..writeByte(29)
      ..write(obj.storage)
      ..writeByte(30)
      ..write(obj.battery)
      ..writeByte(31)
      ..write(obj.camera)
      ..writeByte(32)
      ..write(obj.processor)
      ..writeByte(33)
      ..write(obj.display)
      ..writeByte(34)
      ..write(obj.os)
      ..writeByte(35)
      ..write(obj.connectivity)
      ..writeByte(36)
      ..write(obj.warranty)
      ..writeByte(37)
      ..write(obj.graphics)
      ..writeByte(38)
      ..write(obj.screenSize)
      ..writeByte(39)
      ..write(obj.operatingSystem)
      ..writeByte(40)
      ..write(obj.port)
      ..writeByte(41)
      ..write(obj.weight)
      ..writeByte(42)
      ..write(obj.resolution)
      ..writeByte(43)
      ..write(obj.displayType)
      ..writeByte(44)
      ..write(obj.smartFeatures)
      ..writeByte(45)
      ..write(obj.energyRating)
      ..writeByte(46)
      ..write(obj.powerConsumption)
      ..writeByte(47)
      ..write(obj.dimension)
      ..writeByte(48)
      ..write(obj.weightCapacity)
      ..writeByte(49)
      ..write(obj.assembly)
      ..writeByte(50)
      ..write(obj.style)
      ..writeByte(51)
      ..write(obj.roomType)
      ..writeByte(52)
      ..write(obj.weightVolume)
      ..writeByte(53)
      ..write(obj.quantity)
      ..writeByte(54)
      ..write(obj.organic)
      ..writeByte(55)
      ..write(obj.expiryDate)
      ..writeByte(56)
      ..write(obj.storageInstruction)
      ..writeByte(57)
      ..write(obj.dietaryPreference)
      ..writeByte(58)
      ..write(obj.shadeColor)
      ..writeByte(59)
      ..write(obj.beautyType)
      ..writeByte(60)
      ..write(obj.ingredients)
      ..writeByte(61)
      ..write(obj.skinHairType)
      ..writeByte(62)
      ..write(obj.beautyWeightVolume)
      ..writeByte(63)
      ..write(obj.beautyExpiryDate)
      ..writeByte(64)
      ..write(obj.dermatologicallyTested)
      ..writeByte(65)
      ..write(obj.jewelleryMaterial)
      ..writeByte(66)
      ..write(obj.purity)
      ..writeByte(67)
      ..write(obj.jewelleryWeight)
      ..writeByte(68)
      ..write(obj.jewelleryColor)
      ..writeByte(69)
      ..write(obj.jewellerySize)
      ..writeByte(70)
      ..write(obj.gemstone)
      ..writeByte(71)
      ..write(obj.certification)
      ..writeByte(72)
      ..write(obj.occasion)
      ..writeByte(73)
      ..write(obj.title)
      ..writeByte(74)
      ..write(obj.author)
      ..writeByte(75)
      ..write(obj.publisher)
      ..writeByte(76)
      ..write(obj.edition)
      ..writeByte(77)
      ..write(obj.language)
      ..writeByte(78)
      ..write(obj.isbn)
      ..writeByte(79)
      ..write(obj.pages)
      ..writeByte(80)
      ..write(obj.binding)
      ..writeByte(81)
      ..write(obj.genre)
      ..writeByte(9)
      ..write(obj.totalStock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
