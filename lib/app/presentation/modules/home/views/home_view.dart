import 'package:flutter/material.dart';

import '../widgets/trending_list.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: const [
            TrendingList(),
          ],
        ),
      ),
    );
  }
}
