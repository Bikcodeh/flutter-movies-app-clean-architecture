import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/common/either/either.dart';
import '../../../../../domain/common/failure/http/http_failure.dart';
import '../../../../../domain/models/performer/performer.dart';
import '../../../../../domain/repository/trending_repository.dart';
import 'perform_tile.dart';

typedef EitherPerformerList = Either<HttpFailure, List<Performer>>;

class TrendingPerformers extends StatefulWidget {
  const TrendingPerformers({super.key});

  @override
  State<TrendingPerformers> createState() => _TrendingPerformersState();
}

class _TrendingPerformersState extends State<TrendingPerformers> {
  late Future<EitherPerformerList> _future;
  @override
  void initState() {
    super.initState();
    _future = context.read<TrendingRepository>().getPerformers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<EitherPerformerList>(
      key: ValueKey(_future),
      future: _future,
      builder: (_, snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return snapshot.data!.when(
          left: (_) {
            return const Text('Error');
          },
          right: (performers) {
            return Expanded(
              child: PageView.builder(
                padEnds: false,
                itemCount: performers.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((_, index) {
                  final performer = performers[index];
                  return PerformerTile(performer: performer);
                }),
              ),
            );
          },
        );
      },
    );
  }
}
