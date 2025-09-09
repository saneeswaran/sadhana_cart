// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubcategoryModelAdapter extends TypeAdapter<SubcategoryModel> {
  @override
  final int typeId = 3;

  @override
  SubcategoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubcategoryModel(
      id: fields[0] as String,
      name: fields[1] as String,
      category: fields[2] as String,
      createdAt: fields[3] as Timestamp?,
      updatedAt: fields[4] as Timestamp?,
    );
  }

  @override
  void write(BinaryWriter writer, SubcategoryModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubcategoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
