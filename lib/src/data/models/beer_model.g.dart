// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BeerModelAdapter extends TypeAdapter<BeerModel> {
  @override
  final int typeId = 0;

  @override
  BeerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BeerModel(
      id: fields[0] as int,
      name: fields[1] as String,
      tagline: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BeerModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.tagline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BeerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
