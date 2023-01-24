import 'dart:convert';
import 'dart:io';

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

  Future<Either<Failure, Map<String, dynamic>>> request(
    String path, {
    HttpMethod method = HttpMethod.get,
    Map<String, String> headers = const {},
    Map<String, String> queryParameters = const {},
    Object body = const {},
    bool useApiKey = true,
  }) async {
    if (useApiKey) {
      queryParameters = {
        ...queryParameters,
        'api_key': _apiKey,
      };
    }
    late final Either<Failure, Map<String, dynamic>> result;
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
    switch (method) {
      case HttpMethod.get:
        result = await safeApiCall(_client.get(url));
        break;
      case HttpMethod.post:
        result = await safeApiCall(_client.post(
          url,
          headers: headers,
          body: bodyString,
        ));
        break;
      case HttpMethod.patch:
        result = await safeApiCall(_client.patch(
          url,
          headers: headers,
          body: bodyString,
        ));
        break;
      case HttpMethod.delete:
        result = await safeApiCall(_client.delete(
          url,
          headers: headers,
          body: bodyString,
        ));
        break;
      case HttpMethod.put:
        result = await safeApiCall(_client.put(
          url,
          headers: headers,
          body: bodyString,
        ));
        break;
    }
    return result;
  }
}

Future<Either<Failure, Map<String, dynamic>>> safeApiCall(
  Future<Response> request,
) async {
  try {
    final response = await request;
    if (response.statusCode >= HttpStatus.ok && response.statusCode < 300) {
      final jsonMap = Map<String, dynamic>.from(jsonDecode(response.body));
      return Either.right(jsonMap);
    } else {
      return Either.left(
        handleHttpError(response.statusCode),
      );
    }
  } catch (e) {
    if (e is SocketException || e is ClientException) {
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
