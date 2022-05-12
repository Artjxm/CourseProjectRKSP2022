import 'package:books_front/features/books/domain/entities/book.dart';
import 'package:books_front/features/books/presentation/bloc/books_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final Book book;
  const ConfirmDeleteDialog({
    Key? key,
    required this.book,
  }) : super(key: key);

  Widget cancelButton(BuildContext context) {
    return TextButton(
      child: const Text("Отмена"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget deleteButton(BuildContext context) {
    return TextButton(
      child: const Text(
        "Удалить",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () {
        BlocProvider.of<BooksBloc>(context).add(DeleteBook(book: book));
        Navigator.pop(context);
      },
    );
  }

  Widget title(BuildContext context) {
    return Text(
      'Вы действительно хотите удалить ${book.name}?',
      style: Theme.of(context)
          .textTheme
          .subtitle1!
          .copyWith(fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title(context),
      actions: [
        cancelButton(context),
        deleteButton(context),
      ],
    );
  }
}
