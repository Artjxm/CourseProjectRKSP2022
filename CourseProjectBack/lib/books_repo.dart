import 'package:hive/hive.dart';

import 'book.dart';

class BooksRepo {
  const BooksRepo({
    required this.box,
  });

  final Box<Book> box;

  List<Book> getAll() {
    final List<Book> res = [];
    for (var key in box.keys) {
      final book = box.get(key)!;
      // print('key: $key id: ${book.id} name: ${book.name} count: ${book.count}');
      res.add(book);
    }
    return res;
  }

  void create(Book book) {
    if (box.length == 0) {
      box.add(book.copyWith(id: 0));
    } else {
      final id = (box.keys.last as int) + 1;
      box.put(id, book.copyWith(id: id));
    }
    box.flush();
  }

  Book? getOne(int id) {
    return box.get(id);
  }

  void update(Book book) {
    box.put(book.id, book);
    box.flush();
  }

  void delete(int id) {
    box.delete(id);
    box.flush();
  }
}
