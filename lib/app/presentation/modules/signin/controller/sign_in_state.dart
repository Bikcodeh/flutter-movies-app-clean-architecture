import 'package:equatable/equatable.dart';

import '../../../../domain/models/user.dart';

class SignInState implements Equatable {
  final String username, password;
  final String? errorMessage;
  final bool? success;
  final bool fetching;
  final User? user;

  SignInState(
      {this.username = '',
      this.password = '',
      this.fetching = false,
      this.errorMessage,
      this.success,
      this.user});

  SignInState copy({
    String? username,
    String? password,
    bool? fetching,
    String? errorMessage,
    bool? success,
    User? user,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      fetching: fetching ?? this.fetching,
      errorMessage: errorMessage ?? this.errorMessage,
      success: success ?? this.success,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        fetching,
        success,
        errorMessage,
        user,
      ];
  @override
  bool? get stringify => true;
}
