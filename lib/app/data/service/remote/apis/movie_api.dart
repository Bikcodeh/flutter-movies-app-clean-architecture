import '../../../../domain/common/either/either.dart';
import '../../../../domain/common/failure/http/http_failure.dart';
import '../../../../domain/models/movie/movie.dart';
import '../http/network.dart';

class MovieApi {
  final Http _http;

  MovieApi(this._http);

  Future<Either<HttpFailure, Movie>> getMovieById(int id) async {
    return await _http.request('/movie/$id',
        onSuccess: (json) => Movie.fromJson(json));
  }
}
