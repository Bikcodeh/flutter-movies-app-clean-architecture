import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/movie/movie.dart';
import '../../../global/utils/utils.dart';

class MovieHeader extends StatelessWidget {
  const MovieHeader({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AspectRatio(
        aspectRatio: 16 / 13,
        child: ExtendedImage.network(
          getImagePathUrl(
            movie.backdropPath ?? movie.posterPath,
            imageQuality: ImageQuality.original,
          ),
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        left: 0,
        bottom: 0,
        right: 0,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black45, Colors.black],
            ),
          ),
          padding: const EdgeInsets.all(15).copyWith(top: 25),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      children: movie.genres
                          .map((e) => Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(color: Colors.white)),
                                child: Text(
                                  e.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList(),
                    )
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: CircularProgressIndicator(
                      value: (movie.voteAverage / 10).clamp(0.0, 1.0),
                    ),
                  ),
                  Text(
                    movie.voteAverage.toStringAsFixed(1),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      )
    ]);
  }
}
