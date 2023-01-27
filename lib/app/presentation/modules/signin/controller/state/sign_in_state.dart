import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/user/user.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState({
    @Default('') String username,
    @Default('') String password,
    @Default(false) bool fetching,
    String? errorMessage,
    @Default(false) bool success,
    User? user,
  }) = _SignInState;
}
