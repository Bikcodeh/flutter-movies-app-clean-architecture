import '../../../../domain/repository/movie_repository.dart';
import '../../../global/base/state_notifier.dart';
import 'state/movie_state.dart';

class MovieController extends StateNotifier<MovieState> {
  final MovieRepository movieRepository;
  MovieController(super.state, {required this.movieRepository});

  Future<void> getMovieById(int id) async {
    final result = await movieRepository.getMovieById(id);

    state = result.when(
        left: (_) => const MovieState.error(),
        right: (movie) => MovieState.success(movie));
  }
}
