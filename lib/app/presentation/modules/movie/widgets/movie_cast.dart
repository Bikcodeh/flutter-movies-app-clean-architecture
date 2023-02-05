import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/common/either/either.dart';
import '../../../../domain/common/failure/http/http_failure.dart';
import '../../../../domain/models/performer/performer.dart';
import '../../../../domain/repository/movie_repository.dart';
import '../../../global/utils/utils.dart';
import '../../../global/widgets/request_failed.dart';

class MovieCast extends StatefulWidget {
  const MovieCast({super.key, required this.movieId});
  final int movieId;

  @override
  State<MovieCast> createState() => _MovieCastState();
}

class _MovieCastState extends State<MovieCast> {
  late Future<Either<HttpFailure, List<Performer>>> _future;

  @override
  void initState() {
    super.initState();
    _initFuture();
  }

  void _initFuture() {
    _future = context.read<MovieRepository>().getCastByMovie(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<HttpFailure, List<Performer>>>(
      key: ValueKey(widget.movieId),
      future: _future,
      builder: ((context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return snapshot.data!.when(
          left: (_) => RequestFailed(onRetry: () {
            setState(() {
              _initFuture();
            });
          }),
          right: (performers) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Cast',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final performer = performers[index];
                      return Column(
                        children: [
                          Expanded(
                            child: LayoutBuilder(
                              builder: (_, constraints) {
                                final size = constraints.maxHeight;
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(size / 2),
                                  child: ExtendedImage.network(
                                    getImagePathUrl(performer.profilePath),
                                    height: size,
                                    width: size,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            performer.name,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    itemCount: performers.length,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
