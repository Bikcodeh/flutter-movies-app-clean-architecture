import '../../../domain/common/http/network.dart';
import '../../../domain/models/user/user.dart';

class AccountApi {
  final Http _http;

  AccountApi(this._http);

  Future<User?> getAcccount(String sessiondId) async {
    final result = await _http.request(
      '/account',
      onSuccess: (responseBody) {
        return User(
          id: responseBody['id'],
          username: responseBody['username'],
        );
      },
      queryParameters: {
        'session_id': sessiondId,
      },
    );

    return result.fold((_) => null, (user) => user);
  }
}
