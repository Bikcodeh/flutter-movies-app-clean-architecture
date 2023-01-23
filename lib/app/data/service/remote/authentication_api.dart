import '../../../domain/common/either.dart';
import '../../../domain/common/error.dart';
import '../../../domain/common/network.dart';
import 'body_request/session_with_login_request.dart';

class AuthenticationApi {
  Future<String?> createRequestToken() async {
    final request = Network.getRequest(endpoint: '/authentication/token/new');
    final result = await safeApiCall(request);
    return result.fold<String?>((_) {
      return null;
    }, (jsonMap) {
      return jsonMap['request_token'];
    });
  }

  Future<Either<Failure, String>> createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final request = Network.postRequest(
      endpoint: '/authentication/token/validate_with_login',
      body: SessionWithLoginRequest(
        username: username,
        password: password,
        requestToken: requestToken,
      ).toJson(),
    );
    final result = await safeApiCall(request);
    final data = result.fold<Either<Failure, String>>(
      (failure) => Either.left(failure),
      (jsonMap) => Either.right(jsonMap['request_token']),
    );
    return data;
  }
}
