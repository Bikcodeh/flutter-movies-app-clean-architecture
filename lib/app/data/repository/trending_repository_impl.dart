import '../../domain/common/either/either.dart';
import '../../domain/common/failure/http/http_failure.dart';
import '../../domain/enums.dart';
import '../../domain/models/media/media.dart';
import '../../domain/models/performer/performer.dart';
import '../../domain/repository/trending_repository.dart';
import '../service/remote/apis/trending_api.dart';

class TrendingRepositoryImpl implements TrendingRepository {
  final TrendingApi _trendingApi;

  TrendingRepositoryImpl(this._trendingApi);

  @override
  Future<Either<HttpFailure, List<Media>>> getMoviesAndSeries(
      TimeWindow timeWindow) {
    return _trendingApi.getMoviesAndSeries(timeWindow);
  }

  @override
  Future<Either<HttpFailure, List<Performer>>> getPerformers() {
    return _trendingApi.getPerformers(TimeWindow.day);
  }
}
