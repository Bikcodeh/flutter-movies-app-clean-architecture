import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/movie/movie.dart';

part 'movie_state.freezed.dart';

@freezed
class MovieState with _$MovieState {
  const factory MovieState.loading() = MovieStateLoading;
  const factory MovieState.error() = MovieStateError;
  const factory MovieState.success(Movie movie) = MovieStateSuccess;
}
