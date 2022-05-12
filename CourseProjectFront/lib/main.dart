import 'package:books_front/features/books/presentation/bloc/books_bloc.dart';
import 'package:books_front/features/books/presentation/widgets/add_book_dialog.dart';
import 'package:books_front/features/books/presentation/widgets/book_card_web.dart';
import 'package:books_front/features/login/login_page.dart';
import 'package:books_front/service_locator.dart' as sl;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

bool isProd = true;

void main() {
  sl.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BooksBloc>(
          create: (_) => sl.getIt<BooksBloc>(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Library',
        home: LoginPage(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Панель администратора библотеки'),
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AddBookDialog(),
              );
            },
            child: const Text(
              'Добавить книгу',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<BooksBloc, BooksState>(
        builder: (context, state) {
          if (state is BooksLoaded) {
            return LayoutBuilder(
              builder: (context, constraints) {
                getCount(BoxConstraints constraints) {
                  if (constraints.maxWidth > 1700) {
                    return 4;
                  } else if (constraints.maxWidth > 1100) {
                    return 3;
                  } else if (constraints.maxWidth > 800) {
                    return 2;
                  } else {
                    return 1;
                  }
                }

                return GridView.count(
                  crossAxisCount: getCount(constraints),
                  childAspectRatio: (2 / 1),
                  controller: ScrollController(keepScrollOffset: false),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: List<Widget>.generate(
                    state.books.length,
                    (i) => Card(
                      margin: const EdgeInsets.all(5),
                      child: BookCardWeb(
                        book: state.books[i],
                        constraints: constraints,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
