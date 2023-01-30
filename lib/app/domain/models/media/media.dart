import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/typedef.dart';

part 'media.freezed.dart';
part 'media.g.dart';

@freezed
class Media with _$Media {
  factory Media({
    required int id,
    required String overview,
    @JsonKey(readValue: readTitleValue) required String title,
    @JsonKey(readValue: readOriginalTitleValue) required String originalTitle,
    @JsonKey(name: 'poster_path') required String posterPath,
    @JsonKey(name: 'backdrop_path') required String backdropPath,
    @JsonKey(name: 'vote_average') required double voteAverage,
    @JsonKey(name: 'media_type') required MediaType type,
  }) = _Media;

  factory Media.fromJson(Json json) => _$MediaFromJson(json);
}

Object? readTitleValue(Map map, String _) {
  return map['title'] ?? map['name'];
}

Object? readOriginalTitleValue(Map map, String _) {
  return map['original_title'] ?? map['original_name'];
}

enum MediaType {
  @JsonValue('movie')
  movie,
  @JsonValue('tv')
  tv,
}

List<Media> getMediaList(List json) {
  return json
      .where(
        (e) =>
            e['media_type'] != 'person' &&
            e['poster_path'] != null &&
            e['backdrop_path'] != null,
      )
      .map((e) => Media.fromJson(e))
      .toList();
}
