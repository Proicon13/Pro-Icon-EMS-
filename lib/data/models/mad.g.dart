// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mad.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MadAdapter extends TypeAdapter<Mad> {
  @override
  final int typeId = 1;

  @override
  Mad read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mad(
      id: fields[0] as int,
      serialNo: fields[1] as int,
      isActive: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Mad obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.serialNo)
      ..writeByte(2)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MadAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
