// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoruteModelAdapter extends TypeAdapter<FavoruteModel> {
  @override
  final int typeId = 6;

  @override
  FavoruteModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoruteModel(
      favoriteId: fields[0] as String,
      productId: fields[1] as String,
      customerId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoruteModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.favoriteId)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.customerId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoruteModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
