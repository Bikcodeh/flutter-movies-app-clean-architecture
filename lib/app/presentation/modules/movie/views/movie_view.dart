import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/widgets/request_failed.dart';
import '../controller/movie_controller.dart';
import '../controller/state/movie_state.dart';

class MovieView extends StatelessWidget {
  const MovieView({super.key, required this.movieid});

  final int movieid;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MovieController(
        MovieState.loading(),
        movieRepository: context.read(),
      )..getMovieById(movieid),
      builder: (context, _) {
        final MovieController movieController = context.watch();
        return Scaffold(
          appBar: AppBar(),
          body: movieController.state.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: () => RequestFailed(onRetry: () {}),
              success: (movie) => const Text('Movie')),
        );
      },
    );
  }
}
