class SignInState {
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
}
