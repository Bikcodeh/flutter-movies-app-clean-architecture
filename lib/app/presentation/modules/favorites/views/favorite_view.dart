import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../global/controllers/favorites/favorites_controller.dart';
import '../../../global/widgets/request_failed.dart';
import '../widgets/favorites_app_bar.dart';
import '../widgets/favorites_content.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FavoritesController favoritesController = context.watch()
      ..getMoviesAndSeries();
    return Scaffold(
      appBar: FavoritesAppBar(tabController: _tabController),
      body: favoritesController.state.maybeMap(
        orElse: () {
          return const SizedBox();
        },
        loading: (_) {
          return const Center(child: CircularProgressIndicator());
        },
        error: (_) {
          return RequestFailed(
            onRetry: (() {
              favoritesController.getMoviesAndSeries();
            }),
          );
        },
        success: ((value) => FavoritesContent(
            tabController: _tabController, favoritesStateSuccess: value)),
      ),
    );
  }
}
