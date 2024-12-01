import 'package:flutter/material.dart';
import 'package:news_app_2/Providers/open_file_provider.dart';
import 'package:news_app_2/Widgets/NewDetailsPageWidgets/DesktopAndTablet/open_source_in_desk_tablet.dart';
import 'package:news_app_2/Widgets/NewDetailsPageWidgets/DesktopAndTablet/show_image_in_desk_and_tablet.dart';
import 'package:news_app_2/Widgets/NewDetailsPageWidgets/Mobile/mobile_app_bar.dart';
import 'package:news_app_2/Widgets/NewDetailsPageWidgets/Mobile/show_image.dart';
import 'package:provider/provider.dart';

class NewsDetailPageDesktopAndTablet extends StatelessWidget {
  final String author, description, imageUrl, url, source, title, content;
  final DateTime dateTime;

  const NewsDetailPageDesktopAndTablet({
    super.key,
    required this.author,
    required this.imageUrl,
    required this.url,
    required this.dateTime,
    required this.source,
    required this.description,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ShowAppBar(title: title, url: url),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Consumer<OpenFileProvider>(
                          builder: (context, provider, child) =>
                              provider.isOpening != true
                                  ? ShowImage(imageUrl: imageUrl)
                                  : const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    ),
                        ),
                      ),
                      ShowDescriptionAndContentWithAuthorInDeskAndTablet(
                        description: description,
                        author: author,
                        content: content,
                      ),
                    ],
                  ),
                  OpenSourceUrlDeskAndTablet(
                      screenSize: screenSize, url: url, source: source),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
