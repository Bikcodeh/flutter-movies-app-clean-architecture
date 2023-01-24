class SessionWithLoginRequest {
  final String username;
  final String password;
  final String requestToken;

  SessionWithLoginRequest({
    required this.username,
    required this.password,
    required this.requestToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
  }
}
