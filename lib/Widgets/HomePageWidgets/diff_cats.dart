import 'package:flutter/material.dart';
import 'package:news_app_2/Widgets/methods.dart';

class ShowDifferentCategories extends StatelessWidget {
  const ShowDifferentCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            buildCategoryItem(context, "economy"),
            buildCategoryItem(context, "gaming"),
            buildCategoryItem(context, "business"),
            buildCategoryItem(context, "sports"),
            buildCategoryItem(context, "technology"),
            buildCategoryItem(context, "general"),
            buildCategoryItem(context, "health"),
            buildCategoryItem(context, "science"),
            buildCategoryItem(context, "entertainment"),
          ],
        ),
      ),
    );
  }
}
