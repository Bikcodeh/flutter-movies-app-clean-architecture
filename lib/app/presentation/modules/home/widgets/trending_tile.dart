import 'package:flutter/material.dart';

import '../../../../domain/models/media/media.dart';
import '../../../global/utils/utils.dart';

class TrendingTile extends StatelessWidget {
  const TrendingTile({
    super.key,
    required this.media,
    required this.width,
  });
  final Media media;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: width,
        child: Stack(children: [
          Positioned.fill(
            child: Image.network(
              getImagePathUrl(media.posterPath),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Opacity(
              opacity: 0.7,
              child: Column(
                children: [
                  Chip(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    label: Text(media.voteAverage.toStringAsFixed(1)),
                  ),
                  const SizedBox(height: 4),
                  Chip(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      label: Icon(
                        media.type == MediaType.movie ? Icons.movie : Icons.tv,
                        size: 15,
                      )),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
