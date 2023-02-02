import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/common/either/either.dart';
import '../../../../../domain/common/failure/http/http_failure.dart';
import '../../../../../domain/models/performer/performer.dart';
import '../../../../global/widgets/request_failed.dart';
import '../../controller/home_controller.dart';
import 'perform_tile.dart';

typedef EitherPerformerList = Either<HttpFailure, List<Performer>>;

class TrendingPerformers extends StatefulWidget {
  const TrendingPerformers({super.key});

  @override
  State<TrendingPerformers> createState() => _TrendingPerformersState();
}

class _TrendingPerformersState extends State<TrendingPerformers> {
  late final PageController pageController;
  @override
  void initState() {
    super.initState();
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
    final HomeController homeController = context.watch();
    return Expanded(
        child: homeController.state.performers.when(
            loading: ((isLoading) {
              if (isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return const SizedBox();
            }),
            failed: () => RequestFailed(onRetry: () async {
                  homeController.getPerformers();
                }),
            success: ((performers) => Stack(
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
                ))));
  }
}
