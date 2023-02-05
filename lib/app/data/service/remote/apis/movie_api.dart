import '../../../../domain/common/either/either.dart';
import '../../../../domain/common/failure/http/http_failure.dart';
import '../../../../domain/common/typedef.dart';
import '../../../../domain/models/movie/movie.dart';
import '../../../../domain/models/performer/performer.dart';
import '../http/network.dart';

class MovieApi {
  final Http _http;

  MovieApi(this._http);

  Future<Either<HttpFailure, Movie>> getMovieById(int id) async {
    return await _http.request('/movie/$id',
        onSuccess: (json) => Movie.fromJson(json));
  }

  Future<Either<HttpFailure, List<Performer>>> getCastByMovie(
      int movieId) async {
    return await _http.request('/movie/$movieId/credits', onSuccess: (json) {
      final list = List<Json>.from(json['cast']);
      return list
          .where(
            (e) =>
                e['known_for_department'] == 'Acting' &&
                e['profile_path'] != null,
          )
          .map((e) => Performer.fromJson({...e, 'known_for': []}))
          .toList();
    });
  }
}
