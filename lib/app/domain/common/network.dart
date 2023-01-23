import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'either.dart';
import 'error.dart';

class Network {
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _apiKey = '4662e7a7fe13c9d91c80552e10a09dc1';

  static Future<http.Response> getRequest({
    required String endpoint,
    Map<String, String>? headers,
  }) {
    return http.get(
      Uri.parse('$_baseUrl$endpoint?api_key=$_apiKey'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        ...?headers,
      },
    );
  }

  static Future<http.Response> postRequest({
    required String endpoint,
    Map<String, String>? headers,
    Object? body,
  }) {
    return http.post(
      Uri.parse('$_baseUrl$endpoint?api_key=$_apiKey'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        ...?headers
      },
      body: jsonEncode(body),
    );
  }
}

Future<Either<Failure, Map<String, dynamic>>> safeApiCall(
  Future<http.Response> request,
) async {
  try {
    final response = await request;
    if (response.statusCode == HttpStatus.ok) {
      final jsonMap = Map<String, dynamic>.from(jsonDecode(response.body));
      return Either.right(jsonMap);
    } else {
      return Either.left(handleHttpError(response.statusCode));
    }
  } catch (e) {
    if (e is SocketException) {
      return Either.left(Failure.connectivity);
    }
    return Either.left(Failure.unknown);
  }
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
