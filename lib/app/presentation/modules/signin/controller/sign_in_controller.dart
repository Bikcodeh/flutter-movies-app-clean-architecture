import 'package:flutter/foundation.dart';

class SignInController extends ChangeNotifier {
  String _username = '', _password = '';
  bool _fetching = false, _mounted = true;

  String get username => _username;
  String get password => _password;
  bool get fetching => _fetching;
  bool get mounted => _mounted;

  void onUsernameChange(String text) {
    _username = text.trim();
  }

  void onPasswordChange(String text) {
    _password = text.replaceAll(' ', '');
  }

  void setFetching(bool isFetching) {
    _fetching = isFetching;
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
