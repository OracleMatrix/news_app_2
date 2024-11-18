import 'package:flutter/material.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostsListTileWidget extends StatelessWidget {
  final GetAllNewsApiProvider api;
  final int index;
  const PostsListTileWidget({
    super.key,
    required this.index,
    required this.api,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Selector<GetAllNewsApiProvider, String?>(
        selector: (_, provider) => provider.articles[index].description,
        builder: (context, description, child) {
          return Text(
            description ?? '',
            textAlign: TextAlign.justify,
            textDirection:
                api.isRTL(description) ? TextDirection.rtl : TextDirection.ltr,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
      subtitle: Selector<GetAllNewsApiProvider, String?>(
        selector: (_, provider) => provider.articles[index].source?.name,
        builder: (context, source, child) {
          final publishedDate =
              context.read<GetAllNewsApiProvider>().articles[index].publishedAt;
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Source: ${source ?? "Unknown"}"),
                Text(
                  timeago.format(
                    publishedDate ?? DateTime.now(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
