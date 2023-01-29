import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../../../domain/common/either/either.dart';
import '../../../../domain/common/failure/http/http_failure.dart';

part 'parse_response_body.dart';
part 'print_logs.dart';

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

  Future<Either<HttpFailure, T>> request<T>(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    Map<String, dynamic> body = const {},
    bool useApiKey = true,
    required T Function(dynamic responseBody) onSuccess,
  }) async {
    var logs = {
      'startTime': DateTime.now().toString(),
    };
    StackTrace? stackStrace;
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
        'queryParameters': queryParameters.toString(),
        'headers': headers.toString(),
        'method': method.toString(),
        'body': body.toString(),
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
      final responseBody = _parseResponseBody(response.body);
      logs = {
        ...logs,
        'statusCode': response.statusCode.toString(),
        'responseBody': responseBody.toString(),
      };
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Either.right(onSuccess(responseBody));
      } else {
        return Either.left(
          handleHttpFailure(
            response.statusCode,
            responseBody,
          ),
        );
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
        return Either.left(const HttpFailure.connectivity());
      }
      return Either.left(const HttpFailure.unknown());
    } finally {
      logs = {
        ...logs,
        'endTime': DateTime.now().toString(),
      };
      printLogs(logs, stackStrace);
    }
  }
}
