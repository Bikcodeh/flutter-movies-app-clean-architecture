import '../../../../domain/common/either/either.dart';
import '../../../../domain/common/failure/http/http_failure.dart';
import '../../../../domain/common/typedef.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/models/performer/performer.dart';
import '../http/network.dart';

class TrendingApi {
  final Http _http;

  TrendingApi(this._http);

  Future<Either<HttpFailure, List<Media>>> getMoviesAndSeries(
    TimeWindow timeWindow,
  ) async {
    return await _http.request(
      '/trending/all/${timeWindow.name}',
      onSuccess: (json) {
        final list = List<Json>.from(json['results']);
        return getMediaList(list);
      },
    );
  }

  Future<Either<HttpFailure, List<Performer>>> getPerformers(
    TimeWindow timeWindow,
  ) async {
    return await _http.request(
      '/trending/person/${timeWindow.name}',
      onSuccess: (json) {
        final list = List<Json>.from(json['results']);
        return list
            .where((e) => e['known_for_department'] == 'Acting')
            .map((e) => Performer.fromJson(e))
            .toList();
      },
    );
  }
}
