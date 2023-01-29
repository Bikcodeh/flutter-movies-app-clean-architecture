import '../../../../domain/common/typedef.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/media/media.dart';
import '../http/network.dart';

class TrendingApi {
  final Http _http;

  TrendingApi(this._http);

  getMoviesAndSeries(TimeWindow timeWindow) async {
    final result = await _http.request(
      '/trending/all/${timeWindow.name}',
      onSuccess: (json) {
        final list = json['result'] as List<Json>;
        return list
            .where((e) => e['media_type'] != 'person')
            .map((e) => Media.fromJson(e))
            .toList();
      },
    );
  }
}
