// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestModelAdapter extends TypeAdapter<TestModel> {
  @override
  final int typeId = 0;

  @override
  TestModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TestModel(
      title: fields[0] as String,
      topic: (fields[2] as List).cast<dynamic>(),
      createAt: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TestModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.createAt)
      ..writeByte(2)
      ..write(obj.topic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
