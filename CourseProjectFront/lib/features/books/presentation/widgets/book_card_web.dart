import 'dart:developer';

import 'package:books_front/features/books/domain/entities/book.dart';
import 'package:books_front/features/books/presentation/bloc/books_bloc.dart';
import 'package:books_front/features/books/presentation/widgets/confirm_delete_dialog.dart';
import 'package:books_front/features/books/presentation/widgets/edit_count_dialog.dart';
import 'package:books_front/features/books/presentation/widgets/give_book_dialog.dart';
import 'package:books_front/features/books/presentation/widgets/return_book_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class BookCardWeb extends StatelessWidget {
  final BoxConstraints constraints;
  const BookCardWeb({
    Key? key,
    required this.book,
    required this.constraints,
  }) : super(key: key);

  final Book book;

  double getImageWidth(BuildContext context) {
    if (constraints.maxWidth > 1700) {
      return MediaQuery.of(context).size.width / 10;
    } else if (constraints.maxWidth > 1100) {
      return MediaQuery.of(context).size.width / 9;
    } else if (constraints.maxWidth > 740) {
      return MediaQuery.of(context).size.width / 6;
    } else {
      return MediaQuery.of(context).size.width / 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.network(
                book.image,
                width: getImageWidth(context),
              ),
              const Padding(padding: EdgeInsets.only(left: 24)),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // color: Colors.red,
                      constraints:
                          const BoxConstraints(minWidth: 50, maxWidth: 250),
                      child: Text(
                        book.name,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    // const Padding(padding: EdgeInsets.only(top: 8)),
                    Text(
                      'Автор: ${book.author}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    StatusBundle(
                      book: book,
                    ),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GiveBookButton(
                          book: book,
                        ),
                        RetrunBookButton(
                          book: book,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 40,
          // color: Colors.red,
          // padding: EdgeInsets.only(right: 16),
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: [
                IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => ConfirmDeleteDialog(book: book),
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => EditCountDialog(book: book),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class StatusBundle extends StatelessWidget {
  const StatusBundle({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  String get text {
    final booksLeft = book.count - book.given.length;
    if (booksLeft > 0) {
      return 'Доступно: $booksLeft';
    } else {
      return 'Все книги выданы';
    }
  }

  Color get background {
    final booksLeft = book.count - book.given.length;
    if (booksLeft > 0) {
      return Colors.green.shade700;
    } else {
      return Colors.red.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

// class ActionButton extends StatelessWidget {
//   const ActionButton({
//     Key? key,
//     required this.book,
//   }) : super(key: key);

//   final Book book;

//   @override
//   Widget build(BuildContext context) {
//     final booksLeft = book.count - book.given.length;

//     if (booksLeft > 0) {
//       return GiveBookButton(
//         book: book,
//       );
//     } else {
//       return RetrunBookButton(
//         book: book,
//       );
//     }
//   }
// }

class RetrunBookButton extends StatelessWidget {
  const RetrunBookButton({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    if (book.given.isNotEmpty) {
      return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ReturnBookDialog(book: book),
          );
        },
        child: const Text('Вернуть книгу'),
      );
    } else {
      return const SizedBox();
    }
  }
}

class GiveBookButton extends StatelessWidget {
  const GiveBookButton({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    final booksLeft = book.count - book.given.length;
    if (booksLeft > 0) {
      return TextButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => GiveBookDialog(book: book),
          );
        },
        child: const Text('Выдать книгу'),
      );
    } else {
      return const SizedBox();
    }
  }
}
