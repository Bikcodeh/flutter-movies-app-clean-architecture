import '../../../../domain/common/either/either.dart';
import '../../../../domain/common/failure/http/http_failure.dart';
import '../../../../domain/common/typedef.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/media/media.dart';
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
        print('🤡 ${list.toString()}');
        return list
            .where(
              (e) =>
                  e['media_type'] != 'person' &&
                  e['poster_path'] != null &&
                  e['backdrop_path'] != null,
            )
            .map((e) => Media.fromJson(e))
            .toList();
      },
    );
  }
}
