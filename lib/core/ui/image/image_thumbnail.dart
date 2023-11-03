import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peregrino/core/ui/image/image_placeholder.dart';

class ImageThumbnail extends StatelessWidget {
  const ImageThumbnail({
    required this.imageUrl,
    required this.backgroundImageUrl,
    super.key,
  });

  final String imageUrl;
  final String backgroundImageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: CachedNetworkImageProvider(backgroundImageUrl),
              fit: BoxFit.none,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            height: double.infinity,
            width: 90,
            errorWidget: (_, __, ___) => const ImagePlaceholder(),
          ),
        ),
      ],
    );
  }
}
