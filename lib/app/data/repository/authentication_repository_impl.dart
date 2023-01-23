import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/common/either.dart';
import '../../domain/common/error.dart';
import '../../domain/models/user.dart';
import '../../domain/repository/authentication_repository.dart';

const _key = 'session_id';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FlutterSecureStorage _flutterSecureStorage;

  AuthenticationRepositoryImpl(this._flutterSecureStorage);

  @override
  Future<User?> getUserData() => Future.value(User());

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
    await Future.delayed(
      const Duration(seconds: 2),
    );
    if (username != 'test' && password != '12345') {
      return Either.left(Failure.notFound);
    }

    await _flutterSecureStorage.write(key: _key, value: 'session');
    return Either.right(User());
  }
}
