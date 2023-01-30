import 'package:flutter/material.dart';

import '../widgets/movies_and_series/trending_list.dart';
import '../widgets/performers/trending_performers.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            TrendingList(),
            TrendingPerformers(),
          ],
        ),
      ),
    );
  }
}
