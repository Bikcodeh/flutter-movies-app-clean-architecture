import 'dart:io';

enum Failure {
  notFound('Not found'),
  unauthorized('You are unauthorized.'),
  unknown('An unknown error ocurred.'),
  server('A server error ocurred.'),
  connectivity('Please check your internet connection');

  final String message;
  const Failure(this.message);
}

Failure handleHttpError(int httpErrorCode) {
  late Failure failure;
  switch (httpErrorCode) {
    case HttpStatus.unauthorized:
      failure = Failure.unauthorized;
      break;
    case HttpStatus.internalServerError:
      failure = Failure.server;
      break;
    case HttpStatus.notFound:
      failure = Failure.notFound;
      break;
    default:
      failure = Failure.unknown;
      break;
  }
  return failure;
}
