import 'dart:async';

import '../../../../domain/repository/authentication_repository.dart';
import '../../../global/base/state_notifier.dart';
import 'sign_in_state.dart';

class SignInController extends StateNotifier<SignInState> {
  bool _mounted = true;
  final AuthenticationRepository authenticationRepository;

  SignInController(super.state, {required this.authenticationRepository});

  @override
  bool get mounted => _mounted;

  void onUsernameChange(String text) {
    update(state.copy(username: text.trim()));
  }

  void onPasswordChange(String text) {
    update(state.copy(password: text.replaceAll(' ', '')));
  }

  Future<void> submit() async {
    update(state.copy(fetching: true, errorMessage: null, success: false));
    final result = await authenticationRepository.signIn(
      state.username,
      state.password,
    );
    result.fold((failure) {
      update(
        state.copy(
          fetching: false,
          errorMessage: failure.message,
          success: false,
          user: null,
        ),
      );
    }, (user) {
      update(
        state.copy(
          fetching: false,
          errorMessage: null,
          success: true,
          user: user,
        ),
      );
    });
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
