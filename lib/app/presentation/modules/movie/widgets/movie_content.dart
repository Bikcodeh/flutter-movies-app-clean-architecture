import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/models/movie/movie.dart';
import '../../../global/utils/utils.dart';

class MovieContent extends StatelessWidget {
  const MovieContent({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
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
          )
        ],
      ),
    );
  }
}
