import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'session_id';
const _accountIdKey = 'account_id';

class SessionService {
  final FlutterSecureStorage _flutterSecureStorage;

  SessionService(this._flutterSecureStorage);

  void saveSessionId(String sessionId) async {
    await _flutterSecureStorage.write(key: _key, value: sessionId);
  }

  void saveAccountId(String accountId) async {
    await _flutterSecureStorage.write(key: _accountIdKey, value: accountId);
  }

  Future<String?> getSessionId() {
    return _flutterSecureStorage.read(key: _key);
  }

  Future<String?> getAccountId() {
    return _flutterSecureStorage.read(key: _accountIdKey);
  }

  void clearSessionId() async {
    await _flutterSecureStorage.deleteAll();
  }
}
