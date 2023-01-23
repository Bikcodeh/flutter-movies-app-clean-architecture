import 'package:http/http.dart';

import '../../../domain/common/network.dart';
import '../../utils/constants.dart';

class AuthenticationApi {
  final Client _client;

  AuthenticationApi(this._client);

  Future<String?> createRequestToken() async {
    final request = _client.get(
      Uri.parse(
          '${Constants.baseUrl}/authentication/token/new?api_key=${Constants.apiKey}'),
    );
    final result = await safeApiCall(request);
    return result.fold<String?>((_) {
      return null;
    }, (jsonMap) {
      return jsonMap['request_token'];
    });
  }
}
