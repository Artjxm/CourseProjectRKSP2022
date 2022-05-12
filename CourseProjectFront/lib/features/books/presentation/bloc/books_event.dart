part of 'books_bloc.dart';

abstract class BooksEvent {
  const BooksEvent();
}

class UpdateBooks extends BooksEvent {
  const UpdateBooks({
    required this.books,
  });

  final List<Book> books;
}

class BookAction extends BooksEvent {
  const BookAction({
    required this.book,
  });

  final Book book;
}

class DeleteBook extends BookAction {
  const DeleteBook({
    required Book book,
  }) : super(book: book);
}

class CreateBook extends BookAction {
  const CreateBook({
    required Book book,
  }) : super(book: book);
}

class PutBook extends BookAction {
  const PutBook({
    required Book book,
  }) : super(book: book);
}
