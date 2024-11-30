import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_2/Constants/constants.dart';
import 'package:news_app_2/Providers/open_file_provider.dart';
import 'package:provider/provider.dart';

class ShowImage extends StatelessWidget {
  const ShowImage({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Provider.of<OpenFileProvider>(context, listen: false)
            .openFile(imageUrl, imageUrl, context);
      },
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        errorWidget: (context, url, error) => CachedNetworkImage(
          imageUrl: placeHolderImage,
        ),
        progressIndicatorBuilder: (context, url, progress) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: CircularProgressIndicator(
              value: progress.progress,
            ),
          ),
        ),
      ),
    );
  }
}
