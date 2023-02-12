import '../../domain/common/either/either.dart';
import '../../domain/common/failure/http/http_failure.dart';
import '../../domain/models/media/media.dart';
import '../../domain/models/user/user.dart';
import '../../domain/repository/account_repository.dart';
import '../service/local/session_service.dart';
import '../service/remote/apis/account_api.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountApi _accountApi;
  final SessionService _sessionService;

  AccountRepositoryImpl(this._accountApi, this._sessionService);

  @override
  Future<User?> getUserData() async {
    final sessionId = await _sessionService.getSessionId();
    final user = await _accountApi.getAcccount(sessionId ?? '');

    if (user != null) {
      _sessionService.saveAccountId(user.id.toString());
    }

    return user;
  }

  @override
  Future<Either<HttpFailure, Map<int, Media>>> getFavorites(
      MediaType mediaType) {
    return _accountApi.getFavorites(mediaType);
  }

  @override
  Future<Either<HttpFailure, void>> markAsFavorite(
      {required int mediaId,
      required MediaType mediaType,
      required bool favorite}) {
    return _accountApi.markAsFavorite(
        mediaId: mediaId, mediaType: mediaType, favorite: favorite);
  }
}
