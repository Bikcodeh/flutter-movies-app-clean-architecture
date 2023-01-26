import '../../domain/models/user.dart';
import '../../domain/repository/account_repository.dart';
import '../service/local/session_service.dart';
import '../service/remote/account_api.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountApi _accountApi;
  final SessionService _sessionService;

  AccountRepositoryImpl(this._accountApi, this._sessionService);

  @override
  Future<User?> getUserData() async {
    final sessionId = await _sessionService.getSessionId();
    return _accountApi.getAcccount(sessionId ?? '');
  }
}
