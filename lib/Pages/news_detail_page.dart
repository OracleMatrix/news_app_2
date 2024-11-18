import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_2/Constants/constants.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:news_app_2/Providers/open_file_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatelessWidget {
  final String author, content, imageUrl, url, source;
  final DateTime dateTime;
  const NewsDetailPage({
    super.key,
    required this.author,
    required this.content,
    required this.imageUrl,
    required this.url,
    required this.dateTime,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                onPressed: () => Share.share(url),
                icon: const Icon(Icons.ios_share_rounded),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Consumer<OpenFileProvider>(
              builder: (context, provider, child) => provider.isOpening != true
                  ? GestureDetector(
                      onTap: () async {
                        await Provider.of<OpenFileProvider>(context,
                                listen: false)
                            .openFile(imageUrl, imageUrl, context);
                      },
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        errorWidget: (context, url, error) =>
                            CachedNetworkImage(
                          imageUrl: placeHolderImage,
                        ),
                        progressIndicatorBuilder: (context, url, progress) =>
                            Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator(
                              value: progress.progress,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                content,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
                textDirection:
                    Provider.of<GetAllNewsApiProvider>(context).isRTL(content)
                        ? TextDirection.rtl
                        : TextDirection.ltr,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              leading: const Icon(
                Icons.person,
              ),
              title: Text(
                "Author: $author",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: screenSize.width * 0.6,
                child: ElevatedButton(
                  onPressed: () async {
                    final Uri uri = Uri.parse(url);
                    if (!await launchUrl(uri)) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.orange,
                          content: Text(
                              'Failed to launch URL!\n Check your internet or try again!'),
                        ),
                      );
                    }
                  },
                  child: Text("read this from $source"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
