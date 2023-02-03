import '../../domain/common/either/either.dart';
import '../../domain/common/failure/http/http_failure.dart';
import '../../domain/models/movie/movie.dart';
import '../../domain/repository/movie_repository.dart';
import '../service/remote/apis/movie_api.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApi _movieApi;

  MovieRepositoryImpl(this._movieApi);

  @override
  Future<Either<HttpFailure, Movie>> getMovieById(int id) {
    return _movieApi.getMovieById(id);
  }
}
