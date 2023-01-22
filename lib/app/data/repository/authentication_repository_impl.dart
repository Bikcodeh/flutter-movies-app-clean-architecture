import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../domain/models/user.dart';
import '../../domain/repository/authentication_repository.dart';

const _key = 'session_id';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final FlutterSecureStorage _flutterSecureStorage;

  AuthenticationRepositoryImpl(this._flutterSecureStorage);

  @override
  Future<User?> getUserData() => Future.value(null);

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _flutterSecureStorage.read(key: _key);
    return sessionId != null;
  }
}
