import '../../../../domain/common/either/either.dart';
import '../../../../domain/common/failure/http/http_failure.dart';
import '../../../../domain/common/failure/sign_in_failure.dart';
import '../body_request/session_with_login_request.dart';
import '../http/network.dart';

class AuthenticationApi {
  final Http _http;

  AuthenticationApi(this._http);

  Future<Either<HttpFailure, String>> createRequestToken() async {
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

  Future<Either<SignInFailure, String>> createSessionWithLogin({
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

    final data = result.when<Either<SignInFailure, String>>(
      left: (failure) {
        if (failure is HttpFailureUnauthorized) {
          final error = handleStatusCodeError(
            statusCode: failure.statusCode,
            httpFailure: failure,
          );
          return Either.left(error);
        }
        return Either.left(SignInFailure.httpFailure(failure));
      },
      right: (token) {
        return Either.right(token);
      },
    );
    return data;
  }

  Future<Either<HttpFailure, String>> createSession(String token) async {
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
