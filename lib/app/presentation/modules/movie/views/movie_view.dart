import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/favorites/favorites_controller.dart';
import '../../../global/widgets/request_failed.dart';
import '../controller/movie_controller.dart';
import '../controller/state/movie_state.dart';
import '../widgets/movie_app_bar.dart';
import '../widgets/movie_content.dart';

class MovieView extends StatelessWidget {
  const MovieView({super.key, required this.movieid});

  final int movieid;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieController(
        const MovieState.loading(),
        movieRepository: context.read(),
      )..getMovieById(movieid),
      builder: (context, _) {
        final MovieController movieController = context.watch();
        context.read<FavoritesController>().getMoviesAndSeries();
        return SafeArea(
          child: movieController.state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: () => Scaffold(
              appBar: AppBar(),
              body: RequestFailed(onRetry: () {}),
            ),
            success: (movie) => Scaffold(
              extendBodyBehindAppBar: true,
              appBar: MovieAppBar(movieId: movie.id),
              body: MovieContent(movie: movie),
            ),
          ),
        );
      },
    );
  }
}
