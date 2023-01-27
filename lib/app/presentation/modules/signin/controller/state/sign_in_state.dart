import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/user/user.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    required String username,
    required String password,
    required bool fetching,
    String? errorMessage,
    required bool success,
    User? user,
  }) = _SignInState;
}
