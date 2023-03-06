import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/movie/movie.dart';
import '../../../global/controllers/favorites/favorites_controller.dart';
import '../../../global/utils/mark_as_favorite.dart';
import '../controller/movie_controller.dart';

class MovieAppBar extends StatelessWidget with PreferredSizeWidget {
  const MovieAppBar({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    final MovieController movieController = context.watch();
    final FavoritesController favoritesController = context.watch()
      ..getMoviesAndSeries();
    return AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: movieController.state.mapOrNull(
            success: (moviesState) => [
                  favoritesController.state.maybeMap(
                    orElse: () => const SizedBox(),
                    success: (favoritesState) => IconButton(
                      onPressed: () => markAsFavorite(
                        context: context,
                        media: moviesState.movie.toMedia(),
                        mounted: () => movieController.mounted,
                      ),
                      icon: Icon(
                        favoritesState.movies.containsKey(moviesState.movie.id)
                            ? Icons.favorite
                            : Icons.favorite_outline,
                      ),
                    ),
                  ),
                ]));
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
