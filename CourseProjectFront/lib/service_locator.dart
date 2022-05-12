import 'package:books_front/features/books/domain/repositories/books_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/books/presentation/bloc/books_bloc.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<Dio>(Dio());

  getIt.registerSingleton<BooksRepository>(
    BooksRepositoryImpl(
      dio: getIt<Dio>(),
    ),
  );

  getIt.registerFactory<BooksBloc>(
    () => BooksBloc(
      repository: getIt<BooksRepository>(),
    ),
  );
}
