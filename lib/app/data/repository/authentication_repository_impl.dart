import '../../domain/common/either/either.dart';
import '../../domain/common/failure/failure.dart';
import '../../domain/models/user/user.dart';
import '../../domain/repository/account_repository.dart';
import '../../domain/repository/authentication_repository.dart';
import '../service/local/session_service.dart';
import '../service/remote/apis/authentication_api.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationApi _authenticationApi;
  final SessionService _sessionService;
  final AccountRepository _accountRepository;

  AuthenticationRepositoryImpl(
    this._sessionService,
    this._authenticationApi,
    this._accountRepository,
  );

  @override
  Future<User?> getUserData() async {
    final user = await _accountRepository.getUserData();
    return user;
  }

  @override
  Future<bool> get isSignedIn async {
    final sessionId = await _sessionService.getSessionId();
    return sessionId != null;
  }

  @override
  Future<Either<Failure, User>> signIn(
    String username,
    String password,
  ) async {
    final data = await _authenticationApi.createRequestToken();

    return data.when(left: (failure) async {
      return Either.left(failure);
    }, right: (token) async {
      final result = await _authenticationApi.createSessionWithLogin(
        username: username,
        password: password,
        requestToken: token,
      );
      return result.when(
        left: (failure) async {
          return Either.left(failure);
        },
        right: (requestToken) async {
          final response = await _authenticationApi.createSession(requestToken);
          return response.when(
            left: (fail) async => Either.left(fail),
            right: (sessionId) async {
              _sessionService.saveSessionId(sessionId);
              final user = await _accountRepository.getUserData();
              if (user == null) {
                Either.left(Failure.notFound());
              }
              return Either.right(user!);
            },
          );
        },
      );
    });
  }

  @override
  void signOut() async {
    _sessionService.clearSessionId();
  }
}
