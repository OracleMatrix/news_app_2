import 'package:flutter/material.dart';
import 'package:news_app_2/Providers/get_all_news_api_provider.dart';
import 'package:provider/provider.dart';

Widget buildCategoryItem(BuildContext context, String category, String emoji) {
  return InkWell(
    borderRadius: BorderRadius.circular(12),
    onTap: () {
      Provider.of<GetAllNewsApiProvider>(context, listen: false)
          .fetchAllNews(query: category);
      Provider.of<GetAllNewsApiProvider>(context, listen: false).reset();
      Provider.of<GetAllNewsApiProvider>(context, listen: false)
          .controller
          .clear();
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        // color: Colors.grey[500],
      ),
      alignment: Alignment.center,
      child: Text(
        "$category $emoji",
        // style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}
