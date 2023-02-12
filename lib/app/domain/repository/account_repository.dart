import '../common/either/either.dart';
import '../common/failure/http/http_failure.dart';
import '../models/media/media.dart';
import '../models/user/user.dart';

abstract class AccountRepository {
  Future<User?> getUserData();
  Future<Either<HttpFailure, Map<int, Media>>> getFavorites(
    MediaType mediaType,
  );
  Future<Either<HttpFailure, void>> markAsFavorite({
    required int mediaId,
    required MediaType mediaType,
    required bool favorite,
  });
}
