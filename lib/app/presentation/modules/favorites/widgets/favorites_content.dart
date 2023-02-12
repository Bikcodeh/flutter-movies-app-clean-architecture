import 'package:flutter/material.dart';

import '../../../global/controllers/favorites/state/favorites_state.dart';
import 'favorites_list.dart';

class FavoritesContent extends StatelessWidget {
  final TabController tabController;
  final FavoritesStateSuccess favoritesStateSuccess;

  const FavoritesContent(
      {super.key,
      required this.tabController,
      required this.favoritesStateSuccess});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: [
        FavoritesList(items: favoritesStateSuccess.movies.values.toList()),
        FavoritesList(items: favoritesStateSuccess.series.values.toList()),
      ],
    );
  }
}
