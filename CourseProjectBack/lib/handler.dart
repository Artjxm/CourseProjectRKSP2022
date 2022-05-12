import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';

import 'book.dart';
import 'books_repo.dart';

part 'handler.g.dart'; // generated with 'pub run build_runner build'

class BookService {
//   'Access-Control-Allow-Methods':  // If needed
// 'Access-Control-Allow-Headers': 'X-Requested-With,content-type' // If needed
// 'Access-Control-Allow-Credentials': true // If  needed

  const BookService(this.repo);

  static const overrideHeaders = {
    ACCESS_CONTROL_ALLOW_ORIGIN: '*',
    'Content-Type': 'application/json;charset=utf-8',
    ACCESS_CONTROL_ALLOW_METHODS: 'GET, POST, OPTIONS, PUT, PATCH, DELETE',
    ACCESS_CONTROL_ALLOW_CREDENTIALS: 'true',
    ACCESS_CONTROL_ALLOW_HEADERS: "*",
    ACCESS_CONTROL_MAX_AGE: '86400',
  };

  static const String urlName = 'books';

  final BooksRepo repo;

  @Route.get('/$urlName/')
  Future<Response> listBooks(Request request) async {
    final a = jsonEncode({'books': repo.getAll()});
    return Response.ok(a, headers: overrideHeaders);
  }

  @Route.get('/$urlName/<bookId>')
  Future<Response> fetchBook(Request request, String bookId) async {
    final number = int.tryParse(bookId);
    if (number == null) {
      return Response.notFound(
        json.encode({
          'res': 'fail',
          'reason': 'Bad bookID',
        }),
        headers: overrideHeaders,
      );
    } else {
      final res = repo.getOne(number);
      if (res == null) {
        return Response.notFound(
          json.encode({
            'res': 'fail',
            'reason': 'Nothing found by id = $number',
          }),
          headers: overrideHeaders,
        );
      } else {
        return Response.ok(
          json.encode({'res': 'success'}),
          headers: overrideHeaders,
        );
      }
    }
  }

  @Route.post('/$urlName/')
  Future<Response> createBook(Request request) async {
    try {
      final data = await request.readAsString();
      final book = Book.fromJson(json.decode(data));
      repo.create(book);
      return Response.ok(
        json.encode({
          'res': 'success',
          'data': data,
        }),
        headers: overrideHeaders,
      );
    } catch (e) {
      print(e.toString());
      return Response.internalServerError(
        body: json.encode({
          'res': 'fail',
          'reason': 'Book was not created.',
        }),
        headers: overrideHeaders,
      );
    }
  }

  @Route.put('/$urlName/<bookId>')
  Future<Response> updateBook(Request request, String bookId) async {
    try {
      final data = await request.readAsString();
      final book = Book.fromJson(json.decode(data));
      // final number = int.tryParse(bookId);

      repo.update(book);
      return Response.ok(
        json.encode({'ID': book.id.toString(), 'data': data}),
        headers: overrideHeaders,
      );
    } catch (e) {
      print(e.toString());
      return Response.internalServerError(
        body: json.encode({'res': 'fail', 'reason': 'Book was not updated.'}),
        headers: overrideHeaders,
      );
    }
  }

  @Route.delete('/$urlName/<bookId>')
  Future<Response> deleteBook(Request request, String bookId) async {
    final number = int.tryParse(bookId);
    if (number == null) {
      return Response.notFound(
        json.encode({
          'res': 'fail',
          'reason': 'Bad bookID',
        }),
        headers: overrideHeaders,
      );
    } else {
      repo.delete(number);
      return Response.ok(
        json.encode({
          'res': 'fail',
          'reason': 'Book was deleted',
        }),
        headers: overrideHeaders,
      );
    }
  }

  // Create router using the generate function defined in 'userservice.g.dart'.
  Router get router => _$BookServiceRouter(this);
}
