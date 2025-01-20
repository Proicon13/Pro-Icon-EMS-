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
      id: fields[1] as int,
      serialNo: fields[2] as int,
      isActive: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Mad obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.serialNo)
      ..writeByte(3)
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
