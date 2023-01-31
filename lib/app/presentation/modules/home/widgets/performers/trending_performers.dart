import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/common/either/either.dart';
import '../../../../../domain/common/failure/http/http_failure.dart';
import '../../../../../domain/models/performer/performer.dart';
import '../../../../../domain/repository/trending_repository.dart';
import '../../../../global/widgets/request_failed.dart';
import 'perform_tile.dart';

typedef EitherPerformerList = Either<HttpFailure, List<Performer>>;

class TrendingPerformers extends StatefulWidget {
  const TrendingPerformers({super.key});

  @override
  State<TrendingPerformers> createState() => _TrendingPerformersState();
}

class _TrendingPerformersState extends State<TrendingPerformers> {
  late Future<EitherPerformerList> _future;
  late final PageController pageController;
  @override
  void initState() {
    super.initState();
    _future = context.read<TrendingRepository>().getPerformers();
    pageController = PageController(
      viewportFraction: 0.8,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<EitherPerformerList>(
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
              return Center(
                child: RequestFailed(onRetry: () {
                  setState(() {
                    _future =
                        context.read<TrendingRepository>().getPerformers();
                  });
                }),
              );
            },
            right: (performers) {
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    controller: pageController,
                    itemCount: performers.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: ((_, index) {
                      final performer = performers[index];
                      return PerformerTile(performer: performer);
                    }),
                  ),
                  Positioned(
                      bottom: 30,
                      child: AnimatedBuilder(
                        animation: pageController,
                        builder: ((_, __) {
                          final int currentCard =
                              pageController.page?.toInt() ?? 0;
                          return Row(
                            children: List.generate(
                                performers.length,
                                (index) => Icon(
                                      Icons.circle,
                                      size: 14,
                                      color: currentCard == index
                                          ? Colors.blue
                                          : Colors.white30,
                                    )),
                          );
                        }),
                      )),
                  const SizedBox(height: 10),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
