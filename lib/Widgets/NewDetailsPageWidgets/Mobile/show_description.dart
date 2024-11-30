import 'package:flutter/material.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:provider/provider.dart';

class ShowDescription extends StatelessWidget {
  const ShowDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          description,
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.justify,
          textDirection:
              Provider.of<GetAllNewsApiProvider>(context).isRTL(description)
                  ? TextDirection.rtl
                  : TextDirection.ltr,
        ),
      ),
    );
  }
}
