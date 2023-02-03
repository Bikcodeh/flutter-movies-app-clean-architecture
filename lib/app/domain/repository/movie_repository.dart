import '../common/either/either.dart';
import '../common/failure/http/http_failure.dart';
import '../models/movie/movie.dart';

abstract class MovieRepository {
  Future<Either<HttpFailure, Movie>> getMovieById(int id);
}
