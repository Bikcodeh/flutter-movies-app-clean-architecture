import 'package:equatable/equatable.dart';

class SignInState implements Equatable {
  final String username, password;
  final bool fetching;

  SignInState({
    this.username = '',
    this.password = '',
    this.fetching = false,
  });

  SignInState copy({
    String? username,
    String? password,
    bool? fetching,
  }) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      fetching: fetching ?? this.fetching,
    );
  }

  @override
  List<Object?> get props => [
        username,
        password,
        fetching,
      ];
  @override
  bool? get stringify => true;
}
