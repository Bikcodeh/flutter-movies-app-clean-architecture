import 'dart:async';

import '../../../../domain/common/failure/sign_in_failure.dart';
import '../../../../domain/repository/authentication_repository.dart';
import '../../../global/base/state_notifier.dart';
import '../../../global/controllers/session_controller.dart';
import 'state/sign_in_state.dart';

class SignInController extends StateNotifier<SignInState> {
  bool _mounted = true;
  final AuthenticationRepository authenticationRepository;
  final SessionController sessionController;

  SignInController(
    super.state, {
    required this.sessionController,
    required this.authenticationRepository,
  });

  @override
  bool get mounted => _mounted;

  void onUsernameChange(String text) {
    update(state.copyWith(username: text.trim()));
  }

  void onPasswordChange(String text) {
    update(state.copyWith(password: text.replaceAll(' ', '')));
  }

  Future<void> submit() async {
    update(state.copyWith(fetching: true, errorMessage: null, success: false));
    final result = await authenticationRepository.signIn(
      state.username,
      state.password,
    );
    result.when(left: (failure) {
      update(
        state.copyWith(
          fetching: false,
          errorMessage: handleSignInErrors(failure),
          success: false,
          user: null,
        ),
      );
    }, right: (user) {
      sessionController.setUser(user);
      update(
        state.copyWith(
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

  String handleSignInErrors(SignInFailure failure) {
    return failure.when(
      notVerified: () {
        return 'Your email is not verified yet';
      },
      httpFailure: ((httpFailure) {
        return handleHttpError(httpFailure);
      }),
    );
  }
}
