// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PostsAdapter extends TypeAdapter<Posts> {
  @override
  final int typeId = 0;

  @override
  Posts read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Posts(
      title: fields[1] as String?,
      image: fields[2] as String?,
      contents: fields[3] as String?,
      time: fields[4] as String?,
      author: fields[5] as String?,
      id: fields[6] as String?,
    )..isDark = fields[0] as bool?;
  }

  @override
  void write(BinaryWriter writer, Posts obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.isDark)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.contents)
      ..writeByte(4)
      ..write(obj.time)
      ..writeByte(5)
      ..write(obj.author)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
