import 'package:books_front/features/books/domain/entities/book.dart';
import 'package:books_front/features/books/presentation/bloc/books_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GiveBookDialog extends StatelessWidget {
  GiveBookDialog({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  final newOwnerController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: ColoredBox(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Форма выдачи книги',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 42, left: 16, right: 16),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: TextFormField(
                          controller: newOwnerController,
                          validator: (value) {
                            if (value != null) {
                              if (value.isEmpty) {
                                return 'Поле не может быть пустым';
                              }
                            }
                          },
                          decoration: const InputDecoration(hintText: 'Кому'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextButton(
                  child: const Text('Выдать'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newGiven = book.given;
                      newGiven.add(newOwnerController.text);

                      BlocProvider.of<BooksBloc>(context).add(
                        PutBook(book: book.copyWith(given: newGiven)),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
