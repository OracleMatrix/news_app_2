import 'package:flutter/material.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ShowAppBar extends StatelessWidget {
  const ShowAppBar({
    super.key,
    required this.title,
    required this.url,
  });

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Consumer<GetAllNewsApiProvider>(
        builder: (context, value, child) => Text(
          title,
          textDirection:
          value.isRTL(title) ? TextDirection.rtl : TextDirection.ltr,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () => Share.share(url),
          icon: const Icon(Icons.ios_share_rounded),
        ),
      ],
    );
  }
}