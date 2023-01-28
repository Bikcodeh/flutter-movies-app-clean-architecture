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
  factory Failure.notVerified() = NotVerified;
}

Failure handleHttpError(int httpErrorCode, dynamic data) {
  late Failure failure;
  switch (httpErrorCode) {
    case HttpStatus.unauthorized:
      if (data is Map && (data)['status_code'] == 32) {
        failure = Failure.notVerified();
      }
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
