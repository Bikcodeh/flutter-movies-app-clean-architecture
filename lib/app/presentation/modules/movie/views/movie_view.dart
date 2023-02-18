import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      create: (context) => MovieController(
        const MovieState.loading(),
        movieRepository: context.read(),
      )..getMovieById(movieid),
      builder: (context, _) {
        MovieController movieController = context.watch();
        return SafeArea(
          child: movieController.state.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: () => Scaffold(
              appBar: AppBar(),
              body: RequestFailed(onRetry: () {}),
            ),
            success: (movie) => Scaffold(
              extendBodyBehindAppBar: true,
              appBar: MovieAppBar(movie: movie),
              body: MovieContent(movie: movie),
            ),
          ),
        );
      },
    );
  }
}
