import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/common/either.dart';
import '../../domain/common/error.dart';
import '../../domain/models/user.dart';
import '../../domain/repository/authentication_repository.dart';
import '../service/remote/authentication_api.dart';

const _key = 'session_id';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FlutterSecureStorage _flutterSecureStorage;
  final AuthenticationApi _authenticationApi;

  AuthenticationRepositoryImpl(
    this._flutterSecureStorage,
    this._authenticationApi,
  );

  @override
  Future<User?> getUserData() => Future.value(null);

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _flutterSecureStorage.read(key: _key);
    return sessionId != null;
  }

  @override
  Future<Either<Failure, User>> signIn(
    String username,
    String password,
  ) async {
    final data = await _authenticationApi.createRequestToken();

    return data.fold((failure) async {
      return Either.left(failure);
    }, (token) async {
      final result = await _authenticationApi.createSessionWithLogin(
        username: username,
        password: password,
        requestToken: token,
      );
      return result.fold(
        (failure) async {
          return Either.left(failure);
        },
        (requestToken) async {
          final response = await _authenticationApi.createSession(requestToken);
          return response.fold(
            (fail) async => Either.left(fail),
            (sessionId) async {
              await _flutterSecureStorage.write(key: _key, value: sessionId);
              return Either.right(
                User(),
              );
            },
          );
        },
      );
    });
  }

  @override
  void signOut() async {
    await _flutterSecureStorage.delete(key: _key);
  }
}
