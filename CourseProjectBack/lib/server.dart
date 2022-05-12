import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:shelf_router/shelf_router.dart';

class Server {
  const Server({
    required this.router,
    required this.port,
    required this.isProd,
  });

  static const corsHeaders1 = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, DELETE, OPTIONS, PUT',
    'Access-Control-Allow-Headers': '*',
  };

  final bool isProd;
  final int port;
  final Router router;

  Future<void> observeTheReality() async {
    // final _fixCORS = shelf.createMiddleware(responseHandler: _cors);
    final handler = const shelf.Pipeline()
        // .addMiddleware(_fixCORS)
        .addMiddleware(corsHeaders(headers: corsHeaders1))
        .addMiddleware(shelf.logRequests())
        .addHandler(router);
    var server =
        await shelf_io.serve(handler, isProd ? '0.0.0.0' : 'localhost', port);

    print(
        'Serving at http://${server.address.host}:${server.port} isProd:$isProd');
  }
}
