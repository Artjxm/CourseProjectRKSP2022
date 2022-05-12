import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book.g.dart';

@CopyWith()
@JsonSerializable()
class Book {
  const Book({
    required this.id,
    required this.author,
    required this.name,
    required this.image,
    required this.given,
    required this.count,
    this.dateOfReturn = '',
  });

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);

  final String author;
  final String dateOfReturn;
  final int id;
  final String image;
  final String name;
  final List<String> given;
  final int count;

  Map<String, dynamic> toJson() => _$BookToJson(this);
}

enum BookStatus {
  waiting,
  out,
}
