import '../../../domain/common/either.dart';
import '../../../domain/common/error.dart';
import '../../../domain/common/network.dart';
import 'body_request/session_with_login_request.dart';

class AuthenticationApi {
  final Http _http;

  AuthenticationApi(this._http);

  Future<Either<Failure, String>> createRequestToken() async {
    final result = await _http.request(
      '/authentication/token/new',
    );
    return result.fold<Either<Failure, String>>((failure) {
      return Either.left(failure);
    }, (jsonMap) {
      return Either.right(jsonMap['request_token'] as String);
    });
  }

  Future<Either<Failure, String>> createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final result = await _http.request(
      '/authentication/token/validate_with_login',
      body: SessionWithLoginRequest(
        username: username,
        password: password,
        requestToken: requestToken,
      ),
      method: HttpMethod.post,
    );
    final data = result.fold<Either<Failure, String>>(
      (failure) => Either.left(failure),
      (jsonMap) => Either.right(jsonMap['request_token']),
    );
    return data;
  }

  Future<Either<Failure, String>> createSession(String token) async {
    final result = await _http.request(
      '/authentication/session/new',
      body: {
        'request_token': token,
      },
      method: HttpMethod.post,
    );
    return result.fold(
      (failure) => Either.left(failure),
      (jsonMap) => Either.right(jsonMap['session_id']),
    );
  }
}
