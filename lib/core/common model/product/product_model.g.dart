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
      stock: fields[8] as int,
      rating: fields[9] as double,
      timestamp: fields[10] as Timestamp,
      images: (fields[11] as List).cast<String>(),
      attributes: (fields[13] as Map).cast<String, dynamic>(),
      sellerId: fields[12] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(14)
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
      ..write(obj.stock)
      ..writeByte(9)
      ..write(obj.rating)
      ..writeByte(10)
      ..write(obj.timestamp)
      ..writeByte(11)
      ..write(obj.images)
      ..writeByte(12)
      ..write(obj.sellerId)
      ..writeByte(13)
      ..write(obj.attributes);
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
