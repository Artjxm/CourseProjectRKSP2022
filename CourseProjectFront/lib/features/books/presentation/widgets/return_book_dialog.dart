import 'package:books_front/features/books/domain/entities/book.dart';
import 'package:books_front/features/books/presentation/bloc/books_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReturnBookDialog extends StatelessWidget {
  const ReturnBookDialog({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: ColoredBox(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Возврат книги',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: book.given.length,
                  itemBuilder: (context, index) => ReturnBookTile(
                    title: book.given[index],
                    onPressed: () {
                      final person = book.given[index];
                      final newGiven = book.given;
                      newGiven.remove(person);

                      BlocProvider.of<BooksBloc>(context).add(
                        PutBook(book: book.copyWith(given: newGiven)),
                      );

                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReturnBookTile extends StatelessWidget {
  const ReturnBookTile({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(title),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text('Вернуть'),
          ),
        ],
      ),
    );
  }
}
