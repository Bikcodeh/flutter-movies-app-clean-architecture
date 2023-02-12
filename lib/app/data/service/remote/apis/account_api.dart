import '../../../../domain/common/either/either.dart';
import '../../../../domain/common/failure/http/http_failure.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/models/user/user.dart';
import '../../local/session_service.dart';
import '../http/network.dart';

class AccountApi {
  final Http _http;
  final SessionService _service;

  AccountApi(this._http, this._service);

  Future<User?> getAcccount(String sessiondId) async {
    final result = await _http.request(
      '/account',
      onSuccess: (responseBody) {
        return User(
          id: responseBody['id'],
          username: responseBody['username'],
        );
      },
      queryParameters: {
        'session_id': sessiondId,
      },
    );
    return result.when(left: (_) => null, right: (user) => user);
  }

  Future<Either<HttpFailure, Map<int, Media>>> getFavorites(
    MediaType mediaType,
  ) async {
    final sessionId = await _service.getSessionId();
    final accountId = await _service.getAccountId();
    return _http.request(
      '/account/$accountId/favorite/${mediaType.name == 'movie' ? 'movies' : 'tv'}',
      queryParameters: {'session_id': sessionId ?? ''},
      onSuccess: (json) {
        final list = json['results'] as List;
        final iterable = list.map((e) {
          final media = Media.fromJson({
            ...e,
            'media_type': mediaType.name,
          });
          return MapEntry(media.id, media);
        });
        final map = <int, Media>{};
        map.addEntries(iterable);
        return map;
      },
    );
  }
}
