import '../common/either/either.dart';
import '../common/failure/http/http_failure.dart';
import '../enums.dart';
import '../models/media/media.dart';

abstract class TrendingRepository {
  Future<Either<HttpFailure, List<Media>>> getMoviesAndSeries(
    TimeWindow timeWindow,
  );
}
