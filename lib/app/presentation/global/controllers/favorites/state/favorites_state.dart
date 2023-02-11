import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../domain/models/media/media.dart';

part 'favorites_state.freezed.dart';

@freezed
class FavoritesState with _$FavoritesState {
  factory FavoritesState.loading() = FavoritesStateLoadind;
  factory FavoritesState.error() = FavoritesStateError;
  factory FavoritesState.success({
    required Map<int, Media> movies,
    required Map<int, Media> series,
  }) = FavoritesStateSuccess;
}
