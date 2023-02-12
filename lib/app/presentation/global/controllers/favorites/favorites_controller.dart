import '../../../../domain/models/media/media.dart';
import '../../../../domain/repository/account_repository.dart';
import '../../base/state_notifier.dart';
import 'state/favorites_state.dart';

class FavoritesController extends StateNotifier<FavoritesState> {
  final AccountRepository accountRepository;
  FavoritesController(super.state, {required this.accountRepository});

  Future<void> getMoviesAndSeries() async {
    final moviesResult = await accountRepository.getFavorites(MediaType.movie);

    state = await moviesResult.when(
        left: (_) async => FavoritesState.error(),
        right: (movies) async {
          final seriesResult =
              await accountRepository.getFavorites(MediaType.tv);
          return seriesResult.when(
              left: (_) => FavoritesState.error(),
              right: (series) =>
                  FavoritesState.success(movies: movies, series: series));
        });
  }

  markAsFavorite(Media media) async {
    state.mapOrNull(success: (loadedState) async {
      final isMovie = media.type == MediaType.movie;
      final map = isMovie ? {...loadedState.movies} : {...loadedState.series};

      final isFavorite = !map.keys.contains(media.id);

      final result = await accountRepository.markAsFavorite(
        mediaId: media.id,
        mediaType: media.type!,
        favorite: !isFavorite,
      );

      result.whenOrNull(right: (_) {
        if (isFavorite) {
          map[media.id] = media;
        } else {
          map.remove(media.id);
        }
        state = isMovie
            ? loadedState.copyWith(movies: map)
            : loadedState.copyWith(series: map);
      });
    });
  }
}
