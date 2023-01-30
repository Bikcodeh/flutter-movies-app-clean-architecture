import 'package:freezed_annotation/freezed_annotation.dart';

import '../media/media.dart';

part 'performer.freezed.dart';
part 'performer.g.dart';

@freezed
class Performer with _$Performer {
  factory Performer({
    required int id,
    required String name,
    required double popularity,
    @JsonKey(name: 'original_name')
        required String originalName,
    @JsonKey(name: 'profile_path')
        required String profilePath,
    @JsonKey(
      name: 'known_for',
      fromJson: getMediaListPerformer,
    )
        required List<Media> knownFor,
  }) = _Performer;

  factory Performer.fromJson(Map<String, dynamic> json) =>
      _$PerformerFromJson(json);
}

List<Media> getMediaListPerformer(List json) {
  return json
      .where(
        (e) =>
            e['media_type'] == 'person' &&
            e['poster_path'] != null &&
            e['backdrop_path'] != null,
      )
      .map((e) => Media.fromJson(e))
      .toList();
}
