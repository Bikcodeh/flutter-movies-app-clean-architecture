import '../../../global/base/state_notifier.dart';
import 'sign_in_state.dart';

class SignInController extends StateNotifier<SignInState> {
  bool _mounted = true;

  SignInController(super.state);

  @override
  bool get mounted => _mounted;

  void onUsernameChange(String text) {
    state = state.copy(username: text.trim());
  }

  void onPasswordChange(String text) {
    state = state.copy(password: text.replaceAll(' ', ''));
  }

  void setFetching(bool isFetching) {
    state = state.copy(fetching: isFetching);
    notifyListeners();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
