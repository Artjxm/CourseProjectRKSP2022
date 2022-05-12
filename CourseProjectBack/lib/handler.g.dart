// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'handler.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$BookServiceRouter(BookService service) {
  final router = Router();
  router.add('GET', r'/books/', service.listBooks);
  router.add('GET', r'/books/<bookId>', service.fetchBook);
  router.add('POST', r'/books/', service.createBook);
  router.add('PUT', r'/books/<bookId>', service.updateBook);
  router.add('DELETE', r'/books/<bookId>', service.deleteBook);
  return router;
}
