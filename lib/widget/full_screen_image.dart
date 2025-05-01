import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImageOverlay extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageOverlay({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: InteractiveViewer(
        // Added for zoom and pan capabilities
        child: Center(
          child: CachedNetworkImage(
              imageUrl: imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error)),
        ),
      ),
    );
  }
}
