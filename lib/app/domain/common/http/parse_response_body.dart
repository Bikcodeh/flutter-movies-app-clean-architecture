part of 'network.dart';

dynamic _parseResponseBody(String responseBody) {
  try {
    return jsonDecode(responseBody);
  } catch (_) {
    return responseBody;
  }
}
