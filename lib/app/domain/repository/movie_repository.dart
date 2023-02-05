import '../common/either/either.dart';
import '../common/failure/http/http_failure.dart';
import '../models/movie/movie.dart';
import '../models/performer/performer.dart';

abstract class MovieRepository {
  Future<Either<HttpFailure, Movie>> getMovieById(int id);
  Future<Either<HttpFailure, List<Performer>>> getCastByMovie(int movieId);
}
