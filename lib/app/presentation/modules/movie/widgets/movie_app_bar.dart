import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/favorites/favorites_controller.dart';

class MovieAppBar extends StatelessWidget with PreferredSizeWidget {
  const MovieAppBar({super.key, required this.movieId});
  final int movieId;

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoritesController = context.watch()
      ..getMoviesAndSeries();
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: favoritesController.state.maybeMap(
        orElse: () => [const SizedBox()],
        success: (state) => [
          IconButton(
            onPressed: () {},
            icon: Icon(
              state.movies.containsKey(movieId)
                  ? Icons.favorite
                  : Icons.favorite_outline,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
