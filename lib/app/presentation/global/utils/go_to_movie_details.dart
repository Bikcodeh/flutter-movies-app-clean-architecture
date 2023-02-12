import 'package:flutter/material.dart';

import '../../../domain/models/media/media.dart';
import '../../modules/movie/views/movie_view.dart';

Future<void> goToDetails(BuildContext context, Media item) async {
  if (item.type == MediaType.movie) {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: ((context) => MovieView(movieid: item.id)),
      ),
    );
  }
}
