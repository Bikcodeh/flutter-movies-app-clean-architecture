import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../utils/constants.dart';

class AuthenticationApi {
  final Client _client;

  AuthenticationApi(this._client);

  Future<String?> createRequestToken() async {
    final response = await _client.get(
      Uri.parse(
          '${Constants.baseUrl}/authentication/token/new?api_key=${Constants.apiKey}'),
    );
    if (response.statusCode == HttpStatus.ok) {
      final json = Map<String, dynamic>.from(jsonDecode(response.body));
      return json['request_token'];
    }
    return null;
  }
}
