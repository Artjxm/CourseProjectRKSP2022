import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: 0)
class Book {
  const Book({
    required this.id,
    required this.name,
    required this.image,
    required this.author,
    required this.given,
    required this.count,
    this.dateOfReturn = '',
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  @HiveField(3)
  final String author;

  @HiveField(5)
  final String dateOfReturn;

  @HiveField(0)
  final int id;

  @HiveField(2)
  final String image;

  @HiveField(1)
  final String name;

  // @HiveField(4)
  // final BookStatus status;

  @HiveField(7, defaultValue: [])
  final List<String> given;

  @HiveField(8, defaultValue: 1)
  final int count;

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

@HiveType(typeId: 1)
enum BookStatus {
  @HiveField(0)
  waiting,
  @HiveField(1)
  out,
}
