import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/common/either/either.dart';
import '../../../../domain/common/failure/http/http_failure.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/repository/trending_repository.dart';
import 'trending_tile.dart';
import 'trending_title_and_filter.dart';

typedef EitherListMedia = Either<HttpFailure, List<Media>>;

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  late Future<EitherListMedia> _future;
  TimeWindow _timeWindow = TimeWindow.day;
  TrendingRepository get trendingRepository => context.read();

  @override
  void initState() {
    super.initState();
    _future = trendingRepository.getMoviesAndSeries(_timeWindow);
  }

  @override
  Widget build(BuildContext context) {
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
              _future = trendingRepository.getMoviesAndSeries(_timeWindow);
            }),
          ),
        ),
        const SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(
            builder: (_, constraints) {
              final width = constraints.maxHeight * 0.65;
              return Center(
                child: FutureBuilder<EitherListMedia>(
                  key: ValueKey(_future),
                  future: _future,
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return snapshot.data!.when(
                      left: (failure) => Text(failure.toString()),
                      right: (items) {
                        return Center(
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            scrollDirection: Axis.horizontal,
                            itemCount: items.length,
                            itemBuilder: ((_, index) {
                              final item = items[index];
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
                    );
                  }),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
