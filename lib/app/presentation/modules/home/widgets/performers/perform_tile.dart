import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/models/performer/performer.dart';
import '../../../../global/utils/utils.dart';
import '../movies_and_series/trending_tile.dart';

class PerformerTile extends StatelessWidget {
  const PerformerTile({
    super.key,
    required this.performer,
  });
  final Performer performer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          children: [
            Positioned.fill(
              child: ExtendedImage.network(
                getImagePathUrl(
                  performer.profilePath,
                  imageQuality: ImageQuality.original,
                ),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.all(14).copyWith(bottom: 40),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      performer.name != performer.originalName
                          ? performer.name
                          : performer.originalName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (performer.knownFor.isNotEmpty)
                      SizedBox(
                        height: 150,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: performer.knownFor
                              .take(3)
                              .map(
                                (media) => TrendingTile(
                                  media: media,
                                  width: 120 * 0.7,
                                  showData: false,
                                ),
                              )
                              .toList(),
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
