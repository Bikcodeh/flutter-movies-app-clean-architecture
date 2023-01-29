import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_failure.freezed.dart';

@freezed
class HttpFailure with _$HttpFailure {
  const factory HttpFailure.notFound() = HttpFailureNotFound;
  const factory HttpFailure.unauthorized(int? statusCode) =
      HttpFailureUnauthorized;
  const factory HttpFailure.unknown() = Unknown;
  const factory HttpFailure.connectivity() = HttpFailureConnectivity;
  const factory HttpFailure.server() = HttpFailureServer;
}

HttpFailure handleHttpFailure(int httpErrorCode, dynamic data) {
  late HttpFailure failure;
  switch (httpErrorCode) {
    case HttpStatus.unauthorized:
      if (data is Map && (data)['status_code'] != '') {
        failure = HttpFailure.unauthorized(data['status_code'] as int);
      } else {
        failure = const HttpFailure.unauthorized(null);
      }
      break;
    case HttpStatus.internalServerError:
      failure = const HttpFailure.server();
      break;
    case HttpStatus.notFound:
      failure = const HttpFailure.notFound();
      break;
    default:
      failure = const HttpFailure.unknown();
      break;
  }
  return failure;
}
