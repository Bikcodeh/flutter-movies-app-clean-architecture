import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'session_id';

class SessionService {
  final FlutterSecureStorage _flutterSecureStorage;

  SessionService(this._flutterSecureStorage);

  void saveSessionId(String sessionId) async {
    await _flutterSecureStorage.write(key: _key, value: sessionId);
  }

  Future<String?> getSessionId() async {
    return await _flutterSecureStorage.read(key: _key);
  }

  void clearSessionId() async {
    await _flutterSecureStorage.delete(key: _key);
  }
}
