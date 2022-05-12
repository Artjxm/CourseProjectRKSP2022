part of 'books_bloc.dart';

abstract class BooksState {
  const BooksState();
}

class BooksLoading extends BooksState {}

class BooksLoaded extends BooksState {
  const BooksLoaded({
    required this.books,
  });

  final List<Book> books;
}
