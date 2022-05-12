// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$BookCWProxy {
  Book author(String author);

  Book count(int count);

  Book dateOfReturn(String dateOfReturn);

  Book given(List<String> given);

  Book id(int id);

  Book image(String image);

  Book name(String name);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Book(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Book(...).copyWith(id: 12, name: "My name")
  /// ````
  Book call({
    String? author,
    int? count,
    String? dateOfReturn,
    List<String>? given,
    int? id,
    String? image,
    String? name,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfBook.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfBook.copyWith.fieldName(...)`
class _$BookCWProxyImpl implements _$BookCWProxy {
  final Book _value;

  const _$BookCWProxyImpl(this._value);

  @override
  Book author(String author) => this(author: author);

  @override
  Book count(int count) => this(count: count);

  @override
  Book dateOfReturn(String dateOfReturn) => this(dateOfReturn: dateOfReturn);

  @override
  Book given(List<String> given) => this(given: given);

  @override
  Book id(int id) => this(id: id);

  @override
  Book image(String image) => this(image: image);

  @override
  Book name(String name) => this(name: name);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Book(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Book(...).copyWith(id: 12, name: "My name")
  /// ````
  Book call({
    Object? author = const $CopyWithPlaceholder(),
    Object? count = const $CopyWithPlaceholder(),
    Object? dateOfReturn = const $CopyWithPlaceholder(),
    Object? given = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? image = const $CopyWithPlaceholder(),
    Object? name = const $CopyWithPlaceholder(),
  }) {
    return Book(
      author: author == const $CopyWithPlaceholder() || author == null
          ? _value.author
          // ignore: cast_nullable_to_non_nullable
          : author as String,
      count: count == const $CopyWithPlaceholder() || count == null
          ? _value.count
          // ignore: cast_nullable_to_non_nullable
          : count as int,
      dateOfReturn:
          dateOfReturn == const $CopyWithPlaceholder() || dateOfReturn == null
              ? _value.dateOfReturn
              // ignore: cast_nullable_to_non_nullable
              : dateOfReturn as String,
      given: given == const $CopyWithPlaceholder() || given == null
          ? _value.given
          // ignore: cast_nullable_to_non_nullable
          : given as List<String>,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      image: image == const $CopyWithPlaceholder() || image == null
          ? _value.image
          // ignore: cast_nullable_to_non_nullable
          : image as String,
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
    );
  }
}

extension $BookCopyWith on Book {
  /// Returns a callable class that can be used as follows: `instanceOfclass Book.name.copyWith(...)` or like so:`instanceOfclass Book.name.copyWith.fieldName(...)`.
  _$BookCWProxy get copyWith => _$BookCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      id: json['id'] as int,
      author: json['author'] as String,
      name: json['name'] as String,
      image: json['image'] as String,
      given: (json['given'] as List<dynamic>).map((e) => e as String).toList(),
      count: json['count'] as int,
      dateOfReturn: json['dateOfReturn'] as String? ?? '',
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'author': instance.author,
      'dateOfReturn': instance.dateOfReturn,
      'id': instance.id,
      'image': instance.image,
      'name': instance.name,
      'given': instance.given,
      'count': instance.count,
    };
