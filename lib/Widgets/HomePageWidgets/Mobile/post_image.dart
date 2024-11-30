import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_2/Constants/constants.dart';

class PostImageWidget extends StatelessWidget {
  final String? imageUrl;
  const PostImageWidget({
    super.key,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ?? placeHolderImage,
      errorWidget: (context, url, error) =>
          CachedNetworkImage(imageUrl: placeHolderImage),
      progressIndicatorBuilder: (context, url, progress) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: CircularProgressIndicator(
              value: progress.progress,
            ),
          ),
        );
      },
    );
  }
}
