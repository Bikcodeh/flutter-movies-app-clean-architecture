import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/common/either/either.dart';
import '../../../../domain/common/failure/http/http_failure.dart';
import '../../../../domain/enums.dart';
import '../../../../domain/models/media/media.dart';
import '../../../../domain/repository/trending_repository.dart';
import 'trending_tile.dart';

typedef EitherListMedia = Either<HttpFailure, List<Media>>;

class TrendingList extends StatefulWidget {
  const TrendingList({super.key});

  @override
  State<TrendingList> createState() => _TrendingListState();
}

class _TrendingListState extends State<TrendingList> {
  late final Future<EitherListMedia> _future;

  @override
  void initState() {
    super.initState();
    final TrendingRepository trendingRepository = context.read();
    _future = trendingRepository.getMoviesAndSeries(TimeWindow.day);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
          ),
          child: Text(
            'TRENDING',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 16 / 8,
          child: LayoutBuilder(
            builder: (_, constraints) {
              final width = constraints.maxHeight * 0.65;
              return SizedBox(
                height: 200,
                child: FutureBuilder<EitherListMedia>(
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
