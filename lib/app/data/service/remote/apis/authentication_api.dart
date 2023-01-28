import '../../../../domain/common/either/either.dart';
import '../../../../domain/common/failure/failure.dart';
import '../body_request/session_with_login_request.dart';
import '../http/network.dart';

class AuthenticationApi {
  final Http _http;

  AuthenticationApi(this._http);

  Future<Either<Failure, String>> createRequestToken() async {
    final result = await _http.request<String>('/authentication/token/new',
        onSuccess: ((responseBody) {
      final jsonMap = responseBody as Map;
      return jsonMap['request_token'];
    }));
    return result.when(left: (failure) {
      return Either.left(failure);
    }, right: (token) {
      return Either.right(token);
    });
  }

  Future<Either<Failure, String>> createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final body = SessionWithLoginRequest(
      username: username,
      password: password,
      requestToken: requestToken,
    );
    final result = await _http.request<String>(
      '/authentication/token/validate_with_login',
      body: body.toMap(),
      method: HttpMethod.post,
      onSuccess: (responseBody) {
        final jsonMap = responseBody as Map;
        return jsonMap['request_token'];
      },
    );
    final data = result.when<Either<Failure, String>>(
      left: (failure) => Either.left(failure),
      right: (token) => Either.right(token),
    );
    return data;
  }

  Future<Either<Failure, String>> createSession(String token) async {
    final result = await _http.request<String>('/authentication/session/new',
        body: {
          'request_token': token,
        },
        method: HttpMethod.post, onSuccess: ((responseBody) {
      final jsonMap = responseBody as Map;
      return jsonMap['session_id'];
    }));
    return result.when(
      left: (failure) => Either.left(failure),
      right: (sessionId) => Either.right(sessionId),
    );
  }
}
