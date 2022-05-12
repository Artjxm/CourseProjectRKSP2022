import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:books_front/features/books/domain/entities/book.dart';
import 'package:books_front/main.dart';
import 'package:dio/dio.dart';

abstract class BooksRepository {
  BooksRepository();

  final StreamController<List<Book>> content =
      StreamController<List<Book>>.broadcast();

  Future<void> createBook(Book book);

  Future<void> deleteBook(Book book);

  Future<void> putBook(Book book);

  Future<List<Book>> getBooks();
}

class BooksRepositoryImpl extends BooksRepository {
  BooksRepositoryImpl({
    required this.dio,
  });

  final Dio dio;
  final String url = isProd
      ? 'https://bookstore-backend-paper.herokuapp.com/books/'
      : 'http://localhost:8080/books/';
  //'http://localhost:8080/books/'; //'https://bookstore-backend-paper.herokuapp.com/books/';

  @override
  Future<void> createBook(Book book) async {
    try {
      log('Create book ${book.name}');
      final response = await dio.post(
        url,
        data: json.encode(book.toJson()),
      );
      log(response.data.toString());
    } catch (e) {
      log('BooksRepository createBook Error: $e');
    }
  }

  @override
  Future<void> deleteBook(Book book) async {
    try {
      log('Delete book ${book.name}');
      final response = await dio.delete(
        '$url${book.id}',
      );
      log(json.encode(response.data));
    } catch (e) {
      log('BooksRepository deleteBook Error: $e');
    }
  }

  @override
  Future<List<Book>> getBooks() async {
    try {
      log('Donwload books');
      final response = await dio.get(url);
      final b = response.data;
      final b1 = b['books'];
      // Iterable l = json.decode(response.data['books']);
      List<Book> books =
          List<Book>.from(b1.map((model) => Book.fromJson(model)));
      // add(UpdateBooks(books: books));
      log('Books installed');
      content.add(books);
      return books;
    } catch (e) {
      log('BooksBloc getBooks $e');
      return [];
    }
  }

  @override
  Future<void> putBook(Book book) async {
    try {
      log('Return book ${book.name}');
      final response = await dio.put(
        '$url${book.id}',
        data: json.encode(book.toJson()),
      );
      log(json.encode(response.data));
    } catch (e) {
      log('BooksRepository returnBook Error: $e');
    }
  }
}
