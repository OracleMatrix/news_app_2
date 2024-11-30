import 'package:flutter/material.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/Mobile/post_image.dart';
import 'package:news_app_2/Widgets/HomePageWidgets/Mobile/post_list_tile.dart';
import 'package:provider/provider.dart';

class PostCardWidgetTablet extends StatelessWidget {
  final int index;
  final GetAllNewsApiProvider api;

  const PostCardWidgetTablet({
    super.key,
    required this.index,
    required this.api,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Selector<GetAllNewsApiProvider, String?>(
                selector: (_, provider) => provider.articles[index].urlToImage,
                builder: (context, imageUrl, child) {
                  return SizedBox(
                    width: 300,
                    child: PostImageWidget(
                      imageUrl: imageUrl,
                    ),
                  );
                },
              ),
              Expanded(child: PostsListTileWidget(index: index, api: api)),
            ],
          ),
        ],
      ),
    );
  }
}
