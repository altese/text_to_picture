// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'texfie.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TexFieAdapter extends TypeAdapter<TexFie> {
  @override
  final int typeId = 1;

  @override
  TexFie read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TexFie(
      contents: fields[0] as String,
      title: fields[1] as String?,
      author: fields[2] as String?,
      backgroundImageUrl: fields[3] as String?,
      backgoundColor: fields[4] as Color?,
      font: fields[5] as Fonts?,
      fontSize: fields[6] as double?,
      texFieUrl: fields[7] as String?,
      state: fields[8] as TexFieState,
    );
  }

  @override
  void write(BinaryWriter writer, TexFie obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.contents)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.backgroundImageUrl)
      ..writeByte(4)
      ..write(obj.backgoundColor)
      ..writeByte(5)
      ..write(obj.font)
      ..writeByte(6)
      ..write(obj.fontSize)
      ..writeByte(7)
      ..write(obj.texFieUrl)
      ..writeByte(8)
      ..write(obj.state);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TexFieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
