import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/media/media.dart';
import '../../../../../domain/models/performer/performer.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState({
    @Default(
      MoviesAndSeriesState.loading(true),
    )
        MoviesAndSeriesState moviesAndSeries,

    ///
    @Default(
      PerformersState.loading(true),
    )
        PerformersState performers,
  }) = _HomeState;
}

@freezed
class MoviesAndSeriesState with _$MoviesAndSeriesState {
  const factory MoviesAndSeriesState.loading(bool isLoading) =
      MoviesAndSeriesStateLoading;
  const factory MoviesAndSeriesState.error() = MoviesAndSeriesStateError;
  const factory MoviesAndSeriesState.success(
    List<Media> mediaList,
  ) = MoviesAndSeriesStateSuccess;
}

@freezed
class PerformersState with _$PerformersState {
  const factory PerformersState.loading(bool isLoading) =
      PerformersStateLoading;
  const factory PerformersState.failed() = PerformersStateFailed;
  const factory PerformersState.success(
    List<Performer> list,
  ) = PerformersStateSuccess;
}
