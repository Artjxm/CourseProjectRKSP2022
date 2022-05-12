import 'package:books_front/features/books/domain/entities/book.dart';
import 'package:books_front/features/books/presentation/bloc/books_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditCountDialog extends StatelessWidget {
  EditCountDialog({
    Key? key,
    required this.book,
  })  : title = TextEditingController(text: book.name),
        author = TextEditingController(text: book.author),
        image = TextEditingController(text: book.image),
        count = TextEditingController(text: book.count.toString()),
        super(key: key);

  final TextEditingController title;
  final TextEditingController author;
  final TextEditingController image;
  final TextEditingController count;
  final _formKey = GlobalKey<FormState>();

  final Book book;

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
                'Форма изменения книги',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    buildField(title, 'Название книги'),
                    buildField(author, 'Автор'),
                    buildField(image, 'URL обложки'),
                    buildField(count, 'Кол-во книг', true),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                child: TextButton(
                  child: const Text('Изменить книгу'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      BlocProvider.of<BooksBloc>(context).add(
                        PutBook(
                          book: book.copyWith(
                            name: title.text,
                            author: author.text,
                            image: image.text,
                            count: int.parse(count.text),
                          ),
                        ),
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

  Widget buildField(TextEditingController controller, String hint,
      [bool onlyInt = false]) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 420),
        child: TextFormField(
          controller: controller,
          validator: (value) {
            if (value != null) {
              if (value.isEmpty) {
                return 'Поле не может быть пустым';
              }
              if (onlyInt && int.tryParse(value) == null) {
                return 'Должно быть целым числом';
              }
            }
          },
          decoration: InputDecoration(hintText: hint),
        ),
      ),
    );
  }
}
