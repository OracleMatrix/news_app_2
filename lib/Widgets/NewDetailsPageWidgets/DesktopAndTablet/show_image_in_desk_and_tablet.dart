import 'package:flutter/material.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:provider/provider.dart';

class ShowDescriptionAndContentWithAuthorInDeskAndTablet
    extends StatelessWidget {
  const ShowDescriptionAndContentWithAuthorInDeskAndTablet({
    super.key,
    required this.description,
    required this.author,
    required this.content,
  });

  final String description, author, content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
              textDirection:
                  Provider.of<GetAllNewsApiProvider>(context).isRTL(description)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
            ),
            const Divider(),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
              textDirection:
                  Provider.of<GetAllNewsApiProvider>(context).isRTL(description)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                "Author: $author",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
