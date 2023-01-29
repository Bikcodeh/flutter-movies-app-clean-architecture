import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/repository/trending_repository.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final TrendingRepository trendingRepository = context.read();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Center(
                child: FutureBuilder(
                  future: trendingRepository.getMoviesAndSeries(TimeWindow.day),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('ERROR');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return Text(snapshot.data.toString() ?? 'error que');
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
