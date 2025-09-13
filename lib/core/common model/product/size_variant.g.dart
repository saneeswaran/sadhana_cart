// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'size_variant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SizeVariantAdapter extends TypeAdapter<SizeVariant> {
  @override
  final int typeId = 9;

  @override
  SizeVariant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SizeVariant(
      size: fields[0] as String,
      color: fields[1] as String?,
      stock: fields[2] as int,
      skuSuffix: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SizeVariant obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.size)
      ..writeByte(1)
      ..write(obj.color)
      ..writeByte(2)
      ..write(obj.stock)
      ..writeByte(3)
      ..write(obj.skuSuffix);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SizeVariantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SizeVariant _$SizeVariantFromJson(Map<String, dynamic> json) => SizeVariant(
      size: json['size'] as String,
      color: json['color'] as String?,
      stock: (json['stock'] as num).toInt(),
      skuSuffix: json['skuSuffix'] as String?,
    );

Map<String, dynamic> _$SizeVariantToJson(SizeVariant instance) =>
    <String, dynamic>{
      'size': instance.size,
      'color': instance.color,
      'stock': instance.stock,
      'skuSuffix': instance.skuSuffix,
    };
