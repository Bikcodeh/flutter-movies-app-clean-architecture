import 'package:flutter/material.dart';

import '../../../../domain/models/movie/movie.dart';
import 'movie_header.dart';

class MovieContent extends StatelessWidget {
  const MovieContent({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          MovieHeader(movie: movie),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 16),
            child: Text(movie.overview),
          )
        ],
      ),
    );
  }
}
