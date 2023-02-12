import 'package:flutter/material.dart';

class FavoritesAppBar extends StatelessWidget with PreferredSizeWidget {
  const FavoritesAppBar({super.key, required this.tabController});
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Favorites'),
      elevation: 0.5,
      bottom: TabBar(
        tabs: const [
          Tab(
            child: Text('Movies'),
          ),
          Tab(
            child: Text('Series'),
          ),
        ],
        controller: tabController,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight * 2);
}
