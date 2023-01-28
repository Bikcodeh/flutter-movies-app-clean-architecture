import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
class Failure with _$Failure {
  factory Failure.notFound() = NotFound;
  factory Failure.unauthorized() = Unauthorized;
  factory Failure.unknown() = Unknown;
  factory Failure.connectivity() = Connectivity;
  factory Failure.server() = Server;
}

Failure handleHttpError(int httpErrorCode) {
  late Failure failure;
  switch (httpErrorCode) {
    case HttpStatus.unauthorized:
      failure = Failure.unauthorized();
      break;
    case HttpStatus.internalServerError:
      failure = Failure.server();
      break;
    case HttpStatus.notFound:
      failure = Failure.notFound();
      break;
    default:
      failure = Failure.unknown();
      break;
  }
  return failure;
}
