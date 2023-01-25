import 'package:flutter/foundation.dart';

import 'sign_in_state.dart';

class SignInController extends ChangeNotifier {
  SignInState signInState = SignInState();
  bool _mounted = true;

  bool get mounted => _mounted;

  void onUsernameChange(String text) {
    signInState = signInState.copy(username: text.trim());
  }

  void onPasswordChange(String text) {
    signInState = signInState.copy(password: text.replaceAll(' ', ''));
  }

  void setFetching(bool isFetching) {
    signInState = signInState.copy(fetching: isFetching);
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
