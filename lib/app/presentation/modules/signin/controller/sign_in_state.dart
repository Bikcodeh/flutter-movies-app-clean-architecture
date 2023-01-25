import 'package:equatable/equatable.dart';

class SignInState implements Equatable {
  final String username, password;
  final String? errorMessage;
  final bool? success;
  final bool fetching;

  SignInState({
    this.username = '',
    this.password = '',
    this.fetching = false,
    this.errorMessage,
    this.success,
  });

  SignInState copy({
    String? username,
    String? password,
    bool? fetching,
    String? errorMessage,
    bool? success,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      fetching: fetching ?? this.fetching,
      errorMessage: errorMessage ?? this.errorMessage,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        fetching,
        success,
        errorMessage,
      ];
  @override
  bool? get stringify => true;
}
