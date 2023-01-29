import 'package:freezed_annotation/freezed_annotation.dart';

import 'http/http_failure.dart';

part 'sign_in_failure.freezed.dart';

@freezed
class SignInFailure with _$SignInFailure {
  factory SignInFailure.notVerified() = SignInNotVerified;
  factory SignInFailure.httpFailure(HttpFailure httpFailure) =
      SignInHttpFailure;
}

SignInFailure handleStatusCodeError({
  int? statusCode,
  required HttpFailure httpFailure,
}) {
  late SignInFailure failure;
  if (statusCode == 32) {
    failure = SignInFailure.notVerified();
  } else {
    failure = SignInFailure.httpFailure(httpFailure);
  }
  return failure;
}
