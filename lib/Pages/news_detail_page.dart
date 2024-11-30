import 'package:flutter/material.dart';
import 'package:news_app_2/Providers/open_file_provider.dart';
import 'package:news_app_2/Widgets/NewDetailsPageWidgets/Mobile/mobile_app_bar.dart';
import 'package:news_app_2/Widgets/NewDetailsPageWidgets/Mobile/open_source_url.dart';
import 'package:news_app_2/Widgets/NewDetailsPageWidgets/Mobile/show_author.dart';
import 'package:news_app_2/Widgets/NewDetailsPageWidgets/Mobile/show_description.dart';
import 'package:news_app_2/Widgets/NewDetailsPageWidgets/Mobile/show_image.dart';
import 'package:provider/provider.dart';

class NewsDetailPage extends StatelessWidget {
  final String imageUrl, url, source, title, description, author;
  final DateTime dateTime;

  const NewsDetailPage({
    super.key,
    required this.imageUrl,
    required this.url,
    required this.dateTime,
    required this.source,
    required this.title,
    required this.description,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ShowAppBar(title: title, url: url),
          SliverToBoxAdapter(
            child: Consumer<OpenFileProvider>(
              builder: (context, provider, child) => provider.isOpening != true
                  ? ShowImage(imageUrl: imageUrl)
                  : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
            ),
          ),
          ShowDescription(description: description),
          SliverToBoxAdapter(
            child: ShowAuthor(author: author),
          ),
          SliverToBoxAdapter(
            child:
                OpenSourceUrl(screenSize: screenSize, url: url, source: source),
          )
        ],
      ),
    );
  }
}
