import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/common/either/either.dart';
import '../../../../../domain/common/failure/http/http_failure.dart';
import '../../../../../domain/enums.dart';
import '../../../../../domain/models/media/media.dart';
import '../../../../global/widgets/request_failed.dart';
import '../../controller/home_controller.dart';
import 'trending_tile.dart';
import 'trending_title_and_filter.dart';

typedef EitherListMedia = Either<HttpFailure, List<Media>>;

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  TimeWindow _timeWindow = TimeWindow.day;

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = context.watch();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: TrendingTitleAndFilter(
            timeWindow: _timeWindow,
            onTimeWindowChange: (newTimeWindow) => setState(() {
              _timeWindow = newTimeWindow;
              homeController.set(_timeWindow);
              homeController.fetch();
            }),
          ),
        ),
        const SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxHeight * 0.65;
              return Center(
                  child: homeController.state.when(
                error: () => RequestFailed(onRetry: () {
                  homeController.fetch();
                }),
                idle: () => const SizedBox(),
                loading: (isLoading) {
                  if (isLoading) {
                    return const CircularProgressIndicator();
                  }
                  return null;
                },
                success: (data) {
                  return Center(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.length,
                      itemBuilder: ((_, index) {
                        final item = data[index];
                        return TrendingTile(media: item, width: width);
                      }),
                      separatorBuilder: (_, __) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                    ),
                  );
                },
              ));
            },
          ),
        )
      ],
    );
  }
}
