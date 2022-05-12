import 'package:bloc/bloc.dart';
import 'package:books_front/features/books/domain/entities/book.dart';
import 'package:books_front/features/books/domain/repositories/books_repo.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final BooksRepository repository;
  BooksBloc({
    required this.repository,
  }) : super(BooksLoading()) {
    on<UpdateBooks>((event, emit) {
      emit(BooksLoaded(books: event.books));
    });
    on<BookAction>(_onBookAction);

    repository.content.stream.listen((event) {
      add(UpdateBooks(books: event));
    });
    repository.getBooks();
  }

  Future<void> _onBookAction(
    BookAction event,
    Emitter<BooksState> emitter,
  ) async {
    switch (event.runtimeType) {
      case PutBook:
        await repository.putBook(event.book);
        break;
      case CreateBook:
        await repository.createBook(event.book);
        break;
      case DeleteBook:
        await repository.deleteBook(event.book);
        break;
    }
    emitter(BooksLoading());

    final books = await repository.getBooks();
    add(UpdateBooks(books: books));
  }
}
