import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'either.dart';
import 'error.dart';

Future<Either<Failure, Map<String, dynamic>>> safeApiCall(
  Future<http.Response> request,
) async {
  try {
    final response = await request;
    if (response.statusCode == HttpStatus.ok) {
      final jsonMap = Map<String, dynamic>.from(jsonDecode(response.body));
      return Either.right(jsonMap);
    } else {
      return Either.left(Failure.http);
    }
  } catch (e) {
    return Either.left(Failure.unknown);
  }
}
