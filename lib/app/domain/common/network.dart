import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import 'either.dart';
import 'error.dart';

enum HttpMethod {
  get,
  post,
  patch,
  delete,
  put,
}

class Http {
  final String _baseUrl;
  final String _apiKey;
  final Client _client;

  Http({
    required String baseUrl,
    required String apiKey,
    required Client client,
  })  : _baseUrl = baseUrl,
        _apiKey = apiKey,
        _client = client;

  Future<Either<Failure, T>> request<T>(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    Object body = const {},
    bool useApiKey = true,
    required T Function(String responseBody) onSuccess,
  }) async {
    var logs = {
      'startTime': DateTime.now().toString(),
    };
    late StackTrace stackStrace;
    try {
      if (useApiKey) {
        queryParameters = {
          ...queryParameters,
          'api_key': _apiKey,
        };
      }
      Uri url = Uri.parse(
        path.startsWith('http') ? path : '$_baseUrl$path',
      );

      if (queryParameters.isNotEmpty) {
        url = url.replace(queryParameters: queryParameters);
      }

      headers = {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        ...headers,
      };
      final bodyString = jsonEncode(body);
      logs = {
        ...logs,
        'url': url.toString(),
        'body': body.toString(),
        'queryParameters': queryParameters.toString(),
        'headers': headers.toString(),
        'method': method.toString()
      };
      late final Response response;
      switch (method) {
        case HttpMethod.get:
          response = await _client.get(url);
          break;
        case HttpMethod.post:
          response = await _client.post(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.patch:
          response = await _client.patch(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.delete:
          response = await _client.delete(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
        case HttpMethod.put:
          response = await _client.put(
            url,
            headers: headers,
            body: bodyString,
          );
          break;
      }
      logs = {
        ...logs,
        'statusCode': response.statusCode.toString(),
      };
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Either.right(onSuccess(response.body));
      } else {
        return Either.left(handleHttpError(response.statusCode));
      }
    } catch (e, s) {
      stackStrace = s;
      logs = {
        ...logs,
        'exception': e.runtimeType.toString(),
      };
      if (e is SocketException || e is ClientException) {
        logs = {
          ...logs,
          'exception': 'Network exception',
        };
        return Either.left(Failure.connectivity);
      }
      return Either.left(Failure.unknown);
    } finally {
      logs = {
        ...logs,
        'endTime': DateTime.now().toString(),
      };
      if (kDebugMode) {
        log(
          '''

🔥------------------------------------------------------
    ${const JsonEncoder.withIndent(' ').convert(logs)}
🔥------------------------------------------------------
''',
          stackTrace: stackStrace,
        );
      }
    }
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
