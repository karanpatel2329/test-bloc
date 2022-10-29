import 'package:hive/hive.dart';

part 'test_model.g.dart';
@HiveType(typeId: 0)
class TestModel{
  @HiveField(0)
  final String title;
  @HiveField(1)
  final DateTime createAt;
  @HiveField(2)
  final List topic;

  TestModel({required this.title,required this.topic,required this.createAt});
}