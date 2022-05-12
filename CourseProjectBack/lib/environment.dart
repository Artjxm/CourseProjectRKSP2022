import 'dart:io';

import 'package:args/args.dart';
import 'package:cursach_book_server/handler.dart';
import 'package:cursach_book_server/server.dart';
import 'package:hive/hive.dart';

import 'book.dart';
import 'books_repo.dart';

const bool IS_PROD = true;

class Environment {
  const Environment({
    required this.args,
  });

  final List<String> args;

  Future<void> spinTheWheelOfSamsara() async {
    Hive.init('./storages');
    Hive.registerAdapter(BookAdapter());
    Hive.registerAdapter(BookStatusAdapter());
    var booksBox = await Hive.openBox<Book>('books');

    var parser = ArgParser()..addOption('port', abbr: 'p');
    var result = parser.parse(args);

    var portStr = result['port'] ?? Platform.environment['PORT'] ?? '8080';
    var port = int.tryParse(portStr);
    // final bool isProd = false; //port != null;
    port ??= 8080;

    Server(
      router: BookService(
        BooksRepo(
          box: booksBox,
        ),
      ).router,
      isProd: IS_PROD,
      port: port,
    ).observeTheReality();
  }
}
