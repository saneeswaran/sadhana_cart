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
      sku: fields[5] as String,
      brand: fields[6] as String,
      price: fields[7] as double,
      offerPrice: fields[8] as double,
      stock: fields[9] as int,
      rating: fields[10] as double,
      timestamp: fields[11] as DateTime,
      images: (fields[12] as List).cast<String>(),
      sellerId: fields[13] as String?,
      cashOnDelivery: fields[14] as String,
      color: fields[15] as String?,
      material: fields[16] as String?,
      fit: fields[17] as String?,
      pattern: fields[18] as String?,
      sleeveType: fields[19] as String?,
      careInstruction: fields[20] as String?,
      size: fields[21] as String?,
      footwearSize: fields[22] as String?,
      footwearColor: fields[23] as String?,
      footwearMaterial: fields[24] as String?,
      footwearType: fields[25] as String?,
      gender: fields[26] as String?,
      model: fields[27] as String?,
      mobileColor: fields[28] as String?,
      ram: fields[29] as String?,
      storage: fields[30] as String?,
      battery: fields[31] as String?,
      camera: fields[32] as String?,
      processor: fields[33] as String?,
      display: fields[34] as String?,
      os: fields[35] as String?,
      connectivity: fields[36] as String?,
      warranty: fields[37] as String?,
      graphics: fields[38] as String?,
      screenSize: fields[39] as String?,
      operatingSystem: fields[40] as String?,
      port: fields[41] as String?,
      weight: fields[42] as String?,
      resolution: fields[43] as String?,
      displayType: fields[44] as String?,
      smartFeatures: fields[45] as String?,
      energyRating: fields[46] as String?,
      powerConsumption: fields[47] as String?,
      dimension: fields[48] as String?,
      weightCapacity: fields[49] as String?,
      assembly: fields[50] as String?,
      style: fields[51] as String?,
      roomType: fields[52] as String?,
      weightVolume: fields[53] as String?,
      quantity: fields[54] as String?,
      organic: fields[55] as String?,
      expiryDate: fields[56] as String?,
      storageInstruction: fields[57] as String?,
      dietaryPreference: fields[58] as String?,
      shadeColor: fields[59] as String?,
      beautyType: fields[60] as String?,
      ingredients: fields[61] as String?,
      skinHairType: fields[62] as String?,
      beautyWeightVolume: fields[63] as String?,
      beautyExpiryDate: fields[64] as String?,
      dermatologicallyTested: fields[65] as String?,
      jewelleryMaterial: fields[66] as String?,
      purity: fields[67] as String?,
      jewelleryWeight: fields[68] as String?,
      jewelleryColor: fields[69] as String?,
      jewellerySize: fields[70] as String?,
      gemstone: fields[71] as String?,
      certification: fields[72] as String?,
      occasion: fields[73] as String?,
      title: fields[74] as String?,
      author: fields[75] as String?,
      publisher: fields[76] as String?,
      edition: fields[77] as String?,
      language: fields[78] as String?,
      isbn: fields[79] as String?,
      pages: fields[80] as String?,
      binding: fields[81] as String?,
      genre: fields[82] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(83)
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
      ..write(obj.sku)
      ..writeByte(6)
      ..write(obj.brand)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.offerPrice)
      ..writeByte(9)
      ..write(obj.stock)
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
      ..write(obj.color)
      ..writeByte(16)
      ..write(obj.material)
      ..writeByte(17)
      ..write(obj.fit)
      ..writeByte(18)
      ..write(obj.pattern)
      ..writeByte(19)
      ..write(obj.sleeveType)
      ..writeByte(20)
      ..write(obj.careInstruction)
      ..writeByte(21)
      ..write(obj.size)
      ..writeByte(22)
      ..write(obj.footwearSize)
      ..writeByte(23)
      ..write(obj.footwearColor)
      ..writeByte(24)
      ..write(obj.footwearMaterial)
      ..writeByte(25)
      ..write(obj.footwearType)
      ..writeByte(26)
      ..write(obj.gender)
      ..writeByte(27)
      ..write(obj.model)
      ..writeByte(28)
      ..write(obj.mobileColor)
      ..writeByte(29)
      ..write(obj.ram)
      ..writeByte(30)
      ..write(obj.storage)
      ..writeByte(31)
      ..write(obj.battery)
      ..writeByte(32)
      ..write(obj.camera)
      ..writeByte(33)
      ..write(obj.processor)
      ..writeByte(34)
      ..write(obj.display)
      ..writeByte(35)
      ..write(obj.os)
      ..writeByte(36)
      ..write(obj.connectivity)
      ..writeByte(37)
      ..write(obj.warranty)
      ..writeByte(38)
      ..write(obj.graphics)
      ..writeByte(39)
      ..write(obj.screenSize)
      ..writeByte(40)
      ..write(obj.operatingSystem)
      ..writeByte(41)
      ..write(obj.port)
      ..writeByte(42)
      ..write(obj.weight)
      ..writeByte(43)
      ..write(obj.resolution)
      ..writeByte(44)
      ..write(obj.displayType)
      ..writeByte(45)
      ..write(obj.smartFeatures)
      ..writeByte(46)
      ..write(obj.energyRating)
      ..writeByte(47)
      ..write(obj.powerConsumption)
      ..writeByte(48)
      ..write(obj.dimension)
      ..writeByte(49)
      ..write(obj.weightCapacity)
      ..writeByte(50)
      ..write(obj.assembly)
      ..writeByte(51)
      ..write(obj.style)
      ..writeByte(52)
      ..write(obj.roomType)
      ..writeByte(53)
      ..write(obj.weightVolume)
      ..writeByte(54)
      ..write(obj.quantity)
      ..writeByte(55)
      ..write(obj.organic)
      ..writeByte(56)
      ..write(obj.expiryDate)
      ..writeByte(57)
      ..write(obj.storageInstruction)
      ..writeByte(58)
      ..write(obj.dietaryPreference)
      ..writeByte(59)
      ..write(obj.shadeColor)
      ..writeByte(60)
      ..write(obj.beautyType)
      ..writeByte(61)
      ..write(obj.ingredients)
      ..writeByte(62)
      ..write(obj.skinHairType)
      ..writeByte(63)
      ..write(obj.beautyWeightVolume)
      ..writeByte(64)
      ..write(obj.beautyExpiryDate)
      ..writeByte(65)
      ..write(obj.dermatologicallyTested)
      ..writeByte(66)
      ..write(obj.jewelleryMaterial)
      ..writeByte(67)
      ..write(obj.purity)
      ..writeByte(68)
      ..write(obj.jewelleryWeight)
      ..writeByte(69)
      ..write(obj.jewelleryColor)
      ..writeByte(70)
      ..write(obj.jewellerySize)
      ..writeByte(71)
      ..write(obj.gemstone)
      ..writeByte(72)
      ..write(obj.certification)
      ..writeByte(73)
      ..write(obj.occasion)
      ..writeByte(74)
      ..write(obj.title)
      ..writeByte(75)
      ..write(obj.author)
      ..writeByte(76)
      ..write(obj.publisher)
      ..writeByte(77)
      ..write(obj.edition)
      ..writeByte(78)
      ..write(obj.language)
      ..writeByte(79)
      ..write(obj.isbn)
      ..writeByte(80)
      ..write(obj.pages)
      ..writeByte(81)
      ..write(obj.binding)
      ..writeByte(82)
      ..write(obj.genre);
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
